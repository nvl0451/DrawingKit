//
//  DrawingKitApp.swift
//  DrawingKit
//
//  Created by Андрей Королев on 14.03.2022.
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
