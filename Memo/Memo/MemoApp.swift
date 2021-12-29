//
//  MemoApp.swift
//  Memo
//
//  Created by 宮本大新 on 2021/12/29.
//

import SwiftUI

@main
struct MemoApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
