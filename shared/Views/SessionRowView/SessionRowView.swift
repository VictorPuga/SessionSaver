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
  
  var count: Int { session.pages.count }
  
  var body: some View {
    Section(header: header) {
      GroupBox {
        VStack {
          
          ForEach(0..<count) { i in
            VStack {
              Text(pages[i].title)
                .font(.caption)
              
              divider(i)
            }
            // VStack(alignment: .leading) {
            //   Divider()
            // }
          }
        }
      }
    }
    
  }
  
  var header: some View {
    HStack {
      Text(session.name)
        .font(.title)
      Button("v") {
        
      }
      Spacer()
      Button("GEAR") {
        
      }
      Button("OPEN") {
        
      }
    }
  }
  
  func divider(_ i: Int) -> some View {
    if (i != count - 1) {
      return AnyView(Divider())
    }
    return AnyView(EmptyView())
  }
  
  var body2: some View {
    Section(header: Text("title")) {
      VStack(alignment: .leading, spacing: 0) {
        HStack {
          Text(session.name)
            .font(.largeTitle)
          Spacer()
          Button("Delete") {
            onTap(session)
          }
          Button("Open") {
            SafariManager.shared.openSession(session)
          }
        }
        ForEach(pages) { page in
          VStack(alignment: .leading) {
            Divider()
            Text(page.title)
              .font(.caption)
          }
        }
      }
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
