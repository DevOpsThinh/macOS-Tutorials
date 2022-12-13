//
//  Forms.swift
//  TodoAppSwifUI
//
//  Created by Nguyễn Trường Thịnh on 06/12/2022.
//

import SwiftUI

struct FormTextView: View {
    // MARK: - Bindings
    /// The binding to the field value
    @Binding var value: String
    // MARK: - Properties
    /// The label displayed right above the text editor
    let label: String
    /// The initial value of the text editor's height
    var height: CGFloat = 30.0

    var body: some View {
        VStack(alignment: .leading) {
            Text(label.uppercased())
                .font(.system(.headline, design: .rounded))
                .foregroundColor(Color(.darkGray))

            TextEditor(text: $value)
                .frame(maxWidth: .infinity)
                .frame(height: height)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(.systemGray5), lineWidth: 1)
                )
        }
    }
}

struct FormTextField: View {
    // MARK: - Bindings
    /// The binding to the field value
    @Binding var value: String
    @Binding var isEditing: Bool
    // MARK: - Properties
    /// The label displayed right above the text field
    let label: String
    /// The initial value of the text field
    var placeholder: String = ""

    var body: some View {
        VStack(alignment: .leading) {
            Text(label.uppercased())
                .font(.system(.headline, design: .rounded))
                .foregroundColor(Color(.darkGray))

            TextField(placeholder, text: $value, onEditingChanged: { e in
                    self.isEditing = e
            })
                .font(.system(.body, design: .rounded))
                .textFieldStyle(PlainTextFieldStyle())
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(.systemGray5), lineWidth: 1)
                )
                .padding(.vertical, 10)
        }
    }
}

struct Forms_Previews: PreviewProvider {
    static var previews: some View {
        FormTextView(value: .constant(""), label: "Website URL")
                    .previewLayout(.sizeThatFits)

        FormTextField(value: .constant(""), isEditing: .constant(true), label: "Name", placeholder: "Fill in the todo name")
            .previewLayout(.fixed(width: 300, height: 200))
    }
}
