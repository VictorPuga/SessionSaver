//
//  TestView.swift
//  SessionSaverSafari
//
//  Created by Víctor Manuel Puga Ruiz on 27/03/21.
//

import SwiftUI
import SafariServices

struct TestView: View {
  // @StateObject var saver: Saver = .shared
  @ObservedObject var viewModel = TestViewViewModel()
  
  @State private var test = false
  
  var body: some View {
    VStack {
      Text("Hey")
      Toggle(isOn: $test) {
        Text("hello")
      }
      .toggleStyle(SwitchToggleStyle())
      Button("Get Sessions") {
        // saver.getTabs()
        viewModel.fetchSessions()
      }
      .disabled(false)
      Button("Open new tab") {
        // saver.openNewTab(url: nil)
      }
      Button("Add") {
        // saver.add()
        let int = Int.random(in: 0...100)
        viewModel.addSession(name: "\(int)")
      }
      Text(ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] ?? "no")
      Text("saver.sessions.count.description")
      ForEach(viewModel.sessions) { session in
        Text(session.name)
      }
      Text("\(viewModel.sessions.count)")
    } // :VStack
    .padding()
    .onChange(of: test) { val in
      print("change", val)
      // print(Session(name: ""))
      NSLog("cange ------------------")
    }
  }
}

struct TestView_Previews: PreviewProvider {
  static var previews: some View {
    TestView(
      viewModel: TestViewViewModel(
        dataManager: DataManager.preview
      )
    )
  }
}
