//
//  MockDataErrors.swift
//  CleanExample
//
//  Created by Gil CasRam on 14/05/25.
//

import Foundation

extension Bundle {
    /// Loads and decodes mock data from a bundled JSON file.
    /// Useful for local testing, SwiftUI previews, or mocking API responses.
    /// - Parameters:
    ///   - fileName: The name of the JSON file (without extension).
    ///   - fileExtension: File extension, defaults to `"json"`.
    /// - Returns: A `Result` containing the decoded object or an error.
    func getMockData<T: Decodable>(from fileName: String, fileExtension: String = "json") -> Result<T, MockDataErrors> {
        // Locates the file in the app bundle.
        guard let url = self.url(forResource: fileName, withExtension: fileExtension) else {
            return .failure(.fileNotFound)
        }

        do {
            // Loads the file's contents into memory.
            let data = try Data(contentsOf: url)
            // Attempts to decode the data into the expected type.
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return .success(decoded)
        } catch {
            // If decoding fails, return a descriptive error.
            return .failure(.decodingFailed(error))
        }
    }
}
