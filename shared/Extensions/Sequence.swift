//
//  Sequence.swift
//  SessionSaver
//
//  Created by Víctor Manuel Puga Ruiz on 19/04/21.
//

import Foundation

extension Sequence {
  func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
    return sorted { a, b in
      return a[keyPath: keyPath] < b[keyPath: keyPath]
    }
  }
}
