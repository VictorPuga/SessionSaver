//
//  MockDataManager.swift
//  SessionSaver
//
//  Created by Víctor Manuel Puga Ruiz on 07/04/21.
//

import Foundation


class MockDataManager {
  var dbHelper: CoreDataHelper = .preview
}

// MARK: - DataMAnagerProtocol
extension MockDataManager: DataManagerProtocol {
  func fetchSessions() -> [Session] {
    []
  }
  
  func addSession(name: String) {
    
  }
}
