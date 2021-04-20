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
  func addSession(name: String)
}

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
