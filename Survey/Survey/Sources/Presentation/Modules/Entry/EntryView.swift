//
//  EntryView.swift
//  Survey
//
//  Created by Taher on 25/10/22.
//

import SwiftUI

struct EntryView: View {

    @ObservedObject var viewModel: EntryViewModel
    @State var logoOpacity = 0.0

    var body: some View {
        switch viewModel.viewType {
        case .splash:
            SplashView(logoOpacity: $logoOpacity)
                .onAnimationCompleted(for: logoOpacity) {
                    viewModel.didFinishSplashAnimation = true
                }
        case .login:
            LoginView()
        }
    }
}
