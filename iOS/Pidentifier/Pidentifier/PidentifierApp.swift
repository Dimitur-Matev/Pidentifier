//
//  PidentifierApp.swift
//  Pidentifier
//
//  Created by Dimitar Matev on 16/01/2022.
//

import SwiftUI

@main
struct PidentifierApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            CameraUIView()
        }
    }
}
