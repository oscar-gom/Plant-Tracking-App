//
//  ImagesView.swift
//  plant tracking
//
//  Created by Oscar Gomez on 30/7/25.
//
import Foundation
import SwiftData
import SwiftUI

struct PlantImagesView: View {
    let plant: Plant

    @Environment(\.modelContext) private var context

    @State private var showingCreateImageView = false

    @Query private var images: [PlantImage]

    var filteredImages: [PlantImage] {
        images.filter { $0.plant == plant }
    }

    init(plant: Plant) {
        self.plant = plant
    }

    // If there are no images, show an empty state view with a button to add the first photo
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Image(systemName: "photo.on.rectangle")
                .font(.system(size: 60))
                .foregroundColor(.gray.opacity(0.6))
            
            Text("No Images Yet")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            Text("Start documenting \(plant.name)'s growth by adding your first photo!")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Button(action: {
                showingCreateImageView = true
            }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Add First Photo")
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.green)
                .cornerRadius(12)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
    
    private var imagesListView: some View {
        List {
            ForEach(filteredImages) { image in
                imageRowView(for: image)
            }
            .onDelete(perform: deleteImages)
        }
    }
    
    private func imageRowView(for image: PlantImage) -> some View {
        NavigationLink(destination: PlantImageDetailsView(image: image)) {
            VStack(alignment: .leading, spacing: 8) {
                imageDateView(for: image)
                imageContentView(for: image)
                imageDescriptionView(for: image)
            }
            .padding()
        }
    }
    
    private func imageDateView(for image: PlantImage) -> some View {
        Text(image.date, style: .date)
            .font(.caption)
            .foregroundColor(.secondary)
            .padding(.horizontal)
    }
    
    private func imageContentView(for image: PlantImage) -> some View {
        Group {
            if let uiImage = UIImage(data: image.image) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 200)
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
        }
    }
    
    private func imageDescriptionView(for image: PlantImage) -> some View {
        Text(image.descript ?? "")
            .font(.body)
            .lineLimit(1)
            .truncationMode(.tail)
            .foregroundColor(.primary)
            .padding(.horizontal)
    }
    
    private func deleteImages(at indexes: IndexSet) {
        for index in indexes {
            context.delete(filteredImages[index])
        }
    }

    var body: some View {
        Group {
            if filteredImages.isEmpty {
                emptyStateView
            } else {
                imagesListView
            }
        }
        .navigationTitle("\(plant.name)'s Images")
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button("Add", systemImage: "plus.circle") {
                    showingCreateImageView = true
                }
                .sheet(isPresented: $showingCreateImageView) {
                    NavigationStack {
                        CreateImageView(plant: plant)
                            .presentationDetents([.height(600)])
                    }
                }
            }
        }
    }
}

#Preview {
    PlantImagesView(plant: Plant(name: "Prueba", datePlanted: Date()))
}
