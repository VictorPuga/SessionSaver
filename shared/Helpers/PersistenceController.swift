//
//  PersistenceController.swift
//  SessionSaver
//
//  Created by Víctor Manuel Puga Ruiz on 27/03/21.
//

import CoreData

struct PersistenceController {
  let container: NSPersistentContainer
  
  func saveContext() {
    do {
      try container.viewContext.save()
    } catch {
      logger.log(error.localizedDescription)
    }
  }
  
  private init(inMemory: Bool = false) {
    guard let container = try? PersistentContainer.container() else {
      fatalError("Couldn't load container")
    }
    self.container = container
    
    let isPreview = ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] != nil
    if inMemory || isPreview {
      container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
    }
    container.loadPersistentStores { storeDescription, error in
      if let error = error as NSError? {
        /*
         Typical reasons for an error here include:
         * The parent directory does not exist, cannot be created, or disallows writing.
         * The persistent store is not accessible, due to permissions or data protection when the device is locked.
         * The device is out of space.
         * The store could not be migrated to the current model version.
         Check the error message to determine what the actual problem was.
         */
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
      logger.log("Successfully loaded persistent stores")
    }
  }
}

extension PersistenceController {
  static let shared = PersistenceController()
}
