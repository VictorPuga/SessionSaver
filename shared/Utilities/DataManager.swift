//
//  DataManager.swift
//  SessionSaver
//
//  Created by Víctor Manuel Puga Ruiz on 07/04/21.
//

import Foundation
import CoreData

protocol DataManagerProtocol {
  func fetchSessions() -> [Session]
  func addSession(name: String)
}

class DataManager {
  var dbHelper: CoreDataHelper
  
  // private var todos = [Todo]()
  
  private init(dbHelper: CoreDataHelper = .shared) {
    self.dbHelper = dbHelper
  }
  
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
}

// MARK: - DataManagerProtocol
extension DataManager: DataManagerProtocol {
  func fetchSessions() -> [Session] {
    let result = dbHelper.fetch(SessionMO.self, predicate: nil, limit: nil)

    switch result {
      case .success(let sessions):
        return sessions.map { $0.convertToSession() }
      case .failure(let error):
        fatalError(error.localizedDescription)
    }
  }
  
  func addSession(name: String) {
    let newSession = SessionMO(context: dbHelper.context)
    newSession.name = name
    newSession.id = UUID()
    dbHelper.create(newSession)
    try! dbHelper.context.save()
  }
}

extension DataManager {
  static let shared: DataManagerProtocol = DataManager()
  static let preview: DataManagerProtocol = DataManager(dbHelper: .preview)
}
