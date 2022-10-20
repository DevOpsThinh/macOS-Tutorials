//
//  ContentView.swift
//  MarkdownEditor
//
//  Created by Nguyễn Trường Thịnh on 20/10/2022.
//

import SwiftUI

struct ContentView: View {
    // MARK: Properties

    @Binding var document: MarkdownEditorDocument
    /// A property wrapper for saving preferences
    @AppStorage("fontSize_ME") var fontSize: Int = 14

    var body: some View {
        HSplitView {
            TextEditor(text: $document.text)
                .font(.system(size: CGFloat(fontSize)))
                .frame(minWidth: 200)
            WebView(html: document.html)
                .frame(minWidth: 200)
        }
        .frame(minWidth: 400, idealWidth: 600, maxWidth: .infinity, minHeight: 300, idealHeight: 400, maxHeight: .infinity, alignment: .center)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(MarkdownEditorDocument()))
    }
}
