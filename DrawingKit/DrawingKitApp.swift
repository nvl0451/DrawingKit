//
//  DrawingKitApp.swift
//  DrawingKit
//

import SwiftUI

@main
struct DrawingKitApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
