//
//  PlantImage.swift
//  plant tracking
//
//  Created by Oscar Gomez on 15/7/25.
//

import Foundation
import SwiftData

final class PlantImage {
    var id: UUID
    var plantId: UUID
    var date: Date
    var image: Data
    
    init(plantId: UUID, image: Data) {
        self.id = UUID()
        self.plantId = plantId
        self.date = Date()
        self.image = image
    }
}
