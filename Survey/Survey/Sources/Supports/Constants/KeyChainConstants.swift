//
//  KeyChainConstants.swift
//  Survey
//
//  Created by Taher on 8/11/22.
//

import Foundation

enum KeyChainConstants {

    static let keyChainServiceName = Bundle.main.bundleIdentifier
    static let keyChainAccountName = "devnimblelogintoken"
    static let accessTokenKey = "access_token"
    static let refreshTokenKey = "refresh_token"
}
