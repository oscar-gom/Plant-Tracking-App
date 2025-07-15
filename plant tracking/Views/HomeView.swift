//
//  HomeView.swift
//  plant tracking
//
//  Created by Oscar Gomez on 15/7/25.
//

import Foundation
import SwiftUI

struct HomeView: View {
    var body: some View {
            VStack {
                HStack {
                    Text("Home Page")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                    Spacer()
                    Button("New Plant", systemImage: "plus.circle") {
                        // TODO
                    }
                    .padding()
                }
                Spacer()
                ScrollView {
                    // TODO
                }
            }
    }
}

#Preview {
    HomeView()
}
