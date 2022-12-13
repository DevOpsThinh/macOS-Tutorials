//
//  FavoriteItemDetailView.swift
//  TodoAppSwifUI
//
//  Created by Nguyễn Trường Thịnh on 07/12/2022.
//

import SwiftUI
import URLImage

struct FavoriteItemDetailView: View {
    // MARK: - PROPERTY WRAPPER
    @Environment(\.dismiss) var dismiss

    // MARK: - STATE VARIABLES
    @State var login: String = ""
    @State var url: String = ""
    @State var avatar_url: String = ""
    @State var html_url: String = ""

    var id: String = ""
    var repository: FavoritesRepository
    
    // MARK: - SOME SORT OF VIEW
    var body: some View {
        VStack {
            URLImage(URL(string: avatar_url)!) { image in
                image.resizable().scaledToFit()
            }
            .padding(.top, 5)

            VStack {
                FormTextView(value: $login, label: "Username")
                FormTextView(value: $url, label: "API url")
                FormTextView(value: $html_url, label: "Website url")
            }
            .padding([.leading, .trailing, .bottom], 8)
        }
        .navigationBarTitle(NSLocalizedString("Update User", comment: "Update Favorite User"), displayMode: .inline)
        .navigationBarItems(trailing: Button {
            repository.updateUser(id: id, login: login, url: url, avatar_url: avatar_url, html_url: html_url)
            dismiss()
        } label: {
            Image(systemName: "checkmark")
                .font(.headline)
        }.disabled(login.isEmpty))
    }
}

struct FavoriteItemDetailView_Previews: PreviewProvider {
    static var repo = FavoritesRepository()
    static var previews: some View {
        FavoriteItemDetailView( repository: repo)
    }
}
