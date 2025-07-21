//
//  MockDataErrors.swift
//  CleanExample
//
//  Created by Gil CasRam on 14/05/25.
//

import Foundation

enum MockDataErrors: Error {
    case fileNotFound
    case decodingFailed(Error)
}
