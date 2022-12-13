//
//  FavoritesRepository.swift
//  TodoAppSwifUI
//
//  Created by Nguyễn Trường Thịnh on 07/12/2022.
//

import Foundation
import Firebase

/// A `FavoritesRepository` final class type that conform to `ObservableObject` protocol
final class FavoritesRepository: ObservableObject {
    // MARK: - PROPERTIES
    @Published var users: [GithubUser] = []

    private let db = Firestore.firestore()

    // MARK: - INITIALIZERS
    init() {
        loadFavorites()
    }

    // MARK: - METHODS
    /// Fetch all the Github's users from github-users favorites collection
    private func loadFavorites() {
        db.collection("github-users").getDocuments { (snapshot, error) in
            if let error = error {
                fatalError("\(error.localizedDescription)")
            }

            guard let docs = snapshot?.documents else {
                return
            }

            self.users = docs.compactMap { doc in
                let data = doc.data()

                guard let userName = data["username"] as? String,
                      let url = data["url"] as? String,
                      let avatar_url = data["avatar_url"] as? String,
                      let html_url = data["html_url"] as? String else {
                          return nil
                      }
                return GithubUser(node_id: doc.documentID, login: userName, url: url, avatar_url: avatar_url, html_url: html_url)
            }
        }
    }
    /// Add a new Github's user into our github-users favorites collection
    func addToFavorites(login: String, url: String, avatar_url: String, html_url: String) {
        db.collection("github-users").addDocument(data: [
            "username": login,
            "url": url,
            "avatar_url": avatar_url,
            "html_url": html_url
        ])
        // Load all the users again to reflect the change
        loadFavorites()
    }
    /// Update an exist Github's user in github-users favorites collection
    func updateUser(id: String, login: String, url: String, avatar_url: String, html_url: String) {
        db.collection("github-users").document(id).updateData([
            "username": login,
            "url": url,
            "avatar_url": avatar_url,
            "html_url": html_url
        ]) { error in
            if error != nil {
                fatalError("\(error?.localizedDescription ?? "Unknown error")")
            } else {
                print("Successfully updated")
            }
        }
        // Load all the users again to reflect the change
        loadFavorites()
    }
    /// Delete a Github's users from github-users favorites collection
    func remove(at index: Int) {
        let userToDelete = users[index]
        db.collection("github-users").document(userToDelete.id).delete()
        // Load all the users again to reflect the change
        loadFavorites()
    }
}
