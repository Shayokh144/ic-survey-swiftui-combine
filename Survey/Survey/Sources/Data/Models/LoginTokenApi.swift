//
//  LoginTokenApi.swift
//  Survey
//
//  Created by Taher on 4/11/22.
//

import Foundation

struct LoginTokenApi: Codable, LoginToken {

    enum CodingKeys: String, CodingKey {
        case data
        case attributes
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case createdAt = "created_at"
    }

    let accessToken: String
    let tokenType: String
    let expiresIn: Int
    let refreshToken: String
    let createdAt: Date?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        let attributes = try data.nestedContainer(keyedBy: CodingKeys.self, forKey: .attributes)
        accessToken = try attributes.decode(String.self, forKey: .accessToken)
        tokenType = try attributes.decode(String.self, forKey: .tokenType)
        expiresIn = try attributes.decode(Int.self, forKey: .expiresIn)
        refreshToken = try attributes.decode(String.self, forKey: .refreshToken)
        createdAt = try? attributes.decode(Date.self, forKey: .createdAt)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var data = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        var attributes = data.nestedContainer(keyedBy: CodingKeys.self, forKey: .attributes)
        try attributes.encode(accessToken, forKey: .accessToken)
        try attributes.encode(tokenType, forKey: .tokenType)
        try attributes.encode(expiresIn, forKey: .expiresIn)
        try attributes.encode(refreshToken, forKey: .refreshToken)
        try attributes.encode(createdAt, forKey: .createdAt)
    }
}
