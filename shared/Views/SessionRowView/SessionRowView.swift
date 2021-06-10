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
  
  @State private var closed = false
  
  var pages: [Page] {
    session.pages.sorted(by: \.index)
  }
  
  var count: Int { session.pages.count }
  
  var body: some View {
    Section(header: header) {
      GroupBox {
        VStack(alignment: .leading, spacing: 0) {
          ForEach(pages) { page in
            VStack(alignment: .leading) {
              Text(page.title)
                .font(.caption)
              divider(page.index)
            }
          }
        }
      }
    }
  }
  
  var header: some View {
    HStack {
      Text(session.name)
        .font(.title)
      Button(action: {
        withAnimation {
          closed.toggle()
        }
      }) {
        Label("Toggle", systemImage: "chevron.down")
          .labelStyle(IconOnlyLabelStyle())
          .rotationEffect(closed ? .degrees(-90) : .zero)
      }
      .buttonStyle(BorderlessButtonStyle())
      Spacer()
      Button("DELETE/GEAR??") {
        onTap(session)
      }
      Button("OPEN") {
        SafariManager.shared.openSession(session)
      }
    }
  }
  
  @ViewBuilder
  func divider(_ i: Int) -> some View {
    if (count == 1 || i != count - 1) {
      Divider()
    } else {
      EmptyView()
    }
  }
}

struct SessionRowView_Previews: PreviewProvider {
  static var previews: some View {
    List {
      SessionRowView(
        session: mockSessions[0],
        onTap: { _ in}
      )
      .listStyle(SidebarListStyle())
      .padding()
    }
  }
}
