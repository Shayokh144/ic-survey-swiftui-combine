//
//  LoginTokenApi+Dummy.swift
//  SurveyUnitTests
//
//  Created by Taher on 11/11/22.
//

import Foundation
import Survey

extension LoginTokenApi {

    static func createDummy(
        accessToken: String = "A",
        tokenType: String = "B",
        expiresIn: Int = 123_436,
        refreshToken: String = "R",
        createdAt: Date? = Date()
    ) -> LoginTokenApi {
        LoginTokenApi(
            accessToken: accessToken,
            tokenType: tokenType,
            expiresIn: expiresIn,
            refreshToken: refreshToken,
            createdAt: createdAt
        )
    }
}
