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

    var body: some View {
        VStack {
            List {
                ForEach(filteredImages) { image in
                    NavigationLink(destination: PlantImageDetailsView(image: image)) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(image.date, style: .date)
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .padding(.horizontal)
                            
                            if let uiImage = UIImage(data: image.image) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxHeight: 200)
                                    .cornerRadius(8)
                                    .padding(.horizontal)
                            }
                            
                            Text(image.descript ?? "")
                                .font(.body)
                                .lineLimit(1)
                                .truncationMode(.tail)
                                .foregroundColor(.primary)
                                .padding(.horizontal)
                        }
                        .padding()
                    }
                }
                .onDelete { indexes in
                    for index in indexes {
                        context.delete(filteredImages[index])
                    }
                }
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
