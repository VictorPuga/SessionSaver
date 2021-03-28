//
//  Saver.swift
//  SessionSaverSafari
//
//  Created by Víctor Manuel Puga Ruiz on 27/03/21.
//

import Foundation
import SafariServices

class Saver {
  private var page: SFSafariPage?
  private var pageWindow: SFSafariWindow?
  
  private init() {}
  
  func setPage(_ newPage: SFSafariPage) {
    page = newPage
  }
  
  func getTabs() {
    if let page = page {
      NSLog("getting tabs")
      page.getContainingTab { currentTab in
        currentTab.getContainingWindow { window in
          self.pageWindow = window
          window?.getAllTabs { tabs in
            for tab in tabs {
              self.getTabInfo(tab)
            }
          }
        }
      }
    } else {
      NSLog("No page :(")
    }
  }
  
  func getTabInfo(_ tab: SFSafariTab) {
    tab.getActivePage { (page) in
      guard let page = page else { return }
      page.getPropertiesWithCompletionHandler{ properties in
        guard let properties = properties else { return }
        guard let url = properties.url else { return }
        guard url.scheme == "http" || url.scheme == "https" else { return }
        guard let title = properties.title else { return }
        
        let page = Page(title: title, url: url)
        
        NSLog(page.description)
      }
      // NSWorkspace.shared.open(URL(string:"https://www.google.com")!)
    }
  }
  
  func openNewTab(url: URL?) {
    if let url = url {
      NSWorkspace.shared.open(url)
    } else {
      NSWorkspace.shared.open(Page.blank.url)
    }
  }
}

extension Saver {
  static let shared = Saver()
}
