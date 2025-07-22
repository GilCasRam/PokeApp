//
//  PokemonInfrastructureImp.swift
//  PokeApp
//
//  Created by Gil CasRam on 21/07/25.
//

import Foundation

final class PokemonInfrastructureImp: PokemonInfrastructureProtocol {

    /// Fetches a paginated list of Pokémon from the PokeAPI.
    /// - Parameters:
    ///   - limit: The number of Pokémon to fetch.
    ///   - offset: The starting index (for pagination).
    /// - Returns: A `Result` containing either an array of `PokemonModel` or a `PokemonError`.
    func getPokemonList(limit: Int, offset: Int) async -> Result<[PokemonModel], PokemonError> {
        // Builds the full URL string using pagination parameters.
        let urlString = "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)"
        // Validates that the URL string can be converted into a valid `URL` object.
        guard let url = URL(string: urlString) else {
            return .failure(.invalidURL)
        }

        do {
            // Performs the API call asynchronously using `URLSession`.
            let (data, _) = try await URLSession.shared.data(from: url)
            // Attempts to decode the JSON into a strongly-typed response model.
            let decoded = try JSONDecoder().decode(PokemonListResponse.self, from: data)

            // Maps the decoded results into an array of `PokemonModel`.
            // Extracts the Pokémon ID from the URL (which contains the ID at the end of the path).
            let models: [PokemonModel] = decoded.results.enumerated().map { index, item in
                let id = Int(item.url.split(separator: "/").last ?? "\(index)") ?? index
                return PokemonModel(id: id, name: item.name.capitalized, url: item.url)
            }

            // Returns the successfully mapped list of Pokémon models.
            return .success(models)
        } catch {
            // If decoding or the network request fails, return a generic error.
            return .failure(.generic)
        }
    }
}
