//
//  LoginUseCase.swift
//  Survey
//
//  Created by Taher on 4/11/22.
//

import Combine

final class LoginUseCase: LoginUseCaseProtocol {

    private let loginRepository: LoginRepositoryProtocol

    init(loginRepository: LoginRepositoryProtocol) {
        self.loginRepository = loginRepository
    }

    func executeLogin(email: String, password: String) -> Observable<LoginTokenApi> {
        loginRepository.getLoginToken(email: email, password: password)
    }
}
