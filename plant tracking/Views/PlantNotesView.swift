//
//  PlantNotesView.swift
//  plant tracking
//
//  Created by Oscar Gomez on 27/7/25.
//

import SwiftUI
import Foundation
import SwiftData

struct PlantNotesView: View {
    @Environment(\.modelContext) private var context
    
    @State private var showCreateNote = false
    
    let plant: Plant
    
    @Query private var notes: [Note]

    var filteredNotes: [Note] {
        notes.filter { $0.plant == plant }
    }
    
    init(plant: Plant) {
        self.plant = plant
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(filteredNotes) { note in
                        Text(note.text)
                            .lineLimit(1)
                            .truncationMode(.tail)
                    }
                }
            }
            .navigationTitle("\(plant.name)'s notes")
            .toolbar{
                ToolbarItem(placement: .automatic) {
                    Button("Add", systemImage: "plus.circle") {
                        showCreateNote = true
                    }
                    .sheet(isPresented: $showCreateNote) {
                        CreateNoteView(plant: plant)
                            .presentationDetents([.height(600)])
                    }
                }
            }
        }
    }
}

#Preview {
    PlantNotesView(plant: Plant(name: "prueba", datePlanted: Date()))
}
