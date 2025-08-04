//
//  PlantNotesDetailsView.swift
//  plant tracking
//
//  Created by Oscar Gomez on 4/8/25.
//

import SwiftUI
import SwiftData

struct PlantNotesDetailsView: View {
    let note: Note
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State private var text: String
    @State private var date: Date
    @State private var showDeleteConfirmation = false
    
    private var hasChanges: Bool {
        text != note.text || date != note.date
    }
    
    init(note: Note) {
        self.note = note
        _text = State(initialValue: note.text)
        _date = State(initialValue: note.date)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                DatePicker("Date", selection: $date, displayedComponents: .date)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                TextField("Note", text: $text)
                    .font(.body)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .foregroundColor(.primary)
                    .padding(.horizontal)
                Spacer(minLength: 24)
                Button(action: {
                    showDeleteConfirmation = true
                }) {
                    Label("Delete Note", systemImage: "trash")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                }
                .alert(
                    "Are you sure you want to delete this note?",
                    isPresented: $showDeleteConfirmation
                ) {
                    Button("Delete", role: .destructive) {
                        context.delete(note)
                        do {
                            try context.save()
                            dismiss()
                        } catch {
                            print("error deleting note: \(error)")
                        }
                    }
                    Button("Cancel", role: .cancel) {}
                }
            }
            .padding()
            .navigationTitle("Note Details")
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button("Edit", systemImage: "pencil.circle") {
                        note.text = text
                        note.date = date
                        do {
                            try context.save()
                        } catch {
                            print("error saving note: \(error)")
                        }
                    }
                    .disabled(!hasChanges)
                }
            }
        }
    }
}

#Preview {
    PlantNotesDetailsView(note: Note(text: "jdsjdasoij", plant: Plant(name: "Prueba", datePlanted: Date())))
}
