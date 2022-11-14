//
//  ValidityChecker.swift
//  Survey
//
//  Created by Taher on 8/11/22.
//

import Foundation

struct ValidityChecker: ValidityCheckerProtocol {

    func isValidEmail(address: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: address)
    }

    func isValidPasswordFormat(password: String) -> Bool {
        if password.isNotEmpty {
            return true
        }
        return false
    }
}
