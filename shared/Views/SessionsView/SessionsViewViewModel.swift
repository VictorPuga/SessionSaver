//
//  SessionsViewViewModel.swift
//  SessionSaver
//
//  Created by Víctor Manuel Puga Ruiz on 08/04/21.
//

import Foundation
import Combine
import CoreData

protocol SessionsViewViewModelProtocol {
  var sessions: [Session] { get }
  // func fetchSessions()
  func addSession(name: String)
}

// class SessionsViewViewModel: ObservableObject {
//   @Published var sessions: [Session] = []
//
//   private var dataManager: DataManagerProtocol
//
//   private var changesCancellable: AnyCancellable?
//
//   private init(dataManager: DataManagerProtocol) {
//     self.dataManager = dataManager
//     fetchSessions()
//
//
//     // changesCancellable =
//     //   dataManager.publisher(for: SessionMO.self, changeTypes: [.inserted])
//     //   .sink(receiveValue: { [weak self] changes in
//     //     logger.log(changes)
//     //     // self?.fetchSessions()
//     //   })
//
//   }
//
//   // Simpler init for preview purposes
//   convenience init() {
//     let isPreview = ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] != nil
//
//     let manager = isPreview ? DataManager.preview : DataManager.shared
//     // fetchSessions()
//     self.init(dataManager: manager)
//     if isPreview {
//       loadPreviewData()
//     }
//   }
// }
//
//
// extension SessionsViewViewModel: SessionsViewViewModelProtocol {
//   func fetchSessions() {
//     sessions = dataManager.fetchSessions()
//     // logger.log(sessions)
//   }
//
//   func addSession(name: String) {
//     logger.log("Add")
//     dataManager.addSession(name: name)
//     fetchSessions()
//   }
//
//   func deteleSession(_ session: Session) {
//     dataManager.deleteSession(session)
//     fetchSessions()
//   }
// }
//
// // extension SessionsViewViewModel {
// //   static let preview: SessionsViewViewModel = {
// //     let manager = DataManager.preview
// //     manager.addSession(name: "Test 1")
// //     manager.addSession(name: "Test 2")
// //     manager.addSession(name: "Test 3")
// //     print(manager.fetchSessions())
// //     return SessionsViewViewModel(dataManager: manager)
// //   }()
// // }
//
// extension SessionsViewViewModel {
//   func loadPreviewData() {
//     dataManager.addSession(name: "Test 1")
//     // dataManager.addSession(name: "Test 2")
//     // dataManager.addSession(name: "Test 3")
//   }
// }

class SessionsViewViewModel: ObservableObject {
  @Published var sessions: [Session] = []
  
  private var cancellable: AnyCancellable?
  
  init(coursePublisher: AnyPublisher<[Session], Never> = SessionStorage.shared.sessions.eraseToAnyPublisher()) {
    cancellable = coursePublisher.sink { sessions in
      logger.log("receiving sessions")
      self.sessions = sessions
    }
  }
}

extension SessionsViewViewModel: SessionsViewViewModelProtocol {
  func addSession(name: String) {
    SessionStorage.shared.add(name: name)
  }
  
  func deteleSession(_ session: Session) {
    SessionStorage.shared.deleteSession(session)
  }
}
