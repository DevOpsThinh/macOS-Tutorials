//
//  Todo.swift
//  TodoAppSwifUI
//
//  Created by Nguyễn Trường Thịnh on 05/12/2022.
//

import CoreData
/// A `Priority` enumertion cases (low, normal, high) of the todo's priority
enum Priority: Int {
    case low = 0
    case normal = 1
    case high = 2
}
/// A `Category` enumertion cases (family, personal, work) of the todo's category
enum Category: String, CaseIterable {
    case family = "family"
    case personal = "personal"
    case work = "work"
}

/// A `Todo` model class for Todo entity
public class Todo: NSManagedObject {
    // MARK: - Properties
    @NSManaged public var id: UUID
    @NSManaged public var priorityNum: Int32
    @NSManaged public var name: String
    @NSManaged public var category: String
}
/// A `Todo` extension that conform to `Identifiable` protocol
extension Todo: Identifiable {
    /// A computed property for `priority` for a way to birdge between `priority` & `priorityNum`
    var priority: Priority {
        // Convert the priorityNum back to an enum case
        get {
            return Priority(rawValue: Int(priorityNum)) ?? .normal
        }
        // Retrieve the raw value of the enum case & assign it to the priorityNum
        set {
            self.priorityNum = Int32(newValue.rawValue)
        }
    }
}
