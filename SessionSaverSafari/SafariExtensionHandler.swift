//
//  SafariExtensionHandler.swift
//  SessionSaverSafari
//
//  Created by Víctor Manuel Puga Ruiz on 27/03/21.
//

import SafariServices

class SafariExtensionHandler: SFSafariExtensionHandler {

  static let viewWrapper = PopoverViewWrapper.shared
  
  override func messageReceived(withName messageName: String, from page: SFSafariPage, userInfo: [String : Any]?) {
    // This method will be called when a content script provided by your extension calls safari.extension.dispatchMessage("message").
    print("message received")
    NSLog("---------------------------------")
    NSLog("---------------------------------")
    Saver.shared.setPage(page)
    page.getPropertiesWithCompletionHandler { properties in
      NSLog("The extension received a message (\(messageName)) from a script injected into (\(String(describing: properties?.url))) with userInfo (\(userInfo ?? [:]))")
    }
  }
  
  override func toolbarItemClicked(in window: SFSafariWindow) {
    // This method will be called when your toolbar item is clicked.
    // (This only applies if the SFSafariToolbarItem.Action key in the Info.plist is Button)
    NSLog("The extension's toolbar item was clicked")
  }
  
  override func validateToolbarItem(in window: SFSafariWindow, validationHandler: @escaping ((Bool, String) -> Void)) {
    // This is called when Safari's state changed in some way that would require the extension's toolbar item to be validated again.
    validationHandler(true, "")
  }
  
  override func popoverViewController() -> SFSafariExtensionViewController {
    return SafariExtensionHandler.viewWrapper
  }
  
}
