//
//  UserInfrastructureMock.swift
//  PokeApp
//
//  Created by Gil CasRam on 21/07/25.
//

import Foundation

final class PokemonInfrastructureMock: PokemonInfrastructureProtocol {
    /// Loads a mock list of Pokémon from a local JSON file for testing or development.
    /// - Parameters:
    ///   - limit: The number of Pokémon to fetch (ignored in this mock).
    ///   - offset: The starting index (ignored in this mock).
    /// - Returns: A `Result` containing either a list of `PokemonModel` or a `PokemonError`.
    func getPokemonList(limit: Int, offset: Int) async -> Result<[PokemonModel], PokemonError> {
        // Attempts to load mock data from the "PokemonListMock.json" file in the app bundle.
        let result: Result<PokemonListResponse, MockDataErrors> = Bundle.main.getMockData(from: "PokemonListMock")

        switch result {
        case .success(let response):
            // Maps the mock response results into `PokemonModel` objects.
            let models = response.results.compactMap { item -> PokemonModel? in
                // Extracts the Pokémon ID from the URL by trimming slashes and splitting by "/".
                guard let id = Int(item.url
                    .trimmingCharacters(in: CharacterSet(charactersIn: "/"))
                    .components(separatedBy: "/")
                    .last ?? "") else {
                    return nil
                }

                // Creates and returns a model with capitalized name and original URL.
                return PokemonModel(id: id, name: item.name.capitalized, url: item.url)
            }

            // Returns the successfully parsed list of Pokémon.
            return .success(models)

        case .failure(let error):
            // Logs the mock loading error and returns a generic error result.
            print("Error: \(error)")
            return .failure(.generic)
        }
    }
}
