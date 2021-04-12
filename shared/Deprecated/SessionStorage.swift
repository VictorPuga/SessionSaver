//
//  SessionStorage.swift
//  SessionSaver
//
//  Created by Víctor Manuel Puga Ruiz on 03/04/21.
//

import Foundation
import CoreData
import Combine

// class SessionStorage: NSObject, ObservableObject {
//   let inMemory: Bool
//
//   var sessions = CurrentValueSubject<[Session], Never>([])
//
//   private let sessionFetchController: NSFetchedResultsController<Session>
//
//   private init(inMemory: Bool = false) {
//     self.inMemory = inMemory
//
//     let viewContext = inMemory
//       ? PersistenceController.preview.container.viewContext
//       : PersistenceController.shared.container.viewContext
//
//     let request: NSFetchRequest<Session> = Session.fetchRequest()
//     request.sortDescriptors = [NSSortDescriptor(keyPath: \Session.name, ascending: true)]
//
//
//     sessionFetchController = NSFetchedResultsController(
//       fetchRequest: request,
//       managedObjectContext: viewContext,
//       sectionNameKeyPath: nil,
//       cacheName: nil
//     )
//
//     super.init()
//
//     sessionFetchController.delegate = self
//
//     do {
//       try sessionFetchController.performFetch()
//       sessions.value = sessionFetchController.fetchedObjects ?? []
//     } catch {
//       logger.log("Error: couldn't fecth objects")
//       logger.log(error.localizedDescription)
//     }
//   }
//
//   override convenience init() {
//     self.init(inMemory: true)
//   }
//
//   func add() {
//     let viewContext = inMemory
//       ? PersistenceController.preview.container.viewContext
//       : PersistenceController.shared.container.viewContext
//
//     let newSession = Session(context: viewContext)
//     newSession.name = "Test session"
//
//     do {
//       try viewContext.save()
//     } catch {
//       logger.log("Error saving viewContext")
//     }
//   }
//   func update() {
//
//   }
// }
//
// extension SessionStorage: NSFetchedResultsControllerDelegate {
//   public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//     guard let sessions = controller.fetchedObjects as? [Session] else { return }
//      NSLog("Context changed, reloading Sessions")
//     self.sessions.value = sessions
//   }
// }
//
// extension SessionStorage {
//   static let shared = SessionStorage()
//   static let preview = SessionStorage(inMemory: true)
// }
//
