//
//  SessionsView.swift
//  SessionSaver
//
//  Created by Víctor Manuel Puga Ruiz on 08/04/21.
//

import SwiftUI

struct SessionsView: View {
  // MARK: - Properties
  @ObservedObject var viewModel = SessionsViewViewModel()
  
  private var empty: Bool { viewModel.sessions.isEmpty }
  
  // MARK: - Body
  var body: some View {
    VStack {
      if empty {
        Text("You have no saved sessions")
      } else {
        ForEach(viewModel.sessions) { session in
          Text(session.name)
        }
      }
      Button("Add") {
        viewModel.addSession(name: "hey")
      }
    }
    .padding()
  }
}

// MARK: - Preview
struct SessionsView_Previews: PreviewProvider {
  static var previews: some View {
    SessionsView()
      .previewLayout(.sizeThatFits)
      .padding()
  }
}
