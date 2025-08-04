//
//  SettingsView.swift
//  plant tracking
//
//  Created by Oscar Gomez on 4/8/25.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @Environment(\.modelContext) private var context
    @State private var showDeleteConfirmation = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Button(action: {
                        showDeleteConfirmation = true
                    }) {
                        HStack {
                            Image(systemName: "trash.fill")
                                .foregroundColor(.red)
                            Text("Delete all data")
                                .foregroundColor(.red)
                        }
                    }
                } footer: {
                    Text("This will permanently delete all plants, images, and notes from your garden. This action cannot be undone.")
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Settings")
            .alert("Delete All Data", isPresented: $showDeleteConfirmation) {
                Button("Cancel", role: .cancel) { }
                Button("Delete", role: .destructive) {
                    deleteAllData()
                }
            } message: {
                Text("Are you sure you want to delete all your garden data? This action cannot be undone.")
            }
        }
    }
    
    private func deleteAllData() {
        do {
            try context.delete(model: Plant.self)
            try context.delete(model: PlantImage.self)
            try context.delete(model: Note.self)
            try context.save()
        } catch {
            print("Error deleting all data: \(error)")
        }
    }
}

#Preview {
    SettingsView()
}
