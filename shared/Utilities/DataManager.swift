//
//  DataManager.swift
//  SessionSaver
//
//  Created by Víctor Manuel Puga Ruiz on 07/04/21.
//

import Foundation
import CoreData
import Combine

protocol DataManagerProtocol {
  func fetchSessions() -> [Session]
  func addSession(name: String)
  func addPage(_ page: Page, to session: Session)
  func deleteSession(_ session: Session)
  
  // func publisher<T: NSManagedObject>(
  //   for type: T.Type,
  //   changeTypes: [ChangeType]
  // ) -> AnyPublisher<[([T], ChangeType)], Never>
}

// enum ChangeType {
//   case inserted, deleted, updated
//   
//   var userInfoKey: String {
//     switch self {
//       case .inserted: return NSInsertedObjectIDsKey
//       case .deleted: return NSDeletedObjectIDsKey
//       case .updated: return NSUpdatedObjectIDsKey
//     }
//   }
// }

// class DataManager {
//   var dbHelper: CoreDataHelper
//   
//   // private var todos = [Todo]()
//   
//   // private init(dbHelper: CoreDataHelper = .shared) {
//   //   self.dbHelper = dbHelper
//   // }
//   
//   private func getSessionMO(for session: Session) -> SessionMO? {
//     let predicate = NSPredicate(format: "id = %@", session.id as CVarArg)
//     let result = dbHelper.fetchFirst(SessionMO.self, predicate: predicate)
//     
//     switch result {
//       case .success(let sessionMO):
//         return sessionMO
//       case .failure(_):
//         return nil
//     }
//   }
// }
// 
// // MARK: - DataManagerProtocol
// extension DataManager: DataManagerProtocol {
//   func fetchSessions() -> [Session] {
//     let result = dbHelper.fetch(SessionMO.self, predicate: nil, limit: nil)
// 
//     switch result {
//       case .success(let sessions):
//         return sessions.map { $0.convertToSession() }
//       case .failure(let error):
//         fatalError(error.localizedDescription)
//     }
//   }
//   
//   func addSession(name: String) {
//     let newSession = SessionMO(context: dbHelper.context)
//     newSession.id = UUID()
//     newSession.name = name
//     
//     // Saver.shared.getTabs()
//     Saver.shared.addTabsToSession(newSession.convertToSession())
//     
//     // let newPage = PageMO(context: dbHelper.context)
//     // newPage.id = UUID()
//     // newPage.title = "Some title"
//     // newPage.url = URL(string: "https://example.com")!
//     //
//     // newSession.pages = NSSet(array: [newPage])
//     dbHelper.create(newSession)
//   }
//   
//   func deleteSession(_ session: Session) {
//     guard let mo = getSessionMO(for: session) else {
//       fatalError("No managed object for \(session) ")
//     }
//     dbHelper.delete(mo)
//   }
//   
//   func addPage(_ page: Page, to session: Session) {
//     guard let sessionMO = getSessionMO(for: session) else {
//       logger.log("No session???")
//       return
//     }
//     
//     let newPage = PageMO(context: dbHelper.context)
//     newPage.id = page.id
//     newPage.title = page.title
//     newPage.url = page.url
//     
//     sessionMO.pages = sessionMO.pages.adding(newPage) as NSSet
//     
//     // dbHelper.create(newPage)
//     dbHelper.update(sessionMO)
//   }
// }
// 
// extension DataManager {
//   static let shared: DataManagerProtocol = DataManager()
//   // static let preview: DataManagerProtocol = DataManager(dbHelper: .preview)
// }
// 
// // extension DataManager {
// //   func publisher<T: NSManagedObject>(for type: T.Type,
// //                                      changeTypes: [ChangeType]) -> AnyPublisher<[([T], ChangeType)], Never> {
// //     let notification = NSManagedObjectContext.didMergeChangesObjectIDsNotification
// //     return NotificationCenter.default.publisher(for: notification, object: dbHelper.context)
// //       .compactMap({ notification in
// //         return changeTypes.compactMap({ type -> ([T], ChangeType)? in
// //           guard let changes = notification.userInfo?[type.userInfoKey] as? Set<NSManagedObjectID> else {
// //             return nil
// //           }
// //           
// //           let objects = changes
// //             .filter({ objectID in objectID.entity == T.entity() })
// //             .compactMap({ [weak self] objectID in self?.dbHelper.context.object(with: objectID) as? T })
// //           return (objects, type)
// //         })
// //       })
// //       .eraseToAnyPublisher()
// //   }
// // }
