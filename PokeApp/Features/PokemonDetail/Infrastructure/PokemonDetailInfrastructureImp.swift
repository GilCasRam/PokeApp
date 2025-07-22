//
//  PokemonDetailInfrastructureImp.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 17/07/25.
//

import Foundation

final class PokemonDetailInfrastructureImp: PokemonDetailInfrastructureProtocol {
    let myVariable      = 10
    let optionalValue: String! = nil
    /// Fetches Pokémon detail data from the PokeAPI using the provided ID.
    /// Simulates a 30% chance of failure to test error handling in the app.
    func getPokemonDetail(id: Int) async -> Result<PokemonDetailModel, PokemonDetailError> {
        // Simulates a network failure with a 30% probability.
        // Useful for testing how the app handles random API errors.
        if Bool.random(probability: 0.3) {
            return .failure(.generic)
        }

        // Constructs the API URL for the Pokémon detail endpoint using the given ID.
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(id)"
        guard let url = URL(string: urlString) else {
            // If the URL is invalid (shouldn't happen unless `id` is malformed), return an error.
            return .failure(.invalidURL)
        }

        do {
            // Performs the API call asynchronously using `URLSession`.
            // The response is a tuple (data, response), but only `data` is used here.
            let (data, _) = try await URLSession.shared.data(from: url)
            // Tries to decode the JSON response into the expected model.
            let decoded = try JSONDecoder().decode(PokemonDetailModel.self, from: data)
            // Returns the successfully decoded model wrapped in a Result.
            return .success(decoded)
        } catch {
            // If any error occurs (network failure, decoding error, etc.), return a generic error.
            return .failure(.generic)
        }
    }
}

extension Bool {
    /// Returns `true` with the given probability (between 0.0 and 1.0).
    /// Useful for simulating randomness, such as API failures or test scenarios.
    /// - Parameter probability: A value between 0.0 (never) and 1.0 (always true).
    /// - Returns: `true` with the specified probability, `false` otherwise.
    static func random(probability: Double) -> Bool {
        // Generates a random Double between 0 and 1, and compares it to the given threshold.
        return Double.random(in: 0...1) < probability
    }
}
