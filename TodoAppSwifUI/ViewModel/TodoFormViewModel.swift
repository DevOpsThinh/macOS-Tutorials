//
//  TodoFormViewModel.swift
//  TodoAppSwifUI
//
//  Created by Nguyễn Trường Thịnh on 06/12/2022.
//

import Combine
import SwiftUI
/// A `TodoFormViewModel` class type that conform to `ObservableObject` protocol
/// A view model to pair with the AddTodoView view
class TodoFormViewModel: ObservableObject {
    // MARK: - DATA ENTRY
    @Published var priority: Priority = .normal
    @Published var name: String = ""
    @Published var category: String = "family"

    // MARK: - INITIALIZERS
    init(todo: Todo? = nil) {
        if let todo = todo {
            self.priority = todo.priority
            self.name = todo.name
            self.category = todo.category
        }
    }
}
