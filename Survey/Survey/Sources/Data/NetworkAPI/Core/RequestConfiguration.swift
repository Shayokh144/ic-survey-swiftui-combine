//
//  RequestConfiguration.swift
//  Survey
//
//  Created by Taher on 4/11/22.
//

import Foundation

protocol RequestConfiguration {

    var baseURL: String { get }
    var endpoint: String { get }
    var url: URL? { get }
    var method: URLRequest.HttpMethod { get }
    var urlRequest: URLRequest? { get }
    var parameters: Parameters? { get }
    var retryCount: Int { get }
    var timeOutValue: Int { get }
    var headers: HTTPHeaders { get }
}

extension RequestConfiguration {

    var baseURL: String {
        "https://survey-api.nimblehq.co/" // TODO: Read from config file in integration task
    }

    var url: URL? { URL(string: baseURL)?.appendingPathComponent(endpoint) }

    var urlRequest: URLRequest? {
        guard let requestUrl = url else {
            NSLog("Invalid URL given!")
            return nil
        }
        var request = URLRequest(url: requestUrl, timeoutInterval: TimeInterval(timeOutValue))
        request.httpMethod = method.current
        headers.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        if let body = parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
            } catch {
                NSLog(error.localizedDescription)
            }
        }
        return request
    }

    var timeOutValue: Int { 500 }

    var headers: HTTPHeaders { ["Content-Type": "application/json"] }
}
