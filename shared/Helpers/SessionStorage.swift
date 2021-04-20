//
//  SessionStorage.swift
//  SessionSaver
//
//  Created by Víctor Manuel Puga Ruiz on 03/04/21.
//

import Foundation
import CoreData
import Combine

class SessionStorage: NSObject, ObservableObject {
  let inMemory: Bool
  
  var sessions = CurrentValueSubject<[Session], Never>([])
  
  private let sessionFetchController: NSFetchedResultsController<SessionMO>
  
  private var context: NSManagedObjectContext { PersistenceController.shared.container.viewContext }
  
  private var dbHelper: CoreDataHelper
  
  private var cancellable: AnyCancellable?
  
  private init(inMemory: Bool = false) {
    self.inMemory = inMemory
    
    // let request: NSFetchRequest<SessionMO> = SessionMO.fetchRequest()
    // let name = String(describing: objectType)
    // let request = NSFetchRequest<T>(entityName: name)
    let name = String(describing: SessionMO.self)
    let request = NSFetchRequest<SessionMO>(entityName: name)
    request.sortDescriptors = [NSSortDescriptor(keyPath: \SessionMO.name, ascending: true)]
    
    self.dbHelper = CoreDataHelper()
    sessionFetchController = NSFetchedResultsController(
      fetchRequest: request,
      managedObjectContext: PersistenceController.shared.container.viewContext,
      sectionNameKeyPath: nil,
      cacheName: nil
    )
    
    super.init()
    
    sessionFetchController.delegate = self
    
    do {
      try sessionFetchController.performFetch()
      sessions.value = (sessionFetchController.fetchedObjects ?? []).map { $0.convertToSession() }
    } catch {
      logger.log("Error: couldn't fecth objects")
      logger.log(error.localizedDescription)
    }
  }
  
  // override convenience init() {
  //   self.init(inMemory: true)
  // }
  
  private func getSessionMO(for session: Session) -> SessionMO? {
    let predicate = NSPredicate(format: "id = %@", session.id as CVarArg)
    let result = dbHelper.fetchFirst(SessionMO.self, predicate: predicate)
    
    switch result {
      case .success(let sessionMO):
        return sessionMO
      case .failure(_):
        return nil
    }
  }
  
  func add(name: String) {
    cancellable?.cancel()
    cancellable = SafariManager.shared.getTabs()
      .map { [weak self] pages -> [PageMO] in
        pages.enumerated().map { (index, page) in
          let newPage = PageMO(context: self!.context)
          newPage.id = page.id
          newPage.title = page.title
          newPage.url = page.url
          newPage.index = Int16(index)
          return newPage
        }
      }
      .map { [weak self] pages -> SessionMO in
        let session = SessionMO(context: self!.context)
        session.id = UUID()
        session.name = name
        session.pages = NSSet(array: pages)
        return session
      }
      .sink { [weak self] session in
        self!.dbHelper.create(session)
      }
  }
  
  func deleteSession(_ session: Session) {
    guard let mo = getSessionMO(for: session) else {
      fatalError("No managed object for \(session) ")
    }
    dbHelper.delete(mo)
  }
  
  func update() {}
}

extension SessionStorage: NSFetchedResultsControllerDelegate {
  public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    guard let sessions = controller.fetchedObjects as? [SessionMO] else { return }
    NSLog("Context changed, reloading Sessions")
    self.sessions.value = sessions.map { $0.convertToSession() }
  }
}

extension SessionStorage {
  static let shared = SessionStorage()
}
