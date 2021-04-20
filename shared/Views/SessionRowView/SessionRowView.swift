//
//  SessionRowView.swift
//  SessionSaver
//
//  Created by Víctor Manuel Puga Ruiz on 12/04/21.
//

import SwiftUI

struct SessionRowView: View {
  let session: Session
  let onTap: (Session) -> Void
  
  var pages: [Page] {
    session.pages.sorted(by: \.index)
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(session.name)
        .onTapGesture {
          onTap(session)
      }
      ForEach(pages) { page in
        Text(page.title)
          .font(.caption)
      }
    }

  }
}

struct SessionRowView_Previews: PreviewProvider {
  static var previews: some View {
    SessionRowView(
      session: Session(
        id: UUID(),
        name: "Test 1",
        pages: [.blank]
      ),
      onTap: { _ in}
    )
    .padding()
  }
}
