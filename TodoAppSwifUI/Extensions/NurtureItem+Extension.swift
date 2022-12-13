//
//  NurtureItem+Extension.swift
//  TodoAppSwifUI
//
//  Created by Nguyễn Trường Thịnh on 12/12/2022.
//

import UIKit
import PetKit

@objc extension NurtureItem {
    var attachmentURL: URL? {
        attachmentId.flatMap {
            try? FileManager.default.url(
                for: .documentDirectory,
                   in: .userDomainMask,
                   appropriateFor: nil,
                   create: false)
                .appendingPathComponent("\($0).jpg")
            }
    }

    // MARK: - STATIC METHODS
    /// get the color for a specified kind
    @objc(colorForKind:)
    static func color(for kind: Kind) -> UIColor {
        kind.color
    }
    /// get the emoji for a specified kind
    @objc(emojiForKind:)
    static func emoji(for kind: Kind) -> String {
        kind.emoji
    }
    /// get the title for a specified kind
    @objc(titleForKind:)
    static func title(for kind: Kind) -> String {
        kind.title
    }
}

extension NurtureItem.Kind {
    var title: String {
        switch self {
        case .strenuousness:
            return NSLocalizedString("Strenuousness: Run & Jump", comment: "Strenuousness: Run & Jump")
        case .food:
            return NSLocalizedString("Ate food", comment: "Ate food")
        case .sleep:
            return NSLocalizedString("Slept", comment: "Slept")
        case .awake:
            return NSLocalizedString("Woke up", comment: "Woke up")
        case .diaper:
            return NSLocalizedString("Got a new diaper", comment: "Got a new diaper")
        case .moment:
            return NSLocalizedString("Captured a moment", comment: "Captured a moment")
        default:
            return ""
        }
    }

    var emoji: String {
        switch self {
        case .strenuousness:
            return "🦮"
        case .food:
            return "🍖"
        case .sleep:
            return "😴"
        case .awake:
            return "👶"
        case .diaper:
            return "💩"
        case .moment:
            return "📸"
        default:
            return ""
        }
    }

    var color: UIColor {
        switch self {
        case .strenuousness:
            return UIColor(r: 240, g: 90, b: 20)
        case .food:
            return UIColor(r: 173, g: 255, b: 47)
        case .sleep, .awake:
            return UIColor(r: 255, g: 191, b: 0)
        case .diaper:
            return UIColor(r: 244, g: 164, b: 96)
        case .moment:
            return UIColor(r: 83, g: 83, b: 83)
        default:
            return .white
        }
    }
}

private extension UIColor {
    convenience init(
        r: Int,
        g: Int,
        b: Int,
        a: CGFloat = 1.0) {
            self.init(
                red: CGFloat(r) / 255,
                green: CGFloat(g) / 255,
                blue: CGFloat(b) / 255,
                alpha: a)
        }
}
