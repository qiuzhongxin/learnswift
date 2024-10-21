//
//  Chapter26App.swift
//  Chapter26
//
//  Created by Zhongxin qiu on 2024/10/21.
//

import SwiftUI

@main
struct Chapter26App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
