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
    VStack(alignment: .leading) {
      List {
        HStack {
          Spacer()
          Button("SETTINGS") {}
        }
        if empty {
          Text("You have no saved sessions")
        } else {
          Section(header: header) {
            ForEach(viewModel.sessions) { session in
              SessionRowView(session: session, onTap: viewModel.deteleSession)
            }
          }
        }
        if Bundle.main.bundlePath.hasSuffix(".appex") {
          Button("Save current Session") {
            viewModel.addSession(name: String(Int.random(in: 0...999)))
          }
          NewSessionButton()
        }
      }
      .listStyle(InsetListStyle())
    }
    // .frame(width: 200, height: 300, alignment: .center)
  }
  
  var header: some View {
    Text("Sessions")
      .font(.largeTitle)
      .foregroundColor(.white)
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
