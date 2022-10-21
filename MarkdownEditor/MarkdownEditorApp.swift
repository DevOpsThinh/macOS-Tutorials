//
//  MarkdownEditorApp.swift
//  MarkdownEditor
//
//  Created by Nguyễn Trường Thịnh on 20/10/2022.
//

import SwiftUI

@main
struct MarkdownEditorApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: MarkdownEditorDocument()) { file in
            ContentView(document: file.$document)
        }
        .commands {
            Menus()
        }

        Settings {
            SettingsView()
        }
    }
}
