//
//  GithubUsersListView.swift
//  TodoAppSwifUI
//
//  Created by Nguyễn Trường Thịnh on 06/12/2022.
//

import SwiftUI
import URLImage

struct GithubUsersListView: View {
    // MARK: - PROPERTY WRAPPER
    @ObservedObject private var userRepo: GithubUserRepository

    // MARK: - STATE VARIABLES
    @State private var searchText = "DevOpsThinh"

    // MARK: - INITIALIZERS
        init() {
            let repository = GithubUserRepository()
            userRepo = repository
        }

    // MARK: - COMPILER DIRECTIVE
    #if os(iOS)
    @Environment(\.horizontalSizeClass) var hsClass: UserInterfaceSizeClass?
    #endif

    // MARK: - SOME SORT OF VIEW
    var body: some View {
        #if os(iOS)
        if hsClass == .compact {
            NavigationView {
                view
            }
            .accentColor(Color("AccentColor"))
        } else {
            view
        }
        #else
        view
            .frame(minWidth: 400, minHeight: 600)
        #endif
    }

    @ViewBuilder
    private var view: some View {
        VStack {
            // The search bar view
            SearchBar(text: $searchText)
                .padding(.top, -8)
            // If there is no data, show a loader indicator view
            if userRepo.items.count == 0 {
                ProgressView().onAppear() {
                    userRepo.getUser(searchTerm: searchText)
                }
            } else {
                // The Users Filtered List
                FilteredList($searchText)
            }

            Spacer()
            // Notes - hint
            Text(NSLocalizedString("When an item is long-tapped will be added to the favorites", comment: "When an item is long-tapped will be added to the favorites"))
                .font(.system(.footnote, design: .rounded))
                .foregroundColor(Color(.darkGray))
                .lineLimit(3)
                .padding(.bottom, 10)
        }
        .navigationTitle(NSLocalizedString("Github Users", comment: "Github Users Label"))
        .navigationBarTitleDisplayMode(.automatic)
    }
}

struct FilteredList: View {
    @ObservedObject private var repo = GithubUserRepository()
    @ObservedObject private var favoritesRepo = FavoritesRepository()

    @Binding var searchText: String

    init(_ searchText: Binding<String>) {
        self._searchText = searchText
        repo.getUser(searchTerm: self.searchText)
    }

    var body: some View {

        ZStack {
            // The Github users list
            List(repo.items, id: \.login) { user in
                Link(destination: URL(string: user.html_url)!) {
                    HStack (alignment: .top) {
                        URLImage(URL(string: user.avatar_url)!) { image in
                            image.resizable().frame(width: 60, height: 60)
                        }

                        VStack(alignment: .leading) {
                            Text(user.login)
                                .font(.custom("Nunito-Bold", size: 24, relativeTo: .headline))
                            Text("\(user.url)")
                                .font(.system(size: 13))
                                .foregroundColor(Color(.darkGray))
                        }
                    }
                }
                // When an item is long tapped: add it to firebase firestore
                .onLongPressGesture(perform: {
                    favoritesRepo.addToFavorites(login: user.login, url: user.url, avatar_url: user.avatar_url, html_url: user.html_url)
                })
            }

            if repo.items.count == 0 {
                NoDataView()
            }
        }
    }
}

struct GithubUsersListView_Previews: PreviewProvider {
    static var previews: some View {
        GithubUsersListView()
    }
}
