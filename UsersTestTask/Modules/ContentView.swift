//
//  ContentView.swift
//  UsersTestTask
//
//  Created by realeti on 26.09.2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
