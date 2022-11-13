//
//  APIRequestConfigurations.swift
//  Survey
//
//  Created by Taher on 9/11/22.
//

import Foundation

enum APIRequestConfigurations: RequestConfiguration {

    case login(email: String, password: String)
}

extension APIRequestConfigurations {

    var endpoint: String {
        switch self {
        case .login: return "oauth/token"
        }
    }

    var method: URLRequest.HttpMethod {
        switch self {
        case .login: return .post
        }
    }

    var parameters: Parameters? {
        switch self {
        case let .login(email, password):
            return [
                "grant_type": "password",
                "email": email,
                "password": password,
                "client_id": Configuration.clientId,
                "client_secret": Configuration.clientSecret
            ]
        }
    }

    var retryCount: Int {
        switch self {
        case .login: return 0
        }
    }
}
