//
//  Logger.swift
//  SessionSaver
//
//  Created by Víctor Manuel Puga Ruiz on 04/04/21.
//

import os

class MyLogger {
  func log<T: CustomStringConvertible>(_ message: T?) {
    if let message = message {
      os_log("%{public}s", message.description)
    } else {
      os_log("'nil'")
    }
  }
  
  func log<T: CustomStringConvertible>(_ messages: [T?]?) {
    if let messages = messages {
      for message in messages {
        log(message)
      }
    } else {
      os_log("'nil'")
    }
  }
}

let logger = MyLogger()
