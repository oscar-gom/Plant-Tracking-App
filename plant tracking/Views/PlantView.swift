//
//  PlantView.swift
//  plant tracking
//
//  Created by Oscar Gomez on 24/7/25.
//

import SwiftUI
import Foundation
import SwiftData

struct PlantView: View {
    let plant: Plant
    
    @State private var name: String
    @State private var species: String
    @State private var height: Double
    @State private var datePlanted: Date
    @State private var location: String
    @State private var waterFrequency: String
    
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
        NavigationView {
            Form {
                VStack(alignment: .leading, spacing: 8) {
                    TextField("Name*", text: $name)
                        .font(.largeTitle)
                        .bold()
                        .padding(.vertical, 4)
                }
                
                TextField("Species", text: $species)
                DatePicker("Planted Date*", selection: $datePlanted, displayedComponents: .date)
                TextField("Location", text: $location)
                TextField("Height (m)", value: $height, format: .number)
                    .keyboardType(.decimalPad)
                TextField("Water Frequency", text: $waterFrequency)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    PlantView(plant: Plant(name: "Prueba", datePlanted: Date()))
}
