//
//  OnboardingView.swift
//  TodoAppSwifUI
//
//  Created by Nguyễn Trường Thịnh on 09/12/2022.
//

import SwiftUI

struct OnboardingView: View {
    // MARK: - STATE VARIABLES
    @State var currentPageIndex = 0

    private var items: [Onboarding] = []
    private var lblNext: String {
        items[currentPageIndex].nextButtonTitle
    }
    private var lblSkip: String {
        items[currentPageIndex].skipButtonTitle
    }

    // MARK: - COMPLETION HANDLER
    private var onNext: (_ currentIndex: Int) -> Void = { _ in }
    private var onSkip: () -> Void = {}

    // MARK: - INITIALIZERS
    public init(items: [Onboarding]) {
        self.items = items
    }

    // MARK: - SOME SORT OF VIEW
    public var body: some View {
        if items.isEmpty {
            Text(NSLocalizedString("No items to show", comment: "No items to show"))
        } else {
            VStack {
                TabView(selection: $currentPageIndex) {
                    ForEach(0..<items.count) { i in
                        PageView(onboarding: items[i]).tag(i)
                    }
                }
                .padding(.bottom, 10)
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                .onAppear(perform: setupPageControl)

                Button(action: next) {
                    Text(lblNext)
                        .font(.headline)
                        .frame(maxWidth: .infinity, maxHeight: 44)
                }
                .animation(nil, value: currentPageIndex)
                .buttonStyle(OnboardingButtonStyle(color: .beeAccentColor))

                Button(action: onSkip) {
                    Text(lblSkip)
                        .font(.headline)
                        .foregroundColor(Color(.darkGray))
                }
                .animation(nil, value: currentPageIndex)
                .padding(.bottom, 20)
            }
        }
    }
    // MARK: - METHODS
    public func onNext(
        action: @escaping (_ currentIndex: Int) -> Void
    ) -> Self {
        var appOnboardingView = self
        appOnboardingView.onNext = action
        return appOnboardingView
    }

    public func onSkip(
        action: @escaping () -> Void
    ) -> Self {
        var appOnboardingView = self
        appOnboardingView.onSkip = action
        return appOnboardingView
    }
    /// Set the selected page control indicator color
    private func setupPageControl() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(.beeNavigationBarTitle)
    }
    /// Changes the index of the current page view with animation
    private func next() {
        withAnimation {
            if currentPageIndex + 1 < items.count {
                currentPageIndex += 1
            } else {
                currentPageIndex = 0
            }
        }
        onNext(currentPageIndex)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(items: mockModel)
    }
}

private extension PreviewProvider {
    static var mockModel: [Onboarding] {
        [
            Onboarding(title: "WELCOME TO\nTODO", info: "Create your own To-do well done and make it into complete tasks", image: .work),
            Onboarding(title: "SEARCH...", info: "Search term in the url to get Github data for user with username matching our search term", image: .family,
                      nextButtonTitle: "Allow"),
            Onboarding(title: "ADD TO\nFAVORITES LIST", info: "Add your favorite users and update your own favorite GitHub users", image: .personal)
        ]
    }
}
