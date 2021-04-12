//
//  SafariExtensionHandler.swift
//  SessionSaverSafari
//
//  Created by Víctor Manuel Puga Ruiz on 27/03/21.
//

import SafariServices

enum Message: String, CaseIterable, Codable {
  case loaded
}

class SafariExtensionHandler: SFSafariExtensionHandler {

  static let viewWrapper = PopoverViewWrapper.shared
  
  /**
   Converts a vanilla Safari extension message into an enumerable one and passes it along.
   */
  override func messageReceived(withName messageName: String, from page: SFSafariPage, userInfo: [String: Any]?) {
    // This method will be called when a content script provided by your extension calls safari.extension.dispatchMessage("message").
    print("message received")
    NSLog("---------------------------------")
    NSLog("---------------------------------")
    guard let message = Message.init(rawValue: messageName) else {
      NSLog("ERROR: couldn't get Message object from key \(messageName)")
      return
    }
    messageReceived(message: message, from: page, userInfo: userInfo)
  }
  
  /**
   Receives a wrapped message from the extension.
   
   - Parameter message: The type of message being received.
   - Parameter page: The page from which the message was sent.
   - Parameter userInfo: An optional dictionary containing extra information relevant to the message.
   */
  func messageReceived(message: Message, from page: SFSafariPage, userInfo: [String: Any]? = nil) {
    switch message {
      case .loaded:
        NSLog("loaded extension")
        // Saver.shared.setWindow(from: page)
        //
        // page.getPropertiesWithCompletionHandler { properties in
        //   NSLog("The extension received a message (\(message)) from a script injected into (\(String(describing: properties?.url))) with userInfo (\(userInfo ?? [:]))")
        // }
    }
  }
  
  override func toolbarItemClicked(in window: SFSafariWindow) {
    // This method will be called when your toolbar item is clicked.
    // (This only applies if the SFSafariToolbarItem.Action key in the Info.plist is Command)
    NSLog("The extension's toolbar item was clicked")
  }
  
  override func validateToolbarItem(in window: SFSafariWindow, validationHandler: @escaping ((Bool, String) -> Void)) {
    // This is called when Safari's state changed in some way that would require the extension's toolbar item to be validated again.
    validationHandler(true, "")
  }
  
  override func popoverViewController() -> SFSafariExtensionViewController {
    return SafariExtensionHandler.viewWrapper
  }
  
  override func popoverWillShow(in window: SFSafariWindow) {
    NSLog("WILL SHOW")
    NSLog(window.description)
    
    // Saver.shared.setWindow(window)
  }
  
  override func popoverDidClose(in window: SFSafariWindow) {
    
  }
}
