//
//  StyleSheet.swift
//  MarkdownEditor
//
//  Created by Nguyễn Trường Thịnh on 21/10/2022.
//

import SwiftUI

enum StyleSheet: String, CaseIterable {
    case customize = "Customize"
    case github = "GitHub"
    case lopash = "Lopash"
    case solarizeddark = "Solarized Dark"
    case ulysses = "Ulysses"

    var shortcutKey: KeyEquivalent {
        switch self {
        case .customize:
            return "1"
        case .github:
            return "2"
        case .lopash:
            return "3"
        case .solarizeddark:
            return "4"
        case .ulysses:
            return "5"
        }
    }
}
