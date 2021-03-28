//
//  AppState.swift
//  SessionSaverSafari
//
//  Created by Víctor Manuel Puga Ruiz on 27/03/21.
//

import SwiftUI
import Combine

class AppState: ObservableObject {
  @Published var sessions: [Session] = []
}
