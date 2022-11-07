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
    var contentType: String { get }
    var contentTypeValue: String { get }
}

extension RequestConfiguration {

    var url: URL? {
        URL(string: baseURL)?.appendingPathComponent(endpoint)
    }

    var contentType: String {
        "Content-Type"
    }

    var contentTypeValue: String {
        "application/json"
    }
}
