//
//  LoginRepository.swift
//  Survey
//
//  Created by Taher on 4/11/22.
//

import Combine
import Foundation

final class LoginRepository: LoginRepositoryProtocol {

    let network: NetworkAPIProtocol

    init(network: NetworkAPIProtocol) {
        self.network = network
    }

    func getLoginToken(email: String, password: String) -> Observable<LoginTokenApi> {
        network.performRequest(
            APIRequestConfigurations.login(email: email, password: password),
            for: LoginTokenApi.self
        )
    }
}
