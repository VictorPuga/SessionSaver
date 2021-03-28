//
//  Session.swift
//  SessionSaverSafari
//
//  Created by Víctor Manuel Puga Ruiz on 27/03/21.
//

import Foundation

struct Session: Codable {
  let name: String
  let pages: [Page]
}
