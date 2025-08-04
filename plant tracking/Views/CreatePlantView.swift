//
//  PlantView.swift
//  plant tracking
//
//  Created by Oscar Gomez on 15/7/25.
//

import Foundation
import SwiftData
import SwiftUI

struct CreatePlantView: View {
    @Environment(\.modelContext) private var context

    @State private var name: String = ""
    @State private var species: String = ""
    @State private var plantedDate: Date = Date()
    @State private var height: String = ""
    @State private var location: String = ""
    @State private var waterFrequency: String = ""
    @State private var errorMessage: String? = nil

    var body: some View {

        Form {
            Section {
                TextField("Name of plant*", text: $name)
                    .padding()
                DatePicker(
                    "Planted Date*",
                    selection: $plantedDate,
                    displayedComponents: .date
                )
                .padding()
            }
            Section {
                TextField("Species", text: $species)
                    .padding()

                TextField("Height", text: $height)
                    .padding()
                    .keyboardType(.decimalPad)
                TextField("Location", text: $location)
                    .padding()
                TextField("Water Frequency", text: $waterFrequency)
                    .padding()
            }
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
            }

        }
        .navigationTitle("New Plant")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Add", systemImage: "plus.circle") {
                    handleAdd()
                }
            }
        }
    }

    // Error control logic
    private func validateFields() -> String? {
        if name.trimmingCharacters(in: .whitespaces).isEmpty {
            return "Name is required."
        }
        // Date is always set, so no need to check for nil
        if !height.trimmingCharacters(in: .whitespaces).isEmpty && Double(height) == nil {
            return "Height must be a number."
        }
        return nil
    }
    private func handleAdd() {
        errorMessage = validateFields()
        guard errorMessage == nil else { return }
        let plantHeight: Double = height.trimmingCharacters(in: .whitespaces).isEmpty ? 0.0 : (Double(height)! * 100).rounded() / 100
        let plant = Plant(
            name: name,
            species: species,
            datePlanted: plantedDate,
            height: plantHeight,
            location: location,
            waterFrequency: waterFrequency
        )
        do {
            context.insert(plant)
            try context.save()
            name = ""
            species = ""
            plantedDate = Date()
            height = ""
            location = ""
            waterFrequency = ""
        } catch {
            errorMessage = "Error saving plant: \(error.localizedDescription)"
        }
    }
}

#Preview {
    CreatePlantView()
}
