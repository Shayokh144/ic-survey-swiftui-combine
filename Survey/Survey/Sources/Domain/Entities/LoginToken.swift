//
//  LoginToken.swift
//  Survey
//
//  Created by Taher on 4/11/22.
//

import Foundation

protocol LoginToken {

    var accessToken: String { get }
    var tokenType: String { get }
    var expiresIn: Int { get }
    var refreshToken: String { get }
    var createdAt: Date? { get }
}
