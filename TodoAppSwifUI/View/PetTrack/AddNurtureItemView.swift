//
//  AddNurtureItemBar.swift
//  TodoAppSwifUI
//
//  Created by Nguyễn Trường Thịnh on 12/12/2022.
//

import SwiftUI
import PetKit

struct AddNurtureItemView: View {
    let isPetSleeping: Bool
    let onKindTapped: (NurtureItem.Kind) -> Void

    // MARK: - SOME SORT OF VIEW
    var body: some View {
        let kinds: [NurtureItem.Kind] = [.strenuousness, .food, .sleep, .diaper, .moment]
        // Action button icons
        HStack(spacing: 16) {
            ForEach(kinds, id: \.self) { kind in
                let type = kind == .sleep && isPetSleeping ? .awake : kind

                Button(type.emoji) {
                    onKindTapped(type)
                }
                .frame(minWidth: 52, maxWidth: .infinity, minHeight: 52, idealHeight: 52)
                .background(Color(kind.color))
                .cornerRadius(4)
            }
        }
        .padding([.leading, .trailing])
    }
}
