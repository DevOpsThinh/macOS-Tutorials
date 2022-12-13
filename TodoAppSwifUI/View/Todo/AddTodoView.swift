//
//  AddItemView.swift
//  TodoAppSwifUI
//
//  Created by Nguyễn Trường Thịnh on 05/12/2022.
//

import SwiftUI
/// The add todo view for adding user inputs
struct AddTodoView: View {
    // MARK: - PROPERTY WRAPPER
    @Environment(\.managedObjectContext) var context
    @Environment(\.dismiss) private var dismiss

    @ObservedObject private var todoViewModel: TodoFormViewModel

    // MARK: - STATE VARIABLES
    @State var isEditing = false
    @State var selectedCategory = 0

    var categoryTypes = Category.allCases

    // MARK: - INITIALIZERS
    init() {
        let viewModel = TodoFormViewModel()
        todoViewModel = viewModel
    }

    // MARK: - SOME SORT OF VIEW
    var body: some View {
        VStack {
            Text(NSLocalizedString("Add To-do", comment: "Add To-do Label"))
                .font(.largeTitle)
                .foregroundColor(Color("AccentColor"))
                .padding()
            VStack(alignment: .leading) {
                // INPUT TEXT
                FormTextField(
                    value: $todoViewModel.name, isEditing: $isEditing,
                    label: NSLocalizedString("Name", comment: "Name label"),
                    placeholder: NSLocalizedString("To-do name", comment: "To do name hint"))
                // CATEGORY
                Text(NSLocalizedString("Select Category", comment: "Select Category").uppercased())
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(Color(.darkGray))

                Picker("", selection: $selectedCategory) {
                    ForEach(0..<categoryTypes.count) {
                        Text(categoryTypes[$0].rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(10)
                // PRIORITY
                Text(NSLocalizedString("Priority", comment: "Priority Label").uppercased())
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(Color(.darkGray))
                    .padding(.bottom, 10)
            }
            HStack {
                Text(NSLocalizedString("High", comment: "High"))
                    .font(.system(.headline, design: .rounded))
                    .padding(10)
                    .background(todoViewModel.priority == .high ? Color.red : Color(.systemGray4))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .onTapGesture {
                        todoViewModel.priority = .high
                    }

                Text(NSLocalizedString("Normal", comment: "Normal"))
                    .font(.system(.headline, design: .rounded))
                    .padding(10)
                    .background(todoViewModel.priority == .normal ? Color.orange : Color(.systemGray4))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .onTapGesture {
                        todoViewModel.priority = .normal
                    }

                Text(NSLocalizedString("Low", comment: "Low"))
                    .font(.system(.headline, design: .rounded))
                    .padding(10)
                    .background(todoViewModel.priority == .low ? Color.green : Color(.systemGray4))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .onTapGesture {
                        todoViewModel.priority = .low
                    }
            }
            .padding(.bottom, 30)
            // DONE BUTTON
            Button(action: {
                if todoViewModel.name
                    .trimmingCharacters(in: .whitespaces) == "" {
                    return
                }
                addTodo(category: self.categoryTypes[selectedCategory])
                dismiss()
            }, label: {
                Text(NSLocalizedString("Done", comment: "Done").uppercased())
                    .font(.system(.headline, design: .rounded))
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.purple)
                    .cornerRadius(5)
            })
                .padding(.bottom)
        }
        .padding()

        Spacer()
    }

    // MARK: - METHODS
    /// Insert a new record into the database
    private func addTodo(category: Category) {
        let task = Todo(context: context)
        task.id = UUID()
        task.priority = todoViewModel.priority
        task.name = todoViewModel.name
        todoViewModel.category = category.rawValue
        task.category = todoViewModel.category

        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}

