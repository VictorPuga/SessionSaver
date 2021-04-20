//
//  DBHelper.swift
//  DBHelper
//
//  Created by Víctor Manuel Puga Ruiz on 04/04/21.
//

import Foundation

public protocol DBHelperProtocol {
  associatedtype ObjectType
  associatedtype PredicateType
  
  func create(_ object: ObjectType)
  
  func fetchFirst(
    _ objectType: ObjectType.Type,
    predicate: PredicateType?
  ) -> Result<ObjectType?, Error>
  
  func fetch(
    _ objectType: ObjectType.Type,
    predicate: PredicateType?,
    limit: Int?
  ) -> Result<[ObjectType], Error>
  
  func update(_ object: ObjectType)
  
  func delete(_ object: ObjectType)
}
