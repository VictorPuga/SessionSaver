//
//  SessionSaverApp.swift
//  SessionSaver
//
//  Created by Víctor Manuel Puga Ruiz on 27/03/21.
//

import SwiftUI

@main
struct SessionSaverApp: App {
  var body: some Scene {
    WindowGroup {
      // ContentView()
        // .environment(\.managedObjectContext, persistenceController.container.viewContext)
      SessionsView()
        .onReceive(
          NotificationCenter.default.publisher(for: NSApplication.willResignActiveNotification)
        ) { _ in
          PersistenceController.shared.saveContext()
        }
    }
  }
}
