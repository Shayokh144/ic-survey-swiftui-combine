//
//  URLRequest+Extension.swift
//  Survey
//
//  Created by Taher on 4/11/22.
//

import Foundation

extension URLRequest {

    enum HttpMethod: String {

        case get = "GET"
        case post = "POST"

        var current: String {
            rawValue
        }
    }
}
