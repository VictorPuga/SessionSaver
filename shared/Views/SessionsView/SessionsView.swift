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
    ScrollView {
      VStack {
        if empty {
          Text("You have no saved sessions")
        } else {
          ForEach(viewModel.sessions) { session in
            SessionRowView(session: session, onTap: viewModel.deteleSession)
          }
        }
        // Button("Add") {
        // }
        Button("Save current Session") {
          viewModel.addSession(name: String(Int.random(in: 0...999)))
        }
      }
      // .padding()
      .frame(width: 200, height: 300, alignment: .center)
    }
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
