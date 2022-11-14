//
//  MockLoginRepository.swift
//  Survey
//
//  Created by Taher on 14/11/22.
//

import Combine
import Foundation

final class MockLoginRepository: LoginRepositoryProtocol {

    var isLoginSuccess = false

    func getLoginToken(email: String, password: String) -> Observable<LoginTokenApi> {
        if email == "abc@nimblehq.co", password == "12345" {
            isLoginSuccess = true
        }
        return Fail(error: HTTPError.invalidUrl)
            .eraseToAnyPublisher()
    }
}
