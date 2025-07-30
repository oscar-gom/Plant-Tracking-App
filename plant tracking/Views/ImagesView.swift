//
//  ImagesView.swift
//  plant tracking
//
//  Created by Oscar Gomez on 30/7/25.
//
import Foundation
import SwiftData
import SwiftUI

struct ImagesView: View {
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
            List(filteredImages) { image in
                VStack(alignment: .leading, spacing: 8) {
                    Text(image.date, style: .date)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    if let uiImage = UIImage(data: image.image) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: 200)
                            .cornerRadius(8)
                    }
                    
                    Text(image.descript ?? "")
                        .font(.body)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .foregroundColor(.primary)
                }
                .padding(.vertical, 8)
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
    ImagesView(plant: Plant(name: "Prueba", datePlanted: Date()))
}
