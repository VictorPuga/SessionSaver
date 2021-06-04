import Foundation

let mockPages = [
  Page(title: "Page 1", url: URL(string: "apple.com")!, index: 0),
  Page(title: "Page 2", url: URL(string: "apple.com")!, index: 1),
  Page(title: "Page 3", url: URL(string: "apple.com")!, index: 2)
]

let mockSessions = [
  Session(id: .init(), name: "Session 1", pages: mockPages),
  Session(id: .init(), name: "Session 2", pages: [mockPages[0]]),
  Session(id: .init(), name: "Session 3", pages: [mockPages[1]])
]
