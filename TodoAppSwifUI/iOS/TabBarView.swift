//
//  TabBarView.swift
//  TodoAppSwifUI
//
//  Created by Nguyễn Trường Thịnh on 13/12/2022.
//

import SwiftUI
import TutorialAbout

struct TabBarView: View {
    // MARK: - STATE VARIABLES
    @State private var selectedTabIndex = 0

    private var aboutItems: [AboutModel] {
        [
            AboutModel(category: .improvement, title: "Rate us on GitHub Stars", iconName: "star", url: .rateUs),
            AboutModel(category: .improvement, title: "Tell us your feedback", iconName: "chat", url: .feedback),
            AboutModel(category: .improvement, title: "Discover us on GitHub Profile", iconName: "github", url: .github),
            AboutModel(category: .social, title: "Twitter", iconName: "twitter", url: .twitter),
            AboutModel(category: .social, title: "Facebook", iconName: "facebook", url: .facebook),
            AboutModel(category: .social, title: "Instagram", iconName: "instagram", url: .instagram)
        ]
    }
    // MARK SOME SORT OF VIEW
    var body: some View {
        TabView(selection: $selectedTabIndex) {
            // The To-do list tab
            TodoListView()
                .tabItem {
                    Label(
                        NSLocalizedString("Todo Lists", comment: "Todo Lists tab label"),
                        systemImage: "checklist")
                }.tag(0)
            // The Pet track tab
            NurtureListView()
                .tabItem {
                    Label(
                        NSLocalizedString("Pet Track", comment: "Pet Track tab label"),
                        systemImage: "pawprint.fill")
                }.tag(1)
            // The Github's Users discover list tab
            GithubUsersListView()
                .tabItem {
                    Label(
                        NSLocalizedString("Discover", comment: "Discover tab label"),
                        systemImage: "person.icloud")
                }.tag(2)
            // The Favorites list tab
            FavoritesListView()
                .tabItem {
                    Label(
                        NSLocalizedString("Favorites", comment: "Favorites tab label"),
                        systemImage: "star.square.fill")
                }.tag(3)
            // The About - Info tab
            AboutView(react_items: aboutItems)
                .tabItem {
                    Label(
                        NSLocalizedString("About", comment: "About tab label"),
                        systemImage: "wand.and.rays")
                }.tag(4)
        }
        .accentColor(Color("NavigationBarTitle"))
    }
}
