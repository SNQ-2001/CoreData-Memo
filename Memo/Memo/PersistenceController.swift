//
//  PersistenceController.swift
//  Memo
//
//  Created by 宮本大新 on 2021/12/29.
//

import CoreData
import SwiftUI

class PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        let memoEntity = NSEntityDescription()
        memoEntity.name = "Memo"
        memoEntity.managedObjectClassName = "Memo"

        let indexAttribute = NSAttributeDescription()
        indexAttribute.name = "index"
        indexAttribute.type = .integer64
        memoEntity.properties.append(indexAttribute)

        let titleAttribute = NSAttributeDescription()
        titleAttribute.name = "title"
        titleAttribute.type = .string
        memoEntity.properties.append(titleAttribute)

        let textAttribute = NSAttributeDescription()
        textAttribute.name = "text"
        textAttribute.type = .string
        memoEntity.properties.append(textAttribute)

        let model = NSManagedObjectModel()
        model.entities = [memoEntity]

        let container = NSPersistentContainer(name: "MemoModel", managedObjectModel: model)

        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("failed with: \(error.localizedDescription)")
            }
        }

        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

        container.viewContext.automaticallyMergesChangesFromParent = true
        self.container = container
    }
}
