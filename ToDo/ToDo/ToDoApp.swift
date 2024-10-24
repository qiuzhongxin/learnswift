//
//  ToDoApp.swift
//  ToDo
//
//  Created by Zhongxin qiu on 2024/10/22.
//

import SwiftUI

@main
struct ToDoApp: App {
    let persistenceController = Persistence.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext,
                              persistenceController.container.viewContext)
        }
    }
}
