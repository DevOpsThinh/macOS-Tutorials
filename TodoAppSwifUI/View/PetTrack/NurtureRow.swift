//
//  NurtureRow.swift
//  TodoAppSwifUI
//
//  Created by Nguyễn Trường Thịnh on 12/12/2022.
//

import SwiftUI
import PetKit

struct NurtureRow: View {
    private let nurtureItem: NurtureItem
    private let formatter = RelativeDateTimeFormatter()

    init(nurtureItem: NurtureItem) {
        self.nurtureItem = nurtureItem
        formatter.formattingContext = .standalone
    }

    // MARK: - SOME SORT OF VIEW
    var body: some View {
        HStack(alignment: .top) {
            Text(nurtureItem.kind.emoji)
                .frame(width: 44, height: 44, alignment: .center)
                .background(Color(nurtureItem.kind.color))
                .cornerRadius(22)

            VStack(alignment: .leading) {
                Text(nurtureItem.kind.title)
                    .font(.headline)

                Text(nurtureItem.date, formatter: formatter)
                    .font(.subheadline)
                    .foregroundColor(.gray)

                if let attachmentURL = nurtureItem.attachmentURL {
                    Spacer(minLength: 4)

                    ImageButton(url: attachmentURL)
                        .frame(minWidth: 0, minHeight: 140, idealHeight: 140)
                        .clipped()
                }
            }

            Spacer()
        }
        .frame(minHeight: 64)
    }
}
