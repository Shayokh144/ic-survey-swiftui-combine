//
//  LoginRepositorySpec.swift
//  SurveyUnitTests
//
//  Created by Taher on 14/11/22.
//
//  swiftlint:disable closure_body_length

import Combine
import Nimble
import Quick

@testable import Survey

final class LoginRepositorySpec: QuickSpec {

    override func spec() {

        var loginRepository: LoginRepository!
        var loginNetwork: MockLoginNetworkAPI!
        var isResponseReceived = false
        var cancellables = CancelBag()

        describe("a LoginRepository") {

            beforeEach {
                loginNetwork = MockLoginNetworkAPI()
                loginRepository = LoginRepository(network: loginNetwork)
                isResponseReceived = false
                executeRequest()
            }

            context("a call to getLoginToken") {

                it("should receive  response") {
                    expect(isResponseReceived)
                        .toEventually(
                            equal(true),
                            timeout: .seconds(2)
                        )
                }
            }

            func executeRequest() {
                loginRepository.getLoginToken(email: "", password: "")
                    .sink(
                        receiveCompletion: { completion in
                            switch completion {
                            case let .failure(error):
                                isResponseReceived = true
                                NSLog("ERROR: \(error.localizedDescription)")
                            case .finished:
                                NSLog("Login token response finished")
                            }
                        },
                        receiveValue: { _ in
                            isResponseReceived = true
                        }
                    )
                    .store(in: &cancellables)
            }
        }
    }
}
