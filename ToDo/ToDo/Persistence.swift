//
//  Persistence.swift
//  ToDo
//
//  Created by Zhongxin qiu on 2024/10/24.
//

import CoreData
struct Persistence {
    static let shared = Persistence()
    let container: NSPersistentContainer
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Model")
        if inMemory{container.persistentStoreDescriptions.first!.url =
            URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
