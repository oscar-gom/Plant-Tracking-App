//
//  HomeView.swift
//  plant tracking
//
//  Created by Oscar Gomez on 15/7/25.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @State private var showAddPlantSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    // TODO: List of plant items
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
