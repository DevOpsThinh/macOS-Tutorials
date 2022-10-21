//
//  SettingsView.swift
//  MarkdownEditor
//
//  Created by Nguyễn Trường Thịnh on 20/10/2022.
//

import SwiftUI

/// A settings view - preferences window
struct SettingsView: View {
    // MARK: Properties
    /// A property wrapper for saving preferences
    @AppStorage("fontSize_ME") var fontSize: Int = 14

    var body: some View {
        Stepper(value: $fontSize, in: 11...32) {
            Text(NSLocalizedString("Font Size: ", comment: "Font Size: ") + "\(fontSize)")
                .font(.title2)
        }
        .frame(width: 300, height: 100, alignment: .center)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
