//
//  SideBarView.swift
//  TodoAppSwifUI
//
//  Created by Nguyễn Trường Thịnh on 13/12/2022.
//

import SwiftUI
import TutorialAbout

struct SideBarView: View {
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

    // MARK: - SOME SORT OF VIEW
    var body: some View {
        List() {
            NavigationLink(
                destination: TodoListView(),
                label: {
                    Label(
                        NSLocalizedString("Todo Lists", comment: "Todo Lists tab label"),
                        systemImage: "checklist")
                }
            )
            NavigationLink(
                destination:  NurtureListView(),
                label: {
                    Label(
                        NSLocalizedString("Pet Track", comment: "Pet Track tab label"),
                       systemImage: "pawprint.fill")
                }
            )
            NavigationLink(
                 destination: GithubUsersListView(),
                 label: {
                     Label(
                        NSLocalizedString("Discover", comment: "Discover tab label"),
                        systemImage: "person.icloud")
                 }
             )
            NavigationLink(
                destination: FavoritesListView(),
                label: {
                    Label(
                        NSLocalizedString("Favorites", comment: "Favorites tab label"),
                        systemImage: "star.square.fill")
                }
            )
            NavigationLink(
                destination: AboutView(react_items: aboutItems),
                label: {
                    Label(
                        NSLocalizedString("About", comment: "About tab label"),
                        systemImage: "wand.and.rays")
                }
            )
        }
         .navigationTitle(NSLocalizedString("To-do", comment: "To-do"))
         .listStyle(SidebarListStyle())  // available on iOS 14 - Big Sur
    }
}

struct SideBarView_Previews: PreviewProvider {
    static var previews: some View {
        SideBarView()
    }
}
