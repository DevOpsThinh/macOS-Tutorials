//
//  ContentView.swift
//  MarkdownEditor
//
//  Created by Nguyễn Trường Thịnh on 20/10/2022.
//

import SwiftUI

struct ContentView: View {
    // MARK: Properties
    /// A property wrapper for saving preferences
    @AppStorage("fontSize_ME") var fontSize: Int = 14

    @State private var previewState = PreviewState.web

    @Binding var document: MarkdownEditorDocument

    /// Markdown in AttributedStrings
    @available(macOS 12, *)
    var attributedString: AttributedString {
        let md_options = AttributedString.MarkdownParsingOptions(
            interpretedSyntax: .inlineOnly
        )
        let aString = try? AttributedString(
            markdown: document.text,
            options: md_options
        )
        return aString ?? AttributedString(NSLocalizedString("Error has happened", comment: "There was an error parsing the Markdown."))
    }

    var body: some View {
        HSplitView {
            TextEditor(text: $document.text)
                .font(.system(size: CGFloat(fontSize)))
                .frame(minWidth: 200)
            if previewState == .web {
                WebView(html: document.html)
                    .frame(minWidth: 200)
            } else if previewState == .html {
                ScrollView {
                    if #available(macOS 12.0, *) {
                        Text(attributedString)
                            .frame(minWidth: 200, maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                            .padding()
                            .font(.system(size: CGFloat(fontSize)))
                            .textSelection(.enabled)
                    } else {
                        // Fallback on earlier versions
                        Text(document.html)
                            .frame(minWidth: 200, maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                            .padding()
                            .font(.system(size: CGFloat(fontSize)))
                    }
                }
            }
        }
        .frame(minWidth: 400, idealWidth: 600, maxWidth: .infinity, minHeight: 300, idealHeight: 400, maxHeight: .infinity, alignment: .center)
        .toolbar {
            PreviewToolBarItem(previewState: $previewState)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(MarkdownEditorDocument()))
    }
}
