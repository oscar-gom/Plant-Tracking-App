//
//  plant_trackingApp.swift
//  plant tracking
//
//  Created by Oscar Gomez on 15/7/25.
//

import SwiftUI
import SwiftData

@main
struct plant_trackingApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Plant.self, Note.self, PlantImage.self])
    }
}
