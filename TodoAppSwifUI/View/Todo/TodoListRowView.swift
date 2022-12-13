//
//  TodoItemView.swift
//  TodoAppSwifUI
//
//  Created by Nguyễn Trường Thịnh on 05/12/2022.
//

import SwiftUI

struct TodoListRowView: View {
    // MARK: - PROPERTY WRAPPER
    @Environment(\.managedObjectContext) var context
    @ObservedObject var todo: Todo

    // MARK: - COMPILER DIRECTIVE
    #if os(iOS)
    @Environment(\.horizontalSizeClass) var hsClass: UserInterfaceSizeClass?
    #endif
    
    // MARK: - SOME SORT OF VIEW
    var body: some View {
        HStack {
            Image(todo.category)
                .resizable()
                .frame(width: 50, height: 50)
            Text(todo.name)
                .font(.custom("Nunito-Regular", size: 20, relativeTo: .headline))
            Spacer()
            Circle()
                .frame(width: 15, height: 15)
                .foregroundColor(
                    self.color(for: self.todo.priority))
        }
    }
    // MARK: - METHODS
    private func color(for priority: Priority) -> Color {
        switch priority {
        case .low:
            return .green
        case .normal:
            return .orange
        case .high:
            return .red
        }
    }
}
