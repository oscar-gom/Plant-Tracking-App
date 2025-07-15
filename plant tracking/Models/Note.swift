//
//  Note.swift
//  plant tracking
//
//  Created by Oscar Gomez on 15/7/25.
//

import Foundation
import SwiftData

@Model
final class Note {
    var id: UUID
    var text: String
    var date: Date
    
    init(text: String) {
        self.id = UUID()
        self.text = text
        self.date = Date()
    }
}
