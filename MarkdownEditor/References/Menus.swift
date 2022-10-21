//
//  Menus.swift
//  MarkdownEditor
//
//  Created by Nguyễn Trường Thịnh on 21/10/2022.
//

import SwiftUI

/// Creating menus via Command Group/ CommandMenu
struct Menus: Commands {
    // MARK: Properties
    /// A property wrapper for saving preferences
    @AppStorage("styleSheet_ME") var style_default: StyleSheet = .customize
    var body: some Commands {
        // MARK: Add menu items to an existing menu.
        CommandGroup(before: .help) {
            // The menu item button
            Button(NSLocalizedString("Cheatsheet", comment: "Markdown Cheatsheet")) {
                showCheatSheet()
            }
            .keyboardShortcut("/", modifiers: .command)

            Divider()
        }
        // MARK: more menu items
        CommandMenu(NSLocalizedString("Stylesheet", comment: "Markdown Stylesheet")) {
            ForEach(StyleSheet.allCases, id: \.self) { style in
                Button(style.rawValue) {
                    style_default = style
                }
                .keyboardShortcut(style.shortcutKey, modifiers: .command)
            }
        }
    }
    /// Open an URL in the default browser
    func showCheatSheet() {
        let cheatSheetURL = "https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet"
        guard let url = URL(string: cheatSheetURL) else {
            fatalError(NSLocalizedString("Invalid cheatsheet URL", comment: "Invalid cheatsheet URL"))
        }
        NSWorkspace.shared.open(url)
    }
}
