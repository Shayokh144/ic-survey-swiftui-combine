//
//  KeychainHelper.swift
//  Survey
//
//  Created by Taher on 8/11/22.
//

import Foundation
import KeychainAccess

final class KeychainHelper {

    static let shared = KeychainHelper()

    private let service: String
    private let keyChain: Keychain

    private init() {
        service = KeyChainConstants.keyChainServiceName ?? "taher.survey.ic"
        keyChain = Keychain(service: service)
    }

    func saveString(key: String, value: String) throws {
        do {
            try keyChain.set(value, key: key)
        } catch {
            throw KeyChainError.failedToSaveData
        }
    }

    func getString(for key: String) throws -> String {
        guard let value = keyChain[string: key] else {
            throw KeyChainError.dataNotFound
        }
        return value
    }

    func deleteString(for key: String) throws {
        do {
            try keyChain.remove(key)
        } catch {
            throw KeyChainError.failedToDeleteData
        }
    }
}
