//
//  CineStreamApp.swift
//  CineStream
//
//  Created by Neel Patel on 5/11/2025.
//

import SwiftUI
import SwiftData

@main
struct CineStreamApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Title.self)
    }
}
