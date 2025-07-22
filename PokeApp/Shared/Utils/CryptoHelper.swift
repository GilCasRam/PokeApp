//
//  CryptoHelper.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 20/07/25.
//

import Foundation

/// Utility for basic encryption and decryption using a Caesar cipher-like algorithm.
/// Not secure for production use, but useful for obfuscating data locally (e.g., in Core Data).
struct CryptoHelper {
    // The fixed key used to shift Unicode scalar values.
    private static let key = 3

    /// Encrypts a string by shifting each character's Unicode scalar value by the key.
    /// - Parameter text: The original plain text string.
    /// - Returns: The encrypted (obfuscated) string.
    static func encrypt(_ text: String) -> String {
        return String(text.unicodeScalars.map {
            Character(UnicodeScalar($0.value + UInt32(key))!)
        })
    }

    /// Decrypts a string by reversing the shift applied during encryption.
    /// - Parameter text: The encrypted string.
    /// - Returns: The original plain text string.
    static func decrypt(_ text: String) -> String {
        return String(text.unicodeScalars.map {
            Character(UnicodeScalar($0.value - UInt32(key))!)
        })
    }
}
