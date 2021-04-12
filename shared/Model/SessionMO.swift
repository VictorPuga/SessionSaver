//
//  SessionMO.swift
//  SessionSaver
//
//  Created by Víctor Manuel Puga Ruiz on 07/04/21.
//

import CoreData

@objc(SessionMO)
final class SessionMO: NSManagedObject {
  @NSManaged var id: UUID
  @NSManaged var name: String
  
  // override func awakeFromInsert() {
  //   super.awakeFromInsert()
  //   id = UUID()
  // }
}

extension SessionMO {
  func convertToSession() -> Session {
    Session(
      id: id,
      name: name
    )
  }
}
