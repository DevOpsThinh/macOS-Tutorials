//
//  SearchBarView.swift
//  TodoAppSwifUI
//
//  Created by Nguyễn Trường Thịnh on 07/12/2022.
//

import SwiftUI
/// The Search Bar View
struct SearchBarView: View {
    // MARK: - BINDINGS
    @Binding var text: String
    
    // MARK: - STATE VARIABLES
    @State private var isEditing = false

    private var searchText: Binding<String> {
        Binding<String>(
            get: {
                self.text.capitalized
            }, set: {
                self.text = $0
            }
        )
    }
    
    // MARK: - SOME SORT OF VIEW
    var body: some View {
        HStack {
            // INPUT TEXT
            TextField(
                NSLocalizedString("Search...", comment: "Search hint"),
                text: searchText
            )
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(15)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)

                        if isEditing {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }

            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
                    // Dismiss the keyboard
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    Text(NSLocalizedString("Cancel", comment: "Cancel"))
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default, value: isEditing)
            }
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(text: .constant(""))
    }
}
