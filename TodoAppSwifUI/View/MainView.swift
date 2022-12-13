//
//  MainView.swift
//  TodoAppSwifUI
//
//  Created by Nguyễn Trường Thịnh on 06/12/2022.
//

import SwiftUI

struct MainView: View {
    // MARK: - COMPILER DIRECTIVE
    #if os(iOS)
    @Environment(\.horizontalSizeClass) var hsClass: UserInterfaceSizeClass?
    #endif

    // MARK: - SOME SORT OF VIEW
    @ViewBuilder
    var body: some View {
            #if os(iOS)
            if hsClass == .compact {
                TabBarView()  // iOS devices
            } else {
                NavigationView {
                    SideBarView()  // iPadOS devices
                }
                .accentColor(Color("AccentColor"))
            }
            #else
            NavigationView {
                SideBarView()  // macOS devices
            }
            .accentColor(Color("AccentColor"))
            #endif
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
