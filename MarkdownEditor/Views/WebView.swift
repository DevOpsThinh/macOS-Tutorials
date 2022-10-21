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
    // MARK: Properties
    /// A property wrapper for saving preferences
    @AppStorage("styleSheet_ME") var style_default: StyleSheet = .customize

    var html: String
    var formattedHtml: String {
        return """
                  <html>
                      <head>
                        <link rel="stylesheet" href="\(style_default).css">
                      </head>
                      <body>
                        \(html)
                      </body>
                  </html>
                  """
    }

    init(html: String) {
        self.html = html
    }

    func makeNSView(context: Context) -> some WKWebView {
        WKWebView()
    }

    func updateNSView(_ nsView: NSViewType, context: Context) {
        nsView.loadHTMLString(formattedHtml, baseURL: Bundle.main.resourceURL)
    }
}
