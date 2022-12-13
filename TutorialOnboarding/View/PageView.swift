//
//  PageView.swift
//  TodoAppSwifUI
//
//  Created by Nguyễn Trường Thịnh on 09/12/2022.
//

import SwiftUI

struct PageView: View {
    let onboarding: Onboarding

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12, style: .circular)
                .fill(.white)
                .shadow(radius: 12)
                .padding(.horizontal, 20)
            VStack(alignment: .center) {
                VStack {
                    Text(onboarding.title)
                        .foregroundColor(.beeAccentColor)
                        .font(.custom(
                            "Nunito-Bold",
                            size: 35,
                            relativeTo: .largeTitle)
                        )
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                    Text(onboarding.info)
                        .font(.body)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding([.top, .bottom], 10)
                        .padding(.horizontal, 10)
                    onboarding.image
                        .resizable()
                        .frame(width: 140, height: 140, alignment: .center)
                        .foregroundColor(.beeAccentColor)
                        .aspectRatio(contentMode: .fit)
                }
                .padding()
            }
        }
    }
}

struct PageView_Previews: PreviewProvider {
    static let onboarding = Onboarding(title: "WELCOME TO\nTODO", info: "Create your own To-do well done and make it into complete tasks", image: .work)
    static var previews: some View {
        PageView(onboarding: onboarding)
    }
}
