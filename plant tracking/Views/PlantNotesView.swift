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

    // If there are no notes, show an empty state view
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Image(systemName: "note.text")
                .font(.system(size: 60))
                .foregroundColor(.green.opacity(0.6))
            
            Text("No Notes Yet")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            Text("Start tracking \(plant.name)'s progress by adding your first note!")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Button(action: {
                showCreateNote = true
            }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Add First Note")
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.green)
                .cornerRadius(12)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
    
    private var notesListView: some View {
        List {
            ForEach(filteredNotes) { note in
                noteRowView(for: note)
            }
            .onDelete(perform: deleteNotes)
        }
    }
    
    private func noteRowView(for note: Note) -> some View {
        NavigationLink(destination: PlantNotesDetailsView(note: note)) {
            VStack(alignment: .leading, spacing: 4) {
                Text(note.date, style: .date)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text(note.text)
                    .lineLimit(3)
                    .truncationMode(.tail)
                    .font(.body)
            }
            .padding(.vertical, 4)
        }
    }
    
    private func deleteNotes(at indexes: IndexSet) {
        for index in indexes {
            context.delete(filteredNotes[index])
        }
    }

    var body: some View {
        NavigationStack {
            Group {
                if filteredNotes.isEmpty {
                    emptyStateView
                } else {
                    notesListView
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
}

#Preview {
    PlantNotesView(plant: Plant(name: "prueba", datePlanted: Date()))
}
