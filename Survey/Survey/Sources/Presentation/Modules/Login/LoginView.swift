//  swiftlint:disable closure_body_length
//
//  LoginView.swift
//  Survey
//
//  Created by Taher on 2/11/22.
//

import SwiftUI

struct LoginView: View {

    @State private var logoOffset = 0.0
    @State private var logoScaleEffect = 1.0
    @State private var loginViewOpacity = 0.0
    @State private var isLoginFailed = false
    @State var editingMode: Bool = false
    @State var email: String = ""
    @State var password: String = ""

    var body: some View {

        GeometryReader { _ in

            ZStack {

                ImageAssets.loginBackground.imageView
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                OverlayView.loginScreen.linearGradient
                ImageAssets.logoWhite.imageView
                    .resizable()
                    .frame(width: 202.0, height: 48.0, alignment: .center)
                    .scaleEffect(logoScaleEffect)
                    .offset(y: editingMode ? -340 : logoOffset)
                VStack(alignment: .center, spacing: 20.0) {

                    EmailTextField(email: $email, editingMode: $editingMode)
                    PasswordSecureTextField(password: $password, editingMode: $editingMode)
                    Button(
                        action: {
                            // TODO: send action to viewmodel
                            isLoginFailed = true
                        },
                        label: {
                            LoginButton()
                        }
                    )
                    .accessibilityIdentifier("loginButtonIdentifier")
                }
                .alert(isPresented: $isLoginFailed) { () -> Alert in
                    Alert(
                        title: Text(Localize.login_failed_title()),
                        message: Text(Localize.login_failed_description())
                    )
                }
                .offset(y: editingMode ? -140 : -60)
                .opacity(loginViewOpacity)
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 1.0)) {
                    loginViewOpacity = 1.0
                    logoOffset = -300.0
                    logoScaleEffect = 0.85
                }
            }
        }.ignoresSafeArea(.keyboard, edges: .bottom)
    }
}
