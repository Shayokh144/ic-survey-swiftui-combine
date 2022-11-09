//
//  SplashView.swift
//  Survey
//
//  Created by Taher on 3/11/22.
//

import SwiftUI

struct SplashView: View {

    @Binding var logoOpacity: Double

    var body: some View {
        ZStack {
            ImageAssets.splashBackground.imageView
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            OverlayView.splashScreen.linearGradient
            ImageAssets.logoWhite.imageView
                .resizable()
                .frame(width: 202.0, height: 48.0, alignment: .center)
                .opacity(logoOpacity)
        }.onAppear {
            withAnimation(.easeInOut(duration: 1.0).delay(1.0)) {
                logoOpacity = 1.0
            }
        }
    }
}
