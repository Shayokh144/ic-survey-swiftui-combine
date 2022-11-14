//
//  ValidityCheckerProtocol.swift
//  Survey
//
//  Created by Taher on 11/11/22.
//

import Foundation

protocol ValidityCheckerProtocol {

    func isValidEmail(address: String) -> Bool
    func isValidPasswordFormat(password: String) -> Bool
}
