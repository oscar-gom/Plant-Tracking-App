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
    var text: String
    var date: Date
    var plant: Plant
    
    init(text: String, date: Date, plant: Plant) {
        self.text = text
        self.date = date
        self.plant = plant
    }
}
