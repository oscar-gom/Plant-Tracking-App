//
//  PlantImage.swift
//  plant tracking
//
//  Created by Oscar Gomez on 15/7/25.
//

import Foundation
import SwiftData

@Model
final class PlantImage {
    var plant: Plant
    var date: Date
    var image: Data
    var descript: String?
    
    init(plant: Plant, date: Date, image: Data, description: String? = nil) {
        self.plant = plant
        self.date = date
        self.image = image
        self.descript = description
    }
    
}
