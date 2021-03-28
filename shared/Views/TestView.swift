//
//  TestView.swift
//  SessionSaverSafari
//
//  Created by Víctor Manuel Puga Ruiz on 27/03/21.
//

import SwiftUI
import SafariServices

struct TestView: View {
  @State private var test = false
  
  var body: some View {
    VStack {
      Text("Hey")
      Toggle(isOn: $test) {
        Text("hello")
      }
      .toggleStyle(SwitchToggleStyle())
      Button("Get tabs") {
        Saver.shared.getTabs()
      }
      Button("Open new tab") {
        Saver.shared.openNewTab(url: nil)
      }
    }
    .onChange(of: test) { val in
      print("change", val)
      NSLog("cange ------------------")
    }
  }
}

struct TestView_Previews: PreviewProvider {
  static var previews: some View {
    TestView()
  }
}
