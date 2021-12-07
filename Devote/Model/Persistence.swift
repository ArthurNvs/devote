//
//  Persistence.swift
//  Devote
//
//  Created by Arthur Neves on 06/12/21.
//

import CoreData

struct PersistenceController {
  // MARK: - 1. PERSISTENT CONTROLLER
  static let shared = PersistenceController()
  
  // MARK: - 2. PERSISTENT CONTAINER
  let container: NSPersistentContainer
  
  // MARK: - 3. INITIALIZATION (load the persistent store)
  init(inMemory: Bool = false) {
    container = NSPersistentContainer(name: "Devote")
    if inMemory {
      container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
    }
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
        /*
         Typical reasons for an error here include:
         * The parent directory does not exist, cannot be created, or disallows writing.
         * The persistent store is not accessible, due to permissions or data protection when the device is locked.
         * The device is out of space.
         * The store could not be migrated to the current model version.
         Check the error message to determine what the actual problem was.
         */
      }
    })
  }
  
  // MARK: - 4. PREVIEW
  static var preview: PersistenceController = {
    let result = PersistenceController(inMemory: true)
    let viewContext = result.container.viewContext
    for i in 0..<8 {
      let newItem = Item(context: viewContext)
      newItem.timestamp = Date()
      newItem.task = "Sample task nº\(i)"
      newItem.completion = false
      newItem.id = UUID()
    }
    do {
      try viewContext.save()
    } catch {
      let nsError = error as NSError
      fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
    return result
  }()
}
