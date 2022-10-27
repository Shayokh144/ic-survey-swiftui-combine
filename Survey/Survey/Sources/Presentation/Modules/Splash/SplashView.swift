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
            Image(Images.splashBackground)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.top)
            Image(Images.overlay)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.top)
            Image(Images.logoWhite)
                .resizable()
                .frame(width: 202.0, height: 48.0, alignment: .center)
                .opacity(logoOpacity)
        }.onAppear {
            withAnimation(.easeInOut(duration: 2.0)) {
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
