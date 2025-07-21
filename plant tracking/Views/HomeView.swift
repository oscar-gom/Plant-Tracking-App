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
    
    var body: some View {
        NavigationView {
            List {
                ForEach(plants, id: \.self) { plant in
                    Text(plant.name)
                }
            }
            .navigationTitle("My Garden")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Button("New Plant", systemImage: "plus.circle") {
                            showAddPlantSheet = true
                        }
                        .sheet(isPresented: $showAddPlantSheet) {
                            PlantView()
                                .presentationDetents([.height(600)])
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

#Preview {
    HomeView()
}
