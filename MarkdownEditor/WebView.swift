//
//  WebView.swift
//  MarkdownEditor
//
//  Created by Nguyễn Trường Thịnh on 20/10/2022.
//

import SwiftUI
import WebKit

// MARK: Integrating AppKit's WKWebView within SwiftUI
/// Embed - bridging WKWebView (AppKit's NSViews) into a SwiftUI view.
struct WebView: NSViewRepresentable {
    var html: String

    init(html: String) {
        self.html = html
    }

    func makeNSView(context: Context) -> some WKWebView {
        WKWebView()
    }

    func updateNSView(_ nsView: NSViewType, context: Context) {
        nsView.loadHTMLString(html, baseURL: Bundle.main.resourceURL)
    }
}
