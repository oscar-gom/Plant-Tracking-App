//
//  CreateNoteView.swift
//  plant tracking
//
//  Created by Oscar Gomez on 27/7/25.
//

import Foundation
import SwiftUI

struct CreateNoteView: View {
    @State private var noteText: String = ""
    
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
                        //TODO: Create to database
                    }
                }
            }
        }
    }
}

#Preview {
    CreateNoteView()
}
