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
  
  var body: some View {
    VStack(alignment: .leading) {
      List {
        header
        if empty {
          Text("You have no saved sessions")
        } else {
          ForEach(viewModel.sessions) { session in
            SessionRowView(session: session, onTap: viewModel.deteleSession)
          }
        }
      }
      .listStyle(InsetListStyle())
    }
    // .frame(width: 200, height: 300, alignment: .center)
  }
  
  var header: some View {
    HStack {
      Text("Sessions")
        .font(.largeTitle)
        .foregroundColor(Color(.textColor))
      Spacer()
      Button("SETTINGS") {}
      if Bundle.main.bundlePath.hasSuffix(".appex") {
        Button("Save current Session") {
          viewModel.addSession(name: String(Int.random(in: 0...999)))
        }
        // NewSessionButton()
      }
    }
  }
}

// MARK: - Preview
struct SessionsView_Previews: PreviewProvider {
  static var previews: some View {
    SessionsView(
      viewModel: .init(
        sessionPublisher:
          mockSessions
          .publisher
          .collect()
          .eraseToAnyPublisher()
      )
    )
    .previewLayout(.sizeThatFits)
  }
}
