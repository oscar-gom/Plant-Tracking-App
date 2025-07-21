//
//  PlantView.swift
//  plant tracking
//
//  Created by Oscar Gomez on 15/7/25.
//

import Foundation
import SwiftUI
import SwiftData

struct PlantView: View {
    @Environment(\.modelContext) private var context
    
    @State private var name: String = ""
    @State private var species: String = ""
    @State private var plantedDate: Date = Date()
    @State private var height: String = ""
    @State private var location: String = ""
    @State private var waterFrequency: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    TextField("Name of plant*", text: $name)
                        .padding()
                    TextField("Species", text: $species)
                        .padding(.horizontal)
                    DatePicker("Planted Date*", selection: $plantedDate, displayedComponents: .date)
                        .padding()
                    TextField("Height", text: $height)
                        .padding(.horizontal)
                        .keyboardType(.decimalPad)
                    TextField("Location", text: $location)
                        .padding()
                    TextField("Water Frequency", text: $waterFrequency)
                        .padding(.horizontal)
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .navigationTitle("New Plant")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Add", systemImage: "plus.circle") {
                        //TODO: Make error control
                        
                        let plantHeight: Double
                        if height.trimmingCharacters(in: .whitespaces).isEmpty {
                            plantHeight = 0.0
                        } else if let parsedHeight = Double(height) {
                            plantHeight = (parsedHeight * 100).rounded() / 100
                        } else {
                            print("Not a number")
                            return
                        }

                        let plant = Plant(name: name, species: species, datePlanted: plantedDate, height: plantHeight, location: location, waterFrequency: waterFrequency)
                        
                        
                        do {
                            context.insert(plant)
                            try context.save()
                        } catch {
                            print("Error saving context: \(error)")
                        }
                        
                        name = ""
                        species = ""
                        plantedDate = Date()
                        height = ""
                        location = ""
                        waterFrequency = ""
                    }
                }
            }
        }
    }
}

#Preview {
    PlantView()
}
