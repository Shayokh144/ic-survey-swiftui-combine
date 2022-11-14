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
    @State private var shouldShowLoginFailedAlert = true
    @State var editingMode: Bool = false

    @ObservedObject private var viewModel: LoginViewModel

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
                    .offset(y: editingMode ? -340.0 : logoOffset)
                VStack(alignment: .center, spacing: 20.0) {

                    EmailTextField(email: $viewModel.email, editingMode: $editingMode)
                    PasswordSecureTextField(password: $viewModel.password, editingMode: $editingMode)
                    Button(
                        action: {
                            viewModel.login()
                        },
                        label: {
                            LoginButton()
                        }
                    )
                    .accessibilityIdentifier("loginButtonIdentifier")
                }
                .offset(y: editingMode ? -140.0 : -60.0)
                .opacity(loginViewOpacity)
                .disabled(viewModel.isLoading)

                if viewModel.isLoginAttemptFailed {
                    ZStack {
                        BlurView()
                    }
                    .alert(isPresented: $shouldShowLoginFailedAlert) { () -> Alert in
                        Alert(
                            title: Text(Localize.login_failed_title()),
                            message: Text(viewModel.errorMessage),
                            dismissButton: .default(Text("OK")) {
                                shouldShowLoginFailedAlert = true
                                viewModel.didDismissLoginFailedAlert()
                            }
                        )
                    }
                }

                if viewModel.isLoading {
                    ZStack {
                        BlurView()
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(2.0)
                    }
                }
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

    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
}
