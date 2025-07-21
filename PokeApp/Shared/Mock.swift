//
//  MockDataErrors.swift
//  CleanExample
//
//  Created by Gil CasRam on 14/05/25.
//

import Foundation

extension Bundle {
    func getMockData<T: Decodable>(from fileName: String, fileExtension: String = "json") -> Result<T, MockDataErrors> {
        guard let url = self.url(forResource: fileName, withExtension: fileExtension) else {
            return .failure(.fileNotFound)
        }

        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return .success(decoded)
        } catch {
            return .failure(.decodingFailed(error))
        }
    }
}
