//
//  Onboarding.swift
//  TodoAppSwifUI
//
//  Created by Nguyễn Trường Thịnh on 09/12/2022.
//

import SwiftUI

public struct Onboarding: Identifiable {
    // MARK: - PROPERTIES
    public let id = UUID()
    // These properties to hold the data that appears on each page of the onboarding screen.
    let title: String
    let info: String
    let image: Image
    // These properties to hold the titles the Next, Skip button that appears on each page of th onboarding screen.
    let nextButtonTitle: String
    let skipButtonTitle: String

    // MARK: - INITIALIZERS
    public init(
        title: String,
        info: String,
        image: Image,
        nextButtonTitle: String = NSLocalizedString("Next", comment: "Next button label"),
        skipButtonTitle: String = NSLocalizedString("Skip", comment: "Skip button label")
    ) {
        self.title = title
        self.info = info
        self.image = image
        self.nextButtonTitle = nextButtonTitle
        self.skipButtonTitle = skipButtonTitle
    }
}
