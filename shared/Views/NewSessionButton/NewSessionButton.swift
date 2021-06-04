//
//  NewSessionButton.swift
//  SessionSaver
//
//  Created by Víctor Manuel Puga Ruiz on 19/04/21.
//

import SwiftUI

struct NewSessionButton: View {
  // MARK: - Properties
  @State private var showModal: Bool = false
  
  // MARK: - Body
  var body: some View {
    // NavigationView {
    //   NavigationLink(
    //     destination: Text("Destination")) {
        
      Button("Save current") {
        // viewModel.addSession(name: String(Int.random(in: 0...999)))
        showModal.toggle()
      }
    //   }
    // }
    // .navigationViewStyle(DoubleColumnNavigationViewStyle())
  }
}

// MARK: - Preview
struct NewSessionButton_Previews: PreviewProvider {
  static var previews: some View {
    NewSessionButton()
      .previewLayout(.sizeThatFits)
      .padding()
  }
}
