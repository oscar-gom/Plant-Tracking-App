//
//  HomeView.swift
//  plant tracking
//
//  Created by Oscar Gomez on 15/7/25.
//

import Foundation
import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var context
    
    @State private var showAddPlantSheet = false
    
    @Query private var plants: [Plant]
    
    private var adaptiveColumns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: 16), count: min(3, max(1, Int(UIScreen.main.bounds.width / 140))))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: adaptiveColumns, spacing: 16) {
                        ForEach(plants, id: \.self) { plant in
                            NavigationLink(destination: PlantView(plant: plant)) {
                                VStack(spacing: 8) {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.green.opacity(0.3))
                                        .frame(height: 120)
                                        .overlay(
                                            Image(systemName: "leaf.fill")
                                                .font(.title)
                                                .foregroundColor(.green)
                                        )
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(plant.name)
                                            .font(.headline)
                                            .lineLimit(1)
                                        
                                        if let species = plant.species {
                                            Text(species)
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                                .lineLimit(1)
                                        }
                                        
                                        Text("Planted: \(plant.datePlanted, style: .date)")
                                            .font(.caption2)
                                            .foregroundColor(.secondary)
                                            .lineLimit(1)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .padding(12)
                                .background(Color(.systemGray6))
                                .cornerRadius(16)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity)
                }
                .navigationTitle("My Garden")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            Button("New Plant", systemImage: "plus.circle") {
                                showAddPlantSheet = true
                            }
                            .sheet(isPresented: $showAddPlantSheet) {
                                NavigationStack {
                                    CreatePlantView()
                                        .presentationDetents([.height(600)])
                                }
                            }
                            Button("Settings", systemImage: "gearshape.fill") {
                                // TODO: Show settings
                            }
                        }
                    }
                }
            }
        }
    }
}



#Preview {
    HomeView()
}
