//
//  Page.swift
//  SessionSaverSafari
//
//  Created by Víctor Manuel Puga Ruiz on 27/03/21.
//

import Foundation

struct Page : Codable, Equatable {
  let title: String
  let url: URL
  
  static let blank = Page()
  
  init() {
    title = "Blank"
    url = URL(string: "https://")!
  }
  
  init(title: String, url: URL) {
    self.title = String(title.prefix(40))
    self.url = url
  }
  
  var description: String {
    "SessionSaver.Page(title: \(title), url: \(url))"
  }
}
