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
  
  @NSManaged var pages: NSSet
  
  // override func awakeFromInsert() {
  //   super.awakeFromInsert()
  //   id = UUID()
  // }
}

extension SessionMO {
  func convertToSession() -> Session {
    return Session(
      id: id,
      name: name,
      pages: pages.map { ($0 as! PageMO).convertToPage() }
    )
  }
}
