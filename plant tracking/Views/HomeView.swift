//
//  HomeView.swift
//  plant tracking
//
//  Created by Oscar Gomez on 15/7/25.
//

import Foundation
import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                ScrollView {
                    // TODO: List of plant items
                }
            }
            .navigationTitle("Mi Jardín")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Button("New Plant", systemImage: "plus.circle") {
                            // TODO: Show create plant view
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
