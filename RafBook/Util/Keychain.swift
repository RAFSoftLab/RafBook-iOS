//
//  Keychain.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 22.12.24.
//
import Security
import Foundation

class KeychainManager {
    
    static let tokenIdentifier = "jwtToken"
    
    /// Saves the token securely in the Keychain.
    /// - Parameter token: The token string to save.
    static func saveTokenToKeychain(token: String) {
        let tokenData = token.data(using: .utf8)!
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: tokenIdentifier,
            kSecValueData as String: tokenData
        ]
        
        SecItemDelete(query as CFDictionary)
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status == errSecSuccess {
            print("Token saved successfully in Keychain.")
        } else {
            print("Failed to save token in Keychain. Error code: \(status)")
        }
    }
    
    /// Retrieves the token securely from the Keychain.
    /// - Returns: The token string, if it exists.
    static func retrieveTokenFromKeychain() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: tokenIdentifier,
            kSecReturnData as String: true
        ]
        
        var dataTypeRef: AnyObject? = nil
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == errSecSuccess, let data = dataTypeRef as? Data {
            return String(data: data, encoding: .utf8)
        } else {
            print("Failed to retrieve token from Keychain. Error code: \(status)")
            return nil
        }
    }
    
    /// Deletes the token securely from the Keychain.
    static func deleteTokenFromKeychain() {
        // Query to delete the token
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: tokenIdentifier
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        if status == errSecSuccess {
            print("Token deleted successfully from Keychain.")
        } else {
            print("Failed to delete token from Keychain. Error code: \(status)")
        }
    }
}
