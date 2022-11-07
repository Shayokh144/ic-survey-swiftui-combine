//
//  LoginTokenRequestConfiguration.swift
//  Survey
//
//  Created by Taher on 4/11/22.
//

import Foundation

struct LoginTokenRequestConfiguration: RequestConfiguration {

    var email: String
    var password: String

    var baseURL: String {
        "https://survey-api.nimblehq.co/" // TODO: Read from config file in integration task
    }

    var endpoint: String {
        "api/v1/oauth/token" // TODO: Read from config file in integration task
    }

    var method: URLRequest.HttpMethod {
        .post
    }

    var urlRequest: URLRequest? {
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

    var parameters: Parameters? {
        [
            "grant_type": "password",
            "email": email,
            "password": password,
            "client_id": "ofzl-2h5ympKa0WqqTzqlVJUiRsxmXQmt5tkgrlWnOE",
            // TODO: Read from config file in integration task
            "client_secret": "lMQb900L-mTeU-FVTCwyhjsfBwRCxwwbCitPob96cuU"
            // TODO: Read from config file in integration task
        ]
    }

    var retryCount: Int {
        0
    }

    var timeOutValue: Int {
        500
    }
}
