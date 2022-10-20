//
//  ContentView.swift
//  MarkdownEditor
//
//  Created by Nguyễn Trường Thịnh on 20/10/2022.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: MarkdownEditorDocument

    var body: some View {
        TextEditor(text: $document.text)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(MarkdownEditorDocument()))
    }
}
