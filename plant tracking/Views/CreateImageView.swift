//
//  CreateImagesView.swift
//  plant tracking
//
//  Created by Oscar Gomez on 30/7/25.
//

import Foundation
import PhotosUI
import SwiftData
import SwiftUI

struct CreateImageView: View {
    @Environment(\.modelContext) private var context

    let plant: Plant

    @State private var description: String = ""
    @State private var selectedImage: UIImage?
    @State private var showingImagePicker = false
    @State private var dateTaken: Date = Date()

    var body: some View {
        Form {
            Section {
                HStack {
                    Button("Select Image", systemImage: "camera") {
                        showingImagePicker = true
                    }
                }

                if let selectedImage = selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 300)
                        .cornerRadius(8)
                        .padding(.vertical)
                }
            }

            Section {
                VStack {
                    DatePicker(
                        "Date Taken",
                        selection: $dateTaken,
                        displayedComponents: .date
                    )
                    .padding()

                    Text("Description")
                        .padding()

                    TextEditor(text: $description)
                        .frame(height: 300)
                        .border(Color.gray)
                        .padding()
                }
            }
        }
        .navigationTitle("Add new image")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Add", systemImage: "plus.circle") {
                    guard let selectedImage = selectedImage,
                        let imageData = selectedImage.jpegData(
                            compressionQuality: 0.8
                        )
                    else {
                        print(
                            "No image selected or failed to convert image to Data."
                        )
                        return
                    }
                    let newImage = PlantImage(
                        plant: plant,
                        date: dateTaken,
                        image: imageData,
                        description: description
                    )
                    do {
                        context.insert(newImage)
                        try context.save()
                    } catch {
                        print(
                            "Error saving image: \(error.localizedDescription)"
                        )
                    }
                }
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(selectedImage: $selectedImage)
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.dismiss) private var dismiss

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(
        _ uiViewController: UIImagePickerController,
        context: Context
    ) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate,
        UINavigationControllerDelegate
    {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController
                .InfoKey: Any]
        ) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.dismiss()
        }
    }
}

#Preview {
    CreateImageView(plant: Plant(name: "Prueba", datePlanted: Date()))
}
