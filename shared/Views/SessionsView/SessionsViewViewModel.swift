//
//  SessionsViewViewModel.swift
//  SessionSaver
//
//  Created by Víctor Manuel Puga Ruiz on 08/04/21.
//

import Foundation
import Combine

protocol SessionsViewViewModelProtocol {
  var sessions: [Session] { get }
  func fetchSessions()
  func addSession(name: String)
}

class SessionsViewViewModel: ObservableObject {
  @Published var sessions: [Session] = []
  
  var dataManager: DataManagerProtocol
  
  init(dataManager: DataManagerProtocol) {
    self.dataManager = dataManager
    fetchSessions()
  }
  
  // Simpler init for preview purposes
  init() {
    let isPreview = ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] != nil
    
    dataManager = isPreview ? DataManager.preview : DataManager.shared
    if isPreview {
      loadPreviewData()
    }
    fetchSessions()
  }
}


extension SessionsViewViewModel: SessionsViewViewModelProtocol {
  func fetchSessions() {
    sessions = dataManager.fetchSessions()
    logger.log(sessions)
  }
  
  func addSession(name: String) {
    dataManager.addSession(name: name)
    fetchSessions()
  }
}

// extension SessionsViewViewModel {
//   static let preview: SessionsViewViewModel = {
//     let manager = DataManager.preview
//     manager.addSession(name: "Test 1")
//     manager.addSession(name: "Test 2")
//     manager.addSession(name: "Test 3")
//     print(manager.fetchSessions())
//     return SessionsViewViewModel(dataManager: manager)
//   }()
// }

extension SessionsViewViewModel {
  func loadPreviewData() {
    dataManager.addSession(name: "Test 1")
    dataManager.addSession(name: "Test 2")
    dataManager.addSession(name: "Test 3")
  }
}
