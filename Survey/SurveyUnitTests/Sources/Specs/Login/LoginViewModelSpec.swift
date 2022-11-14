//
//  LoginViewModelSpec.swift
//  SurveyUnitTests
//
//  Created by Taher on 10/11/22.
//
//  swiftlint:disable function_body_length closure_body_length

import Combine
import Nimble
import Quick

@testable import Survey

final class LoginViewModelSpec: QuickSpec {

    override func spec() {

        var viewModel: LoginViewModel!
        var loginUseCase: MockLoginUseCase!
        var coordinator: MockAppCoordinator!

        describe("a LoginViewModel") {

            beforeEach {
                coordinator = MockAppCoordinator()
                loginUseCase = MockLoginUseCase()
            }

            context("when a valid credentials are provided") {

                beforeEach {
                    viewModel = LoginViewModel(
                        loginUseCase: loginUseCase,
                        coordinator: coordinator
                    )
                    viewModel.email = "abc@nimblehq.co"
                    viewModel.password = "12345"
                    viewModel.login()
                }

                it("should not show any error") {
                    expect(viewModel.errorMessage.isEmpty)
                        .toEventually(
                            equal(true),
                            timeout: .seconds(2)
                        )
                }

                it("should set false to login failed") {
                    expect(viewModel.isLoginAttemptFailed)
                        .toEventually(
                            equal(false),
                            timeout: .seconds(2)
                        )
                }

                it("should load survey view") {
                    expect(coordinator.isSurveyViewLoaded)
                        .toEventually(
                            equal(true),
                            timeout: .seconds(2)
                        )
                }
            }

            context("when an wrong credentials are provided") {

                beforeEach {
                    viewModel = LoginViewModel(
                        loginUseCase: loginUseCase,
                        coordinator: coordinator
                    )
                    viewModel.email = "abc@gmail.co"
                    viewModel.password = "12345"
                    viewModel.login()
                }

                it("should show error for wrong credentials") {
                    expect(viewModel.errorMessage)
                        .toEventually(
                            equal("Your email or password is incorrect. Please try again."),
                            timeout: .seconds(2)
                        )
                }

                it("should set true to login failed") {
                    expect(viewModel.isLoginAttemptFailed)
                        .toEventually(
                            equal(true),
                            timeout: .seconds(2)
                        )
                }

                it("should not load survey view") {
                    expect(coordinator.isSurveyViewLoaded)
                        .toEventually(
                            equal(false),
                            timeout: .seconds(2)
                        )
                }
            }

            context("when email format is invalid") {

                beforeEach {
                    viewModel = LoginViewModel(
                        loginUseCase: loginUseCase,
                        coordinator: coordinator
                    )
                    viewModel.email = "abc"
                    viewModel.password = "12345"
                    viewModel.login()
                }

                it("should show invalid email error") {
                    expect(viewModel.errorMessage)
                        .toEventually(
                            equal("Your email is invalid. Please try with new one."),
                            timeout: .seconds(2)
                        )
                }

                it("should set true to login failed") {
                    expect(viewModel.isLoginAttemptFailed)
                        .toEventually(
                            equal(true),
                            timeout: .seconds(2)
                        )
                }

                it("should not load survey view") {
                    expect(coordinator.isSurveyViewLoaded)
                        .toEventually(
                            equal(false),
                            timeout: .seconds(2)
                        )
                }
            }

            context("when password format is invalid") {

                beforeEach {
                    viewModel = LoginViewModel(
                        loginUseCase: loginUseCase,
                        coordinator: coordinator
                    )
                    viewModel.email = "abc@gmail.com"
                    viewModel.password = ""
                    viewModel.login()
                }

                it("should show invalid password error") {
                    expect(viewModel.errorMessage)
                        .toEventually(
                            equal("Your password format is invalid. Please try with new one."),
                            timeout: .seconds(2)
                        )
                }

                it("should set true to login failed") {
                    expect(viewModel.isLoginAttemptFailed)
                        .toEventually(
                            equal(true),
                            timeout: .seconds(2)
                        )
                }

                it("should not load survey view") {
                    expect(coordinator.isSurveyViewLoaded)
                        .toEventually(
                            equal(false),
                            timeout: .seconds(2)
                        )
                }
            }
        }
    }
}
