//
//  Plant.swift
//  plant tracking
//
//  Created by Oscar Gomez on 15/7/25.
//

import Foundation
import SwiftData

@Model
final class Plant {
    var name: String
    var species: String?
    var datePlanted: Date
    var height: Double?
    var location: String?
    var waterFrequency: String?
    
    init(name: String, species: String? = nil, datePlanted: Date, height: Double? = nil, location: String? = nil, waterFrequency: String? = nil) {
        self.name = name
        self.species = species
        self.datePlanted = datePlanted
        self.height = height
        self.location = location
        self.waterFrequency = waterFrequency
    }
}
