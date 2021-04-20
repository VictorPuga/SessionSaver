//
//  PageMO.swift
//  SessionSaver
//
//  Created by Víctor Manuel Puga Ruiz on 12/04/21.
//

import CoreData

@objc(PageMO)
final class PageMO: NSManagedObject {
  @NSManaged var id: UUID
  @NSManaged var title: String
  @NSManaged var url: URL
  @NSManaged var index: Int16
  
  @NSManaged var ofSession: SessionMO
}

extension PageMO {
  func convertToPage() -> Page {
    Page(
      id: id,
      title: title,
      url: url,
      index: Int(index)
    )
  }
}

