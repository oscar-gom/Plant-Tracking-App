//
//  PlantView.swift
//  plant tracking
//
//  Created by Oscar Gomez on 15/7/25.
//

import Foundation
import SwiftUI

struct PlantView: View {
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    TextField("Name of plant*", text: .constant(""))
                        .padding()
                    TextField("Species", text: .constant(""))
                        .padding(.horizontal)
                    DatePicker("Planted Date*", selection: .constant(Date()), displayedComponents: .date)
                        .padding()
                    TextField("Height", text: .constant(""))
                        .padding(.horizontal)
                    TextField("Location", text: .constant(""))
                        .padding()
                    TextField("Water Frequency", text: .constant(""))
                        .padding(.horizontal)
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .navigationTitle("New Plant")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Add", systemImage: "plus.circle") {
                        
                    }
                }
            }
        }
    }
}

#Preview {
    PlantView()
}
