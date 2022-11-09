//
//  LoginRepository.swift
//  Survey
//
//  Created by Taher on 4/11/22.
//

import Combine
import Foundation

final class LoginRepository: LoginRepositoryProtocol {

    let network: LoginNetworkAPI

    init(network: LoginNetworkAPI) {
        self.network = network
    }

    func getLoginToken(email: String, password: String) -> AnyPublisher<LoginTokenApi, Error> {
        network.performRequest(
            APIRequestConfigurations.login(email: email, password: password),
            for: LoginTokenApi.self,
            with: URLSession.shared
        )
    }
}
