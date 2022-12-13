//
//  Color+Extension.swift
//  TodoAppSwifUI
//
//  Created by Nguyễn Trường Thịnh on 09/12/2022.
//

import SwiftUI
/// The default theme color for styling the navigation bar title, page controls, buttons, ...
extension Color {
    static var beeAccentColor: Color {
        Color("AccentColor", bundle: .module)
    }

    static var beeNavigationBarTitle: Color {
        Color("NavigationBarTitle", bundle: .module)
    }
}
