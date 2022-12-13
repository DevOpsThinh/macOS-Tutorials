//
//  GithubUserRepository.swift
//  TodoAppSwifUI
//
//  Created by Nguyễn Trường Thịnh on 07/12/2022.
//

import Foundation

/// A `GithubUserRepository` final class type that conform to `ObservableObject` protocol
final class GithubUserRepository: ObservableObject {
    @Published var items = [GithubUser]()

    /// Get the user data from the Github RESTful API
    func getUser(searchTerm: String) {
        var url = URL(string: APIConstants.github_url + searchTerm)!

        if (searchTerm == "") {
            url = URL(string: "https://api.github.com/search/users?q=DevOpsThinh")!
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                guard let httpResponse = response as? HTTPURLResponse,
                        httpResponse.statusCode == 200 else {
                    throw NetworkError.invalidServerResponse
                }

                if let data = data {
                    let decodedData = try JSONDecoder().decode(Result.self, from: data)

                    DispatchQueue.main.async {
                        self.items = decodedData.items
                    }
                } else {
                    throw NetworkError.invalidURL
                }
            } catch {
                fatalError("\(error.localizedDescription )")
            }
        }.resume()
    }
}
