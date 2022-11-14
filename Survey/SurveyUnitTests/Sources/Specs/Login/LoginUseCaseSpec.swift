//
//  LoginUseCaseSpec.swift
//  SurveyUnitTests
//
//  Created by Taher on 14/11/22.
//

import Combine
import Nimble
import Quick

@testable import Survey

final class LoginUseCaseSpec: QuickSpec {

    override func spec() {

        var loginUseCase: LoginUseCase!
        var loginRepo: MockLoginRepository!

        describe("a LoginUseCase") {

            beforeEach {
                loginRepo = MockLoginRepository()
                loginUseCase = LoginUseCase(loginRepository: loginRepo)
            }

            context("when valid credentials are provided") {

                beforeEach {
                    _ = loginUseCase.executeLogin(email: "abc@nimblehq.co", password: "12345")
                }

                it("should set true to login success") {
                    expect(loginRepo.isLoginSuccess)
                        .toEventually(
                            equal(true),
                            timeout: .seconds(2)
                        )
                }
            }

            context("when wrong credentials are provided") {

                beforeEach {
                    _ = loginUseCase.executeLogin(email: "abc@gmail.co", password: "12345")
                }

                it("should set false to login success") {
                    expect(loginRepo.isLoginSuccess)
                        .toEventually(
                            equal(false),
                            timeout: .seconds(2)
                        )
                }
            }
        }
    }
}
