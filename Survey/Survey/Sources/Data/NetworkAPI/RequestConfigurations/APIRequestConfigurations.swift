//
//  APIRequest.swift
//  Survey
//
//  Created by Taher on 9/11/22.
//

import Foundation

enum APIRequestConfigurations: RequestConfiguration {

    case login(email: String, password: String)
}

extension APIRequestConfigurations {

    var baseURL: String {
        "https://survey-api.nimblehq.co/" // TODO: Read from config file in integration task
    }

    var endpoint: String {
        switch self {
        case .login:
            return "api/v1/oauth/token" // TODO: Read from config file in integration task
        }
    }

    var method: URLRequest.HttpMethod {
        switch self {
        case .login:
            return .post
        }
    }

    var urlRequest: URLRequest? {
        switch self {
        case .login:
            guard let requestUrl = url else {
                NSLog("Invalid URL given!")
                return nil
            }
            var request = URLRequest(url: requestUrl, timeoutInterval: TimeInterval(timeOutValue))
            request.httpMethod = method.current
            request.addValue(contentTypeValue, forHTTPHeaderField: contentType)
            request.httpBody = nil

            if let body = parameters {
                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
                } catch {
                    NSLog(error.localizedDescription)
                }
            }
            return request
        }
    }

    var parameters: Parameters? {
        switch self {
        case .login(let email, let password):
            return [
                "grant_type": "password",
                "email": email,
                "password": password,
                "client_id": "ofzl-2h5ympKa0WqqTzqlVJUiRsxmXQmt5tkgrlWnOE",
                // TODO: Read from config file in integration task
                "client_secret": "lMQb900L-mTeU-FVTCwyhjsfBwRCxwwbCitPob96cuU"
                // TODO: Read from config file in integration task
            ]
        }
    }

    var retryCount: Int {
        switch self {
        case .login:
            return 0
        }
    }

    var timeOutValue: Int {
        switch self {
        case .login:
            return 500
        }
    }
}
