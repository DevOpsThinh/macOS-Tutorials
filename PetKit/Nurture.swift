//
//  Nurture.swift
//  TodoAppSwifUI
//
//  Created by Nguyễn Trường Thịnh on 12/12/2022.
//

import Foundation
import Combine
import SwiftUI

@dynamicMemberLookup
public class Nurture: ObservableObject {
    // MARK: - PROPERTY WRAPPER
    @Published public var items: [NurtureItem] = []

    private let legacyNurture = __Nurture()  // our Objective-C nurture

    // MARK: - INITIALIZER
    public init() {
        items = legacyNurture.loadItems()
    }

    // MARK: - METHODS
    /// Lets we perform a dynamic lookup to any Key Path between `__Nurture`
    /// & a generic T, meaning any property of `__Nurture`
    public subscript<T>(
        dynamicMember keyPath: KeyPath<__Nurture, T>
    ) -> T {
        legacyNurture[keyPath: keyPath]
    }

    public func addItem(of kind: NurtureItem.Kind) {
        items.insert(legacyNurture.addItem(of: kind), at: 0)
    }

    public func addMoment(with attachmentId: UUID) {
        items.insert(legacyNurture.add(NurtureItem(
            kind: .moment,
            date: nil,
            attachmentId: attachmentId)), at: 0)
    }
    public func storeImage(_ image: UIImage) -> UUID? {
        legacyNurture.storeImage(image)  // Stand out as non-Swifty
    }
}

