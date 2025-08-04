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
    
    private var hasChanges: Bool {
        descript != (image.descript ?? "")
    }
    
    init(image: PlantImage) {
        self.image = image
        _descript = State(initialValue: image.descript ?? "")
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(image.date, style: .date)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                if let uiImage = UIImage(data: image.image) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 300)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                TextField("Description", text: $descript)
                    .font(.body)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .foregroundColor(.primary)
                    .padding(.horizontal)
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
                        context.delete(image)
                        do {
                            try context.save()
                            dismiss()
                        } catch {
                            print("error deleting image: \(error)")
                        }
                    }
                    Button("Cancel", role: .cancel) {}
                }
            }
            .padding()
            .navigationTitle("Image Details")
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button("Edit", systemImage: "pencil.circle") {
                        image.descript = descript.isEmpty ? nil : descript
                        do {
                            try context.save()
                        } catch {
                            print("error saving image: \(error)")
                        }
                    }
                    .disabled(!hasChanges)
                }
            }
        }
    }
}
