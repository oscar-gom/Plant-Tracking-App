//
//  CreateNoteView.swift
//  plant tracking
//
//  Created by Oscar Gomez on 27/7/25.
//

import Foundation
import SwiftUI

struct CreateNoteView: View {
    @Environment(\.modelContext) private var context

    let plant: Plant

    @State private var noteText: String = ""
    @State private var errorMessage: String? = nil

    init(plant: Plant) {
        self.plant = plant
    }

    var body: some View {
        VStack {
            ScrollView {
                TextEditor(text: $noteText)
                    .frame(height: 300)
                    .border(Color.gray)
                    .padding()
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                }
            }
            .navigationTitle("Create new note")
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button("Create", systemImage: "plus.circle") {
                        handleCreate()
                    }
                }
            }
        }
    }
    // Error control logic
    private func validateFields() -> String? {
        let trimmedText = noteText.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedText.isEmpty {
            return "Note text is required."
        }
        return nil
    }
    private func handleCreate() {
        errorMessage = validateFields()
        guard errorMessage == nil else { return }
        let note = Note(text: noteText, plant: plant)
        do {
            context.insert(note)
            try context.save()
            noteText = ""
        } catch {
            errorMessage = "Error saving note: \(error.localizedDescription)"
        }
    }
}

#Preview {
    CreateNoteView(plant: Plant(name: "Prueba", datePlanted: Date()))
}
