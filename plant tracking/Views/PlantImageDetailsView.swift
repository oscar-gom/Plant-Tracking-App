//
//  PlantImageDetailsView.swift
//  plant tracking
//
//  Created by Oscar Gomez on 4/8/25.
//

import Foundation
import SwiftData
import SwiftUI

struct PlantImageDetailsView: View {
    let image: PlantImage

    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State private var descript: String
    @State private var showDeleteConfirmation = false
    @State private var showingImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var errorMessage: String? = nil

    private var hasChanges: Bool {
        descript != (image.descript ?? "") || selectedImage != nil
    }

    init(image: PlantImage) {
        self.image = image
        _descript = State(initialValue: image.descript ?? "")
    }

    // Error control logic
    private func validateFields() -> String? {
        if descript.trimmingCharacters(in: .whitespaces).isEmpty {
            return "Description is required."
        }
        return nil
    }
    
    private func handleEdit() {
        errorMessage = validateFields()
        guard errorMessage == nil else { return }
        
        // Update image if a new one was selected
        if let selectedImage = selectedImage,
           let imageData = selectedImage.jpegData(compressionQuality: 0.8) {
            image.image = imageData
        }
        
        image.descript = descript.isEmpty ? nil : descript
        do {
            try context.save()
            self.selectedImage = nil
        } catch {
            errorMessage = "Error saving image: \(error.localizedDescription)"
        }
    }
    
    private func handleDelete() {
        errorMessage = nil
        context.delete(image)
        do {
            try context.save()
            dismiss()
        } catch {
            errorMessage = "Error deleting image: \(error.localizedDescription)"
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(image.date, style: .date)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                
                // Display gallery image or selected image
                Button(action: {
                    showingImagePicker = true
                }) {
                    if let selectedImage = selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: 300)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.blue, lineWidth: 2)
                            )
                    } else if let uiImage = UIImage(data: image.image) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: 300)
                            .cornerRadius(8)
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.horizontal)
                
                Text("Tap image to change")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                
                TextField("Description", text: $descript)
                    .font(.body)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .foregroundColor(.primary)
                    .padding(.horizontal)
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.horizontal)
                }
                
                Spacer(minLength: 24)
                
                Button(action: {
                    showDeleteConfirmation = true
                }) {
                    Label("Delete Image", systemImage: "trash")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                }
                .alert(
                    "Are you sure you want to delete this image?",
                    isPresented: $showDeleteConfirmation
                ) {
                    Button("Delete", role: .destructive) {
                        handleDelete()
                    }
                    Button("Cancel", role: .cancel) {}
                }
            }
            .padding()
        }
        .navigationTitle("Image Details")
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button("Edit", systemImage: "pencil.circle") {
                    handleEdit()
                }
                .disabled(!hasChanges)
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(selectedImage: $selectedImage)
        }
    }
}
