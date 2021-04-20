//
//  SafariManager.swift
//  SessionSaverSafari
//
//  Created by Víctor Manuel Puga Ruiz on 27/03/21.
//

import SafariServices
import Combine

class SafariManager {
  private var currentPage: SFSafariPage?
  private var currentWindow: SFSafariWindow?
  
  func setWindow(_ newWindow: SFSafariWindow) {
    currentWindow = newWindow
  }
  
  func setWindow(from page: SFSafariPage) {
    page.getContainingTab { tab in
      tab.getContainingWindow { window in
        self.currentWindow = window
      }
    }
  }
  
  func getPage(_ tab: SFSafariTab, completion: @escaping (Page) -> Void) {
    tab.getActivePage { page in
      guard let page = page else { return }
      page.getPropertiesWithCompletionHandler { properties in
        guard let properties = properties else { return }
        guard let url = properties.url else { return }
        guard url.scheme == "http" || url.scheme == "https" else { return }
        guard let title = properties.title else { return }

        let newPage = Page(title: title, url: url, index: 0)
        completion(newPage)
      }
    }
  }
  
  func getPage(from tab: SFSafariTab) -> AnyPublisher<Page, Never> {
    return Deferred {
      Future() { promise in
        self.getPage(tab) { page in
          promise(.success(page))
        }
      }
    }
    .eraseToAnyPublisher()
  }
  
  func getTabsPublisher() -> AnyPublisher<[SFSafariTab], Never> {
    guard let window = currentWindow else {
      logger.log("No window")
      fatalError("No Window")
    }
    return Deferred {
      Future { promise in
        window.getAllTabs { tabs in
          promise(.success(tabs))
        }
      }
    }.eraseToAnyPublisher()
  }
  
  func getTabs() -> AnyPublisher<[Page], Never> {
    return Deferred {
      self.getTabsPublisher()
        .flatMap { tabs in
          Publishers.MergeMany(
            tabs.map(self.getPage(from:))
          )
          .collect()
          // .eraseToAnyPublisher()
        }
    }
    .eraseToAnyPublisher()
  }
}


func openNewTab(url: URL?) {
  if let url = url {
    NSWorkspace.shared.open(url)
  } else {
    // NSWorkspace.shared.open(Page.blank.url)
  }
}

extension SafariManager {
  static let shared = SafariManager()
}
