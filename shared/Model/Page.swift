//
//  Page.swift
//  SessionSaverSafari
//
//  Created by Víctor Manuel Puga Ruiz on 27/03/21.
//

import Foundation

struct Page: Equatable, Identifiable {
  let id: UUID
  let title: String
  let url: URL
  let index: Int

  static let blank = Page()

  init() {
    id = UUID()
    title = "Blank"
    url = URL(string: "https://")!
    index = 0
  }
  
  init(id: UUID, title: String, url: URL, index: Int) {
    self.id = id
    self.title = String(title.prefix(40))
    self.url = url
    self.index = index
  }

  init(title: String, url: URL, index: Int) {
    self.init(id: UUID(), title: title, url: url, index: index)
  }

  var description: String {
    "SessionSaver.Page(title: \(title), url: \(url), index: \(index)"
  }
}

