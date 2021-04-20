//
//  TestViewViewModel.swift
//  SessionSaver
//
//  Created by Víctor Manuel Puga Ruiz on 07/04/21.
//

import Foundation
import Combine

protocol TestViewViewModelProtocol {
  var sessions: [Session] { get }
  func fetchSessions()
  func addSession(name: String)
}

final class TestViewViewModel: ObservableObject {
  @Published var sessions = [Session]()
  
  // var dataManager: DataManagerProtocol
  
  // init(dataManager: DataManagerProtocol = DataManager.shared) {
    // self.dataManager = dataManager
    // fetchSessions()
  // }
}

extension TestViewViewModel: TestViewViewModelProtocol {
  func fetchSessions() {
    // sessions = dataManager.fetchSessions()
  }
  
  func addSession(name: String) {
    // dataManager.addSession(name: name)
    // fetchSessions()
  }
}
