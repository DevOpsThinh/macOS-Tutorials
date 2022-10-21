//
//  Toolbars.swift
//  MarkdownEditor
//
//  Created by Nguyễn Trường Thịnh on 21/10/2022.
//

import SwiftUI

/// Three states for controls to switch between three preview modes
enum PreviewState {
    case hidden  // Off
    case html  // HTML
    case web  // Web
}
/// Creating a toolbar
struct PreviewToolBarItem: ToolbarContent {
    @Binding var previewState: PreviewState

    var body: some ToolbarContent {
        ToolbarItem {
            Picker("", selection: $previewState) {
                Image(systemName: "eye.slash")
                    .tag(PreviewState.hidden)
                Image(systemName: "doc.plaintext")
                    .tag(PreviewState.html)
                Image(systemName: "doc.richtext")
                    .tag(PreviewState.web)
            }
            .pickerStyle(SegmentedPickerStyle())
            .help(NSLocalizedString("Hide preview, show HTML or Web view", comment: "Hide preview, show HTML or Web view"))
        }
    }
}
