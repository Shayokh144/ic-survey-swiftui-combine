//
//  LoginNetworkAPISpec.swift
//  SurveyUnitTests
//
//  Created by Taher on 14/11/22.
//
//  swiftlint:disable function_body_length closure_body_length

import Combine
import Nimble
import Quick

@testable import Survey

final class LoginNetworkAPISpec: QuickSpec {

    override func spec() {

        var loginNetwork: LoginNetworkAPI!
        var loginTokenData: LoginTokenApi?
        var cancellables = CancelBag()
        let baseUrl = URL(string: "https://survey-api.nimblehq.co/api/v1/oauth/token")

        describe("a LoginNetworkAPI") {

            beforeEach {
                loginTokenData = nil
            }

            context("when a valid response is provided") {

                beforeEach {
                    guard let url = baseUrl else {
                        return
                    }
                    let tokenData = LoginTokenApi.createDummy()
                    var mockLoginData = Data()
                    let encoder = JSONEncoder()
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
                    loginNetwork = LoginNetworkAPI(decoder: JSONDecoder(), session: session)
                    executeRequest()
                }

                it("should get login token data") {
                    expect(loginTokenData)
                        .toEventuallyNot(
                            beNil(),
                            timeout: .seconds(2)
                        )
                }
            }

            context("when a invalid response is provided") {

                beforeEach {
                    guard let url = baseUrl else {
                        return
                    }
                    let session = MockSession.make(
                        url: url,
                        data: Data("invalid data".utf8),
                        statusCode: 401
                    )
                    loginNetwork = LoginNetworkAPI(decoder: JSONDecoder(), session: session)
                    executeRequest()
                }

                it("should not get login token data") {
                    expect(loginTokenData)
                        .toEventually(
                            beNil(),
                            timeout: .seconds(2)
                        )
                }
            }

            func executeRequest() {
                loginNetwork.performRequest(
                    APIRequestConfigurations.login(email: "", password: ""),
                    for: LoginTokenApi.self
                )
                .sink(
                    receiveCompletion: { completion in
                        switch completion {
                        case let .failure(error):
                            NSLog("ERROR: \(error.localizedDescription)")
                        case .finished:
                            NSLog("Login token response finished")
                        }
                    },
                    receiveValue: { data in
                        loginTokenData = data
                    }
                )
                .store(in: &cancellables)
            }
        }
    }
}
