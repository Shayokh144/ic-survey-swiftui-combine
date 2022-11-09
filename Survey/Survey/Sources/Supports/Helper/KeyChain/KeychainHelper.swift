//
//  KeychainHelper.swift
//  Survey
//
//  Created by Taher on 8/11/22.
//

import Foundation

final class KeychainHelper {

    enum KeyChainError: Error {
        case duplicateEntry
        case unknown(OSStatus)
    }

    static let shared = KeychainHelper()

    private let service: String
    private let account: String

    private init() {
        service = KeyChainConstants.keyChainServiceName ?? "taher.survey.ic"
        account = KeyChainConstants.keyChainAccountName
    }

    func save<T: Codable>(item: T) {
        do {
            let data = try JSONEncoder().encode(item)
            try save(data: data)

        } catch {
            NSLog(error.localizedDescription)
        }
    }

    func read<T: Codable>(type: T.Type) -> T? {
        guard let data = read() else {
            return nil
        }
        do {
            let item = try JSONDecoder().decode(type, from: data)
            return item
        } catch {
            NSLog(error.localizedDescription)
            return nil
        }
    }

    func update<T: Codable>(item: T) {
        do {
            let data = try JSONEncoder().encode(item)
            update(newData: data)

        } catch {
            NSLog(error.localizedDescription)
        }
    }

    private func save(data: Data) throws {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecValueData as String: data as AnyObject
        ]
        let status = SecItemAdd(query as CFDictionary, nil)
        if status == errSecDuplicateItem {
            throw KeyChainError.duplicateEntry
        }
        if status != errSecSuccess {
            throw KeyChainError.unknown(status)
        }
    }

    private func read() -> Data? {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var result: AnyObject?
        _ = SecItemCopyMatching(query as CFDictionary, &result)
        return result as? Data
    }

    private func update(newData: Data) {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account as AnyObject
        ]
        let newAttributes: [String: AnyObject] = [
            kSecValueData as String: newData as AnyObject
        ]
        let status = SecItemUpdate(query as CFDictionary, newAttributes as CFDictionary)
        if status != errSecSuccess {
            NSLog("cant update keychain")
        } else {
            NSLog("key chain data updated")
        }
    }

    func delete() {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject
        ]
        let status = SecItemDelete(query as CFDictionary)
        if status != errSecSuccess {
            NSLog("can't delete from keychain")
        } else {
            NSLog("key chain data deleted")
        }
    }
}
