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
    
    init(plant: Plant) {
        self.plant = plant
    }
    
    var body: some View {
        NavigationView {
            ScrollView{
                TextEditor(text: $noteText)
                    .frame(height: 300)
                    .border(Color.gray)
                    .padding()
            }
            .navigationTitle("Create new note")
            .toolbar{
                ToolbarItem(placement: .automatic) {
                    Button("Create", systemImage: "plus.circle"){
                        let note = Note(text: noteText, plant: plant)
                        
                        do {
                            context.insert(note)
                            try context.save()
                        } catch {
                            print("Error saving context: \(error)")
                        }
                        
                    }
                }
            }
        }
    }
}

#Preview {
    CreateNoteView(plant: Plant(name: "Prueba", datePlanted: Date()))
}
