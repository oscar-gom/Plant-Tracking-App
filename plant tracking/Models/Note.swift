//
//  Note.swift
//  plant tracking
//
//  Created by Oscar Gomez on 15/7/25.
//

import Foundation
import SwiftData

final class Note {
    var id: UUID
    var text: String
    var date: Date
    
    init(id: UUID, text: String) {
        self.id = id
        self.text = text
        self.date = Date()
    }
}
