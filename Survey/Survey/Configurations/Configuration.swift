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

    static var clientId: String {
        guard let clientId = Bundle.main.infoDictionary?["SURVEY_CLIENT_ID"] as? String else {
            print("Error: did't find Client Id in configuration file")
            return ""
        }
        return clientId
    }

    static var clientSecret: String {
        guard let clientSecret = Bundle.main.infoDictionary?["SURVEY_CLIENT_SECRET"] as? String else {
            print("Error: did't find Client Secret in configuration file")
            return ""
        }
        return clientSecret
    }
}
