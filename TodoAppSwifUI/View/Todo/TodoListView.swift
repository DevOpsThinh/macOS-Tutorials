//
//  ContentView.swift
//  TodoAppSwifUI
//
//  Created by Nguyễn Trường Thịnh on 27/07/2021.
//

import SwiftUI
import CoreData
/// The app's main view
struct TodoListView: View {
    // MARK: - PROPERTY WRAPPER
    @Environment(\.managedObjectContext) var viewContext

    @FetchRequest(
        entity: Todo.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \Todo.category, ascending: false) ])
    var todos: FetchedResults<Todo>

    // MARK: - STATE VARIABLES
    @State private var searchText = ""
    @State private var showNewTodo = false

    // MARK: - COMPILER DIRECTIVE
    #if os(iOS)
    @Environment(\.horizontalSizeClass) var hsClass: UserInterfaceSizeClass?
    #endif

    // MARK: - SOME SORT OF VIEW
    var body: some View {
        #if os(iOS)
        if hsClass == .compact {
            NavigationView {
                view
            }
            .accentColor(Color("AccentColor"))
        } else {
            view
        }
        #else
        view
            .frame(minWidth: 400, minHeight: 600)
        #endif
    }

    @ViewBuilder
    private var view: some View {
        VStack() {
            // The search bar
            SearchBarView(text: $searchText)
                .padding([.leading, .trailing], 8)
                .padding(.bottom, 10)
            // The todo list
            List {
                // If there is no data, show an empty view
                if todos.count == 0 {
                    NoDataView()
                } else {
                    ForEach(todos.filter({
                        searchText.isEmpty ? true : $0.name.contains(searchText)
                    })) { todo in
                        // When an item is tapped
                        NavigationLink(destination: VStack {
                            TodoItemDetailView(todo: todo)
                        })
                        {
                            TodoListRowView(todo: todo)
                            // When an item is long tapped
                                .onLongPressGesture(perform: {
                                    updateTodo(todo: todo)
                                })
                        }
                    }
                    // Deleting a Todo item
                    .onDelete(perform: deleteTodo)
                }
            }
            .rotation3DEffect(Angle(degrees: showNewTodo ? 5 : 0), axis: (x: 1, y: 0, z: 0))
            .offset(y: showNewTodo ? -50 : 0)
            .animation(.easeOut, value: showNewTodo)

            Spacer()
            // Notes - hint
            Text(NSLocalizedString("When an item is long-tapped will make it done", comment: "When an item is long-tapped will make it done"))
                .font(.system(.footnote, design: .rounded))
                .foregroundColor(Color(.darkGray))
                .lineLimit(3)
                .padding(.bottom, 10)
        }
        .navigationTitle(NSLocalizedString("Todo Items", comment: "Todo Items Label"))
        .navigationBarTitleDisplayMode(.automatic)
        .toolbar { // The toolbar for users to open the AddTodoView view
            Button(action: {
                self.showNewTodo = true
            }) {
                Image(systemName: "plus.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(.purple)
            }
        }
        .sheet(isPresented: $showNewTodo) {
            AddTodoView()
        }
    }

    // MARK: - METHODS
    /// Update an exist record in the database
    private func updateTodo(todo: FetchedResults<Todo>.Element) {
        todo.name = NSLocalizedString("Completed 🤪", comment: "Completed 🤪")
        todo.priority = .low
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }
    /// Delete a exist record in the database
    private func deleteTodo(offsets : IndexSet) {
        for i in offsets {
            let todo = todos[i]
            viewContext.delete(todo)
        }

        DispatchQueue.main.async {
            do {
                try viewContext.save()
            } catch {
                print(error)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).previewDevice("iPhone SE (2nd generation)")
    }
}
