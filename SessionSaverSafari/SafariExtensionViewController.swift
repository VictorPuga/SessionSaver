//
//  SafariExtensionViewController.swift
//  SessionSaverSafari
//
//  Created by Víctor Manuel Puga Ruiz on 27/03/21.
//

import SafariServices
import SwiftUI

class PopoverViewWrapper: SFSafariExtensionViewController {
  private init() {
    super.init(nibName: nil, bundle: nil)
    
    // let state = AppState()
    // if Bundle.main.object(forInfoDictionaryKey: "MAC_APP_STORE") as? Bool ?? true {
    //   state.setFromMacAppStore()
    // }
    // let view = PopoverView().environmentObject(state)
    // self.view = NSHostingView(rootView: view)
    let view = TestView()
    let wrapper = NSHostingView(rootView: view)
    
    wrapper.setBoundsSize(NSSize(width: 400, height: 500))
    
    self.view = wrapper
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}

extension PopoverViewWrapper {
  static let shared = PopoverViewWrapper()
}
