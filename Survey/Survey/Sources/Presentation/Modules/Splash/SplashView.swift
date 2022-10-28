//
//  SplashView.swift
//  Survey
//
//  Created by Taher on 25/10/22.
//

import SwiftUI

struct SplashView: View {

    @State private var logoOpacity = 0.0

    var body: some View {
        ZStack {
            ImageAssets.splashBackground.imageView
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.top)
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

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
