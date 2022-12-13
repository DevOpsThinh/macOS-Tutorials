//
//  OnboardingButtonStyle.swift
//  TutorialOnboarding
//
//  Created by Nguyễn Trường Thịnh on 09/12/2022.
//

import SwiftUI

struct OnboardingButtonStyle: ButtonStyle {
    let color: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(color)
            .clipShape(Capsule())
            .buttonStyle(.plain)
            .padding(.horizontal, 20)
            .foregroundColor(.white)
    }
}

