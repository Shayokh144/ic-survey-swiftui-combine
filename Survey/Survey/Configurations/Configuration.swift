//
//  Configuration.swift
//  Survey
//
//  Created by Taher on 26/10/22.
//

import Foundation

enum Configuration: String {
    case debug
    case staging
    case production

    // MARK: - Current Configuration

    static let current: Configuration = {
        #if DEBUG
            return .debug
        #elseif STAGING
            return .staging
        #elseif PRODUCTION
            return .production
        #endif
    }()

    static var baseSurveyURL: String {
        guard let urlValue = Bundle.main.infoDictionary?["SURVEY_API_BASE_URL"] as? String else {
            print("Error: did't find url in configuration file")
            return ""
        }
        return "https://\(urlValue)/"
    }
}
