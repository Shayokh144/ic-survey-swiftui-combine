//
//  MockLoginUseCase.swift
//  SurveyUnitTests
//
//  Created by Taher on 14/11/22.
//

import Combine
import Foundation

final class MockLoginUseCase: LoginUseCaseProtocol {

    func executeLogin(email: String, password: String) -> Observable<LoginTokenApi> {
        if email == "abc@nimblehq.co", password == "12345" {
            return Just(LoginTokenApi.createDummy())
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        return Fail(error: HTTPError.invalidUrl)
            .eraseToAnyPublisher()
    }
}
