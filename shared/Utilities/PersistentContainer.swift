//
//  PersistentContainer.swift
//  SessionSaver
//
//  Created by Víctor Manuel Puga Ruiz on 08/04/21.
//

// import Foundation
// import SwiftUI
import CoreData
// import CloudKit

class PersistentContainer {
  private static var _model: NSManagedObjectModel?
  
  private static func model(name: String) throws -> NSManagedObjectModel {
    if _model == nil {
      _model = try loadModel(name: name, bundle: Bundle.main)
    }
    return _model!
  }
  
  private static func loadModel(name: String, bundle: Bundle) throws -> NSManagedObjectModel {
    guard let modelURL = bundle.url(forResource: name, withExtension: "momd") else {
      throw CoreDataError.modelURLNotFound(forResourceName: name)
    }
    
    guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
      throw CoreDataError.modelLoadingFailed(forURL: modelURL)
    }
    return model
  }
  
  enum CoreDataError: Error {
    case modelURLNotFound(forResourceName: String)
    case modelLoadingFailed(forURL: URL)
  }
  
  public static func container() throws -> NSPersistentContainer {
    let name = "SessionSaver"
    // return NSPersistentCloudKitContainer(name: name, managedObjectModel: try model(name: name))
    return CustomPersistentContainer(name: name, managedObjectModel: try model(name: name))
  }
}

class CustomPersistentContainer: NSPersistentContainer {
  override open class func defaultDirectoryURL() -> URL {
    var storeURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "TZ5YSJH8XE.group.com.VictorPuga.SessionSaver")
    
    for path in ["Library", "Application Support", "SessionSaver"] { 
      storeURL = storeURL?.appendingPathComponent(path)
    }
    
    return storeURL!
  }
}
