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
        let baseUrl = URL(string: "https://survey-api.nimblehq.co/api/v1/oauth/token")
        let encoder = JSONEncoder()

        describe("a LoginViewModel") {

            context("when a valid response is provided") {

                beforeEach {
                    guard let url = baseUrl else {
                        return
                    }
                    let tokenData = LoginTokenApi.createDummy()
                    var mockLoginData = Data()
                    do {
                        mockLoginData = try encoder.encode(tokenData)
                    } catch {
                        NSLog(error.localizedDescription)
                    }
                    let session = MockSession.make(
                        url: url,
                        data: mockLoginData,
                        statusCode: 200
                    )

                    let network = LoginNetworkAPI(decoder: JSONDecoder(), session: session)
                    let loginRepo = LoginRepository(network: network)
                    let useCase = LoginUseCase(loginRepository: loginRepo)

                    viewModel = LoginViewModel(loginUseCase: useCase, coordinator: AppViewModel())
                    viewModel.email = "abc@gmail.com"
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
            }

            context("when an invalid response is provided") {

                beforeEach {
                    guard let url = baseUrl else {
                        return
                    }
                    let session = MockSession.make(
                        url: url,
                        data: Data("invalid data".utf8),
                        statusCode: 401
                    )

                    let network = LoginNetworkAPI(decoder: JSONDecoder(), session: session)
                    let loginRepo = LoginRepository(network: network)
                    let useCase = LoginUseCase(loginRepository: loginRepo)

                    viewModel = LoginViewModel(loginUseCase: useCase, coordinator: AppViewModel())
                    viewModel.email = "abc@gmail.com"
                    viewModel.password = "12345"
                    viewModel.login()
                }

                it("should not show any error") {
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
            }

            context("when email format is invalid") {

                beforeEach {
                    guard let url = baseUrl else {
                        return
                    }
                    let session = MockSession.make(url: url, data: Data(), statusCode: 401)
                    let network = LoginNetworkAPI(decoder: JSONDecoder(), session: session)
                    let loginRepo = LoginRepository(network: network)
                    let useCase = LoginUseCase(loginRepository: loginRepo)

                    viewModel = LoginViewModel(loginUseCase: useCase, coordinator: AppViewModel())
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
            }

            context("when password format is invalid") {

                beforeEach {
                    guard let url = baseUrl else {
                        return
                    }
                    let session = MockSession.make(url: url, data: Data(), statusCode: 401)
                    let network = LoginNetworkAPI(decoder: JSONDecoder(), session: session)
                    let loginRepo = LoginRepository(network: network)
                    let useCase = LoginUseCase(loginRepository: loginRepo)

                    viewModel = LoginViewModel(loginUseCase: useCase, coordinator: AppViewModel())
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
            }
        }
    }
}
