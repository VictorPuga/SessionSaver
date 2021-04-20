//
//  MockDataManager.swift
//  SessionSaver
//
//  Created by Víctor Manuel Puga Ruiz on 07/04/21.
//

import Foundation
import CoreData
import Combine

class MockDataManager {
  // var dbHelper: CoreDataHelper = .preview
}

// MARK: - DataMAnagerProtocol
extension MockDataManager: DataManagerProtocol {
  
  func fetchSessions() -> [Session] {
    []
  }
  
  func addSession(name: String) {
    
  }
  
  func addPage(_ page: Page, to session: Session) {
    
  }
  
  func deleteSession(_ session: Session) {
    
  }
  
  // func publisher<T>(for type: T.Type, changeTypes: [ChangeType]) -> AnyPublisher<[([T], ChangeType)], Never> where T : NSManagedObject {
  //   AnyPublisher<[([T], ChangeType)], Never>([].publisher)
  // }
}
