//
//  PlantView.swift
//  plant tracking
//
//  Created by Oscar Gomez on 24/7/25.
//

import Foundation
import SwiftData
import SwiftUI

struct PlantView: View {
    let plant: Plant

    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @State private var name: String
    @State private var species: String
    @State private var height: Double
    @State private var datePlanted: Date
    @State private var location: String
    @State private var waterFrequency: String
    @State private var showDeleteConfirmation = false

    private var hasChanges: Bool {
        name != plant.name || species != (plant.species ?? "")
            || datePlanted != plant.datePlanted
            || location != (plant.location ?? "")
            || height != (plant.height ?? 0)
            || waterFrequency != (plant.waterFrequency ?? "")
    }

    init(plant: Plant) {
        self.plant = plant
        _name = State(initialValue: plant.name)
        _species = State(initialValue: plant.species ?? "")
        _datePlanted = State(initialValue: plant.datePlanted)
        _location = State(initialValue: plant.location ?? "")
        _height = State(initialValue: plant.height ?? 0)
        _waterFrequency = State(initialValue: plant.waterFrequency ?? "")
    }

    var body: some View {
        Form {
            VStack(alignment: .leading, spacing: 8) {
                TextField("Name*", text: $name)
                    .font(.largeTitle)
                    .bold()
                    .padding(.vertical, 4)
            }
            //TODO: Photo Area

            TextField("Species", text: $species)
                .padding()
            DatePicker(
                "Planted Date*",
                selection: $datePlanted,
                displayedComponents: .date
            )
            .padding()
            TextField("Location", text: $location)
                .padding()
            TextField("Height (m)", value: $height, format: .number)
                .keyboardType(.decimalPad)
                .padding()
            TextField("Water Frequency", text: $waterFrequency)
                .padding()
            Section {
                NavigationLink(destination: PlantNotesView(plant: plant)) {
                    HStack {
                        Text("Notes")
                        Spacer()
                        Label("View", systemImage: "magnifyingglass")
                    }
                }
            }
            Section {
                NavigationLink(destination: ImagesView(plant: plant)) {
                    HStack {
                        Text("Images")
                        Spacer()
                        Label("View", systemImage: "photo.artframe")
                    }
                }
            }

            //TODO: Notes area
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button("Save", systemImage: "pencil") {
                    plant.name = name
                    plant.species = species.isEmpty ? nil : species
                    plant.datePlanted = datePlanted
                    plant.location = location.isEmpty ? nil : location
                    plant.height = height
                    plant.waterFrequency =
                        waterFrequency.isEmpty ? nil : waterFrequency

                    do {
                        try context.save()
                    } catch {
                        print("error saving context: \(error)")
                    }
                }
                .disabled(!hasChanges)
            }
            ToolbarItem(placement: .status) {
                Button(action: {
                    showDeleteConfirmation = true
                }) {
                    Label("Delete Plant", systemImage: "trash")
                        .foregroundColor(.red)
                }
                .alert(
                    "Are you sure you want to delete this plant?",
                    isPresented: $showDeleteConfirmation
                ) {
                    Button("Delete", role: .destructive) {
                        context.delete(plant)
                        do {
                            try context.save()
                            dismiss()
                        } catch {
                            print("error deleting plant: \(error)")
                        }
                    }
                    Button("Cancel", role: .cancel) {}
                }
            }
        }
    }
}

#Preview {
    PlantView(plant: Plant(name: "Prueba", datePlanted: Date()))
}
