//
//  ImageButton.swift
//  TodoAppSwifUI
//
//  Created by Nguyễn Trường Thịnh on 12/12/2022.
//

import SwiftUI

struct ImageButton: View {
    @ObservedObject private var loader: ImageLoader
    init(url: URL) {
        self.loader = ImageLoader(url)
    }

    var body: some View {
        if let image = loader.image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
        } else {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
            }
      }
}

private class ImageLoader: ObservableObject {
    private let url: URL
    private let loadingQueue = DispatchQueue(
        label: "images",
        qos: .background,
        attributes: .concurrent)

    @Published var image: UIImage?

  init(_ url: URL) {
      self.url = url
      URLSession.shared
          .dataTaskPublisher(for: url)
          .map(\.data)
          .map { UIImage(data: $0) }
          .subscribe(on: loadingQueue)
          .receive(on: DispatchQueue.main)
          .replaceError(with: nil)
          .assign(to: &$image)
    }
}
