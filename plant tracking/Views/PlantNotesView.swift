//
//  PlantNotesView.swift
//  plant tracking
//
//  Created by Oscar Gomez on 27/7/25.
//

import Foundation
import SwiftData
import SwiftUI

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
        .navigationBarBackButtonHidden(false)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button("Add", systemImage: "plus.circle") {
                    showCreateNote = true
                }
                .sheet(isPresented: $showCreateNote) {
                    NavigationStack {
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
