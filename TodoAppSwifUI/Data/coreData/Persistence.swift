//
//  Persistence.swift
//  TodoAppSwifUI
//
//  Created by Nguyễn Trường Thịnh on 05/12/2022.
//

import CoreData
/// The Persistent Controller: For access the Core Data model & manage data in the internal database.
struct PersistenceController {
    // A singleton pattern which that static instance to be shared by other files
    static let shared = PersistenceController()
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
//        container = NSPersistentContainer(name: "Todo")
        container = NSPersistentCloudKitContainer(name: "Todo")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: {
            (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("unresolved error: \(error), \(error.userInfo)")
            }
        })
        // Manages changes
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }

    // TODO: Remove it before move to production

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let context = result.container.viewContext

        for i in 0..<7 {
            let newTodo = Todo(context: context)
            newTodo.id = UUID()
            newTodo.priority = .normal
            newTodo.name = "Todo item #\(i)"
            newTodo.category = "family"
        }

        do {
            try context.save()
        } catch {
            let error = error as NSError
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }

        return result
    }()

    static var testData: [Todo]? = {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Todo")
            return try? PersistenceController.preview.container.viewContext.fetch(fetchRequest) as? [Todo]
        }()
}
