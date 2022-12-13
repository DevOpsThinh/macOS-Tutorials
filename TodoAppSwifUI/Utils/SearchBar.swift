//
//  SearchBar.swift
//  TodoAppSwifUI
//
//  Created by Nguyễn Trường Thịnh on 06/12/2022.
//

import SwiftUI
/// A `SearchBar` struct type for use a UIKit view in SwiftUI
struct SearchBar: UIViewRepresentable {
    // MARK: - BINDINGS
    @Binding var text: String

    // MARK: - IMPLEMENT THE CUSTOM WRAPPER
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar()

        searchBar.delegate = context.coordinator

        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        searchBar.placeholder = NSLocalizedString("Search...", comment: "Search...")

        return searchBar
    }
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }

    // MARK: - DELEGATE & COMMUNICATE BACK TO SWIFTUI
    func makeCoordinator() -> Coordinator {
        Coordinator($text)
    }
    /// The `Coordinator` class acts as a bridge between UIView's delegate and SwiftUI
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String

        init(_ text: Binding<String>) {
            self._text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            searchBar.showsCancelButton = true
            text = searchText
        }
        /// Handling the cancel button
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            text = ""
            searchBar.resignFirstResponder()
            searchBar.showsCancelButton = false
            searchBar.endEditing(true)
        }

        func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
            searchBar.showsCancelButton = true
            return true
        }
    }
}

