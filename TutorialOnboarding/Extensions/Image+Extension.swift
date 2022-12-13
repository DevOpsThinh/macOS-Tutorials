//
//  Image+Extension.swift
//  TodoAppSwifUI
//
//  Created by Nguyễn Trường Thịnh on 09/12/2022.
//

import SwiftUI
/// An Image extension that refers to all the image assets from the module's assets we added.
public extension Image {
    static var family: Image {
        Image("family", bundle: .module)
    }

    static var personal: Image {
        Image("personal", bundle: .module)
    }

    static var work: Image {
        Image("work", bundle: .module)
    }
}
