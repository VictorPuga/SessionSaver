//
//  Saver.swift
//  SessionSaverSafari
//
//  Created by Víctor Manuel Puga Ruiz on 27/03/21.
//

import SafariServices
import Combine

// class Saver: ObservableObject {
//   @Published var sessions: [Session] = []
//
//   private var cancellable: AnyCancellable?
//
//   private var currentPage: SFSafariPage?
//   private var currentWindow: SFSafariWindow?
//
//   private var storage: SessionStorage?
//
//   private var dataManager: DataManagerProtocol = DataManager.shared
//
//   // private init(
//   //   sessionPublisher: AnyPublisher<[Session], Never> = SessionStorage.shared.sessions.eraseToAnyPublisher()
//   // ) {
//   //   cancellable = sessionPublisher.sink { sessions in
//   //     logger.log("Updating sessions")
//   //     self.sessions = sessions
//   //   }
//   // }
//
//   // private init(preview: Bool) {
//   //
//   // }
//
//   // func setPage(_ newPage: SFSafariPage) {
//   //   page = newPage
//   // }
//   func fetchSessions() {
//     dataManager.fetchSessions()
//   }
//
//   func setWindow(_ newWindow: SFSafariWindow) {
//     currentWindow = newWindow
//   }
//
//   func setWindow(from page: SFSafariPage) {
//     page.getContainingTab { tab in
//       tab.getContainingWindow { window in
//         self.currentWindow = window
//       }
//     }
//   }
//
//   func add() {
//     SessionStorage.shared.add()
//   }
//
//   // func getTabs() {
//   //   if let page = page {
//   //     NSLog("getting tabs")
//   //     page.getContainingTab { currentTab in
//   //       currentTab.getContainingWindow { window in
//   //         self.currentWindow = window
//   //         window?.getAllTabs { tabs in
//   //           for tab in tabs {
//   //             self.getTabInfo(tab)
//   //           }
//   //         }
//   //       }
//   //     }
//   //   } else {
//   //     NSLog("No page :(")
//   //   }
//   // }
//
//   func getTabs() {
//     guard let window = currentWindow else {
//       NSLog("No window")
//       return
//     }
//     window.getAllTabs { tabs in
//       for tab in tabs {
//         self.getTabInfo(tab)
//       }
//     }
//   }
//
//   func getTabInfo(_ tab: SFSafariTab) {
//     tab.getActivePage { page in
//       guard let page = page else { return }
//       page.getPropertiesWithCompletionHandler { properties in
//         guard let properties = properties else { return }
//         guard let url = properties.url else { return }
//         guard url.scheme == "http" || url.scheme == "https" else { return }
//         guard let title = properties.title else { return }
//
//         // let page = Page(title: title, url: url)
//         let page = Page()
//         page.title = title
//         page.url = url
//
//         NSLog(page.description)
//       }
//       // NSWorkspace.shared.open(URL(string:"https://www.google.com")!)
//     }
//   }
//
//   func openNewTab(url: URL?) {
//     if let url = url {
//       NSWorkspace.shared.open(url)
//     } else {
//       // NSWorkspace.shared.open(Page.blank.url)
//     }
//   }
// }
//
// extension Saver {
//   // static let shared = Saver()
//   // static let preview = Saver(
//   //   sessionPublisher: SessionStorage.preview.sessions.eraseToAnyPublisher()
//   // )
// }
