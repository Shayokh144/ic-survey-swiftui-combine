//
//  HTTPError.swift
//  Survey
//
//  Created by Taher on 4/11/22.
//

import Foundation

enum HTTPError: Error, Equatable {

    case statusCode(Int)
    case invalidResponse
    case invalidUrl
}

extension HTTPError: LocalizedError {

    var errorDescription: String? {
        
        switch self {
        case .invalidResponse:
            return "Http error: invalid response" // TODO: Add localization
        case let .statusCode(int):
            return String(int)
        case .invalidUrl:
            return "Invalid URL given." // TODO: Add localization
        }
    }
}
