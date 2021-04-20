//
//  CoreDataHelper.swift
//  SessionSaver
//
//  Created by Víctor Manuel Puga Ruiz on 06/04/21.
//

import Foundation
import CoreData

class CoreDataHelper {
  typealias ObjectType = NSManagedObject
  typealias PredicateType = NSPredicate
  
  
  // private var isPreview: Bool
  
  // private init(isPreview: Bool = false) {
  //   self.isPreview = isPreview
  // }
  
  // init(_ container: NSPersistentContainer) {
  //   self.persistentContainer = container
  // }
  init() {
    
  }
  
  // MARK: - Core Data
  
  private var context: NSManagedObjectContext { PersistenceController.shared.container.viewContext }
  
  // lazy private var persistentContainer: NSPersistentContainer = {
  //   let container = try! PersistentContainer.container()
  //   if isPreview {
  //     container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
  //   }
  //   container.loadPersistentStores { storeDescription, error in
  //     if let error = error as NSError? {
  //       /*
  //        Typical reasons for an error here include:
  //        * The parent directory does not exist, cannot be created, or disallows writing.
  //        * The persistent store is not accessible, due to permissions or data protection when the device is locked.
  //        * The device is out of space.
  //        * The store could not be migrated to the current model version.
  //        Check the error message to determine what the actual problem was.
  //        */
  //       fatalError("Unresolved error \(error), \(error.userInfo)")
  //     }
  //   }
  //   return container
  // }()
  
  func saveContext() {
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
}

// MARK: -  DBHelper Protocol
extension CoreDataHelper: DBHelperProtocol {
  func fetch<T: NSManagedObject>(_ objectType: T.Type, predicate: NSPredicate?, limit: Int?) -> Result<[T], Error> {
    let name = String(describing: objectType)
    let request = NSFetchRequest<T>(entityName: name)
    request.predicate = predicate
    
    if let limit = limit {
      request.fetchLimit = limit
    }
    do {
      let result = try context.fetch(request)
      return .success(result)
    } catch {
      return .failure(error)
    }
  }
  
  func fetchFirst<T: NSManagedObject>(_ objectType: T.Type, predicate: NSPredicate?) -> Result<T?, Error> {
    let result = fetch(objectType, predicate: predicate, limit: 1)
    switch result {
      case .success(let todos):
        return .success(todos.first)
      case .failure(let error):
        return .failure(error)
    }
  }
  
  func create(_ object: NSManagedObject) {
    do {
      try context.save()
    } catch {
      fatalError("error saving context while creating an object: \(error.localizedDescription)")
    }
  }
  
  func update(_ object: NSManagedObject) {
    do {
      try context.save()
    } catch {
      fatalError("error saving context while updating an object")
    }
  }
  
  func delete(_ object: NSManagedObject) {
    context.delete(object)
    do {
      try context.save()
    } catch {
      fatalError("error saving context while updating an object")
    }
  }
}

// extension CoreDataHelper {
//   static let shared = CoreDataHelper()
//   static let preview = CoreDataHelper(isPreview: true)
// }
