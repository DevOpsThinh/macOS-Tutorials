//
//  TodoItemDetailView.swift
//  TodoAppSwifUI
//
//  Created by Nguyễn Trường Thịnh on 05/12/2022.
//

import SwiftUI

struct TodoItemDetailView: View {
    // MARK: - PROPERTY WRAPPER
    @ObservedObject var todo: Todo

    // MARK: - SOME SORT OF VIEW
    var body: some View {
        Text(todo.name)
            .font(.custom("Nunito-Regular", size: 35, relativeTo: .largeTitle))
        Image(todo.category)
            .resizable()
            .frame(width: 200, height: 200)
    }
}

