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
    @State private var errorMessage: String? = nil
    
    private var hasChanges: Bool {
        text != note.text || date != note.date
    }
    
    init(note: Note) {
        self.note = note
        _text = State(initialValue: note.text)
        _date = State(initialValue: note.date)
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Note text", text: $text)
                    .padding(.vertical, 8)
                Text(date, style: .date)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 4)
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.vertical, 4)
                }
            }
            Section {
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
                        handleDelete()
                    }
                    Button("Cancel", role: .cancel) {}
                }
            }
        }
        .navigationTitle("Note Details")
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button(action: { handleEdit() }) {
                    Label("Edit", systemImage: "pencil.circle")
                }
                .disabled(!hasChanges)
            }
        }
    }
    
    // Error control logic
    private func validateFields() -> String? {
        if text.trimmingCharacters(in: .whitespaces).isEmpty {
            return "Note text is required."
        }
        return nil
    }
    
    private func handleEdit() {
        errorMessage = validateFields()
        guard errorMessage == nil else { return }
        note.text = text
        note.date = date
        do {
            try context.save()
        } catch {
            errorMessage = "Error saving note: \(error.localizedDescription)"
        }
    }
    
    private func handleDelete() {
        errorMessage = nil
        context.delete(note)
        do {
            try context.save()
            dismiss()
        } catch {
            errorMessage = "Error deleting note: \(error.localizedDescription)"
        }
    }
}

#Preview {
    PlantNotesDetailsView(note: Note(text: "jdsjdasoij", plant: Plant(name: "Prueba", datePlanted: Date())))
}
