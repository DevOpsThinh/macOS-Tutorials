//
//  FavoritesListView.swift
//  TodoAppSwifUI
//
//  Created by Nguyễn Trường Thịnh on 07/12/2022.
//

import SwiftUI
import URLImage

struct FavoritesListView: View {
    // MARK: - PROPERTY WRAPPER
    @ObservedObject var favoritesRepo: FavoritesRepository = FavoritesRepository()

    // MARK: - STATE VARIABLES
    @State private var searchText = ""

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
            List {
                // If there is no data, show an empty view
                if favoritesRepo.users.count == 0 {
                    NoDataView()
                } else {
                    ForEach (favoritesRepo.users.filter({
                        searchText.isEmpty ? true : $0.login.contains(searchText)
                    })) { user in
                        NavigationLink(destination: FavoriteItemDetailView(
                            login: user.login,
                            url: user.url,
                            avatar_url: user.avatar_url,
                            html_url: user.html_url,
                            id: user.id,
                            repository: favoritesRepo
                        )) {
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
                    }
                    .onDelete(perform: deleteUser)
                }
            }
        }
        .padding([.top, .bottom], 8)
        .navigationTitle(NSLocalizedString("Pro Users", comment: "Github users favorites"))
        .navigationBarTitleDisplayMode(.automatic)
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: NSLocalizedString("Search pro users...", comment: "Search pro users...")
        ) {
                Text("DevOpsThinh").searchCompletion("DevOpsThinh")
        }
    }
    // MARK: - METHODS
    /// Delete an exist favorite user
    private func deleteUser(offset: IndexSet) {
        for i in offset {
            if i == offset.first {
                favoritesRepo.remove(at: i)
            }
        }
    }
}

struct FavoritesListView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesListView()
    }
}
