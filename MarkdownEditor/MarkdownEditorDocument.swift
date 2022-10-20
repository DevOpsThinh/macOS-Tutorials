//
//  MarkdownEditorDocument.swift
//  MarkdownEditor
//
//  Created by Nguyễn Trường Thịnh on 20/10/2022.
//

import SwiftUI
import UniformTypeIdentifiers
import MarkdownKit

// MARK: Set up a doc-based app to open a particular file type (Markdown)

extension UTType {
    /// A new markdown UIType
    static var markdown: UTType {
        UTType(importedAs: "net.daringfireball.markdown")
    }
}

struct MarkdownEditorDocument: FileDocument {
    // MARK: Properties
    /// A plain text property that is what is saved with each doc (markdown) file
    var text: String
    /// An html computed property for convert it into HTML
    var html: String {
        let markdown = MarkdownParser.standard.parse(text)
        return HtmlGenerator.standard.generate(doc: markdown)
    }
    // MARK: Initializers
    init(text: String = "# Hello, MarkdownEditor!") {
        self.text = text
    }
    /// Sets what doc types this app can open
    static var readableContentTypes: [UTType] { [.markdown] }
    // MARK: Handle all the work of opening & saving the markdown (.md/ .markdown) files
    /// Handle all the work of opening & reading the markdown (.md/ .markdown) files
    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        text = string
    }
    /// Handle all the work of writting & saving the markdown (.md/ .markdown) files
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = text.data(using: .utf8)!
        return .init(regularFileWithContents: data)
    }
}
