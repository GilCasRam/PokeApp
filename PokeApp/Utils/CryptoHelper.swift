//
//  CryptoHelper.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 20/07/25.
//

import Foundation

struct CryptoHelper {
    private static let key = 3 

    static func encrypt(_ text: String) -> String {
        return String(text.unicodeScalars.map {
            Character(UnicodeScalar($0.value + UInt32(key))!)
        })
    }

    static func decrypt(_ text: String) -> String {
        return String(text.unicodeScalars.map {
            Character(UnicodeScalar($0.value - UInt32(key))!)
        })
    }
}
