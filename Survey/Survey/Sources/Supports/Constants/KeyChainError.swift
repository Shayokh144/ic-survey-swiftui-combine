//
//  KeyChainError.swift
//  Survey
//
//  Created by Taher on 13/11/22.
//

import Foundation

enum KeyChainError: Error {

    case dataNotFound
    case failedToSaveData
    case failedToDeleteData

    var errorDescription: String {
        switch self {
        case .dataNotFound:
            return "Keychain data not found."
        case .failedToSaveData:
            return "Keychain failed to save data."
        case .failedToDeleteData:
            return "Keychain failed to delete data."
        }
    }
}
