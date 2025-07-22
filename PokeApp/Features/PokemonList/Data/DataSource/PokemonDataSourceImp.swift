//
//  PokemonDataSourceImp.swift
//  PokeApp
//
//  Created by Gil CasRam on 21/07/25.
//

import Foundation

/// Concrete implementation of `PokemonDataSourceProtocol`.
/// Acts as an intermediate layer between the repository and the infrastructure (API).
final class PokemonDataSourceImp: PokemonDataSourceProtocol {
    // Dependency that handles the actual API/network requests.
    private let infrastructure: PokemonInfrastructureProtocol

    /// Initializes the data source with a given infrastructure implementation.
    /// This allows for better modularity and easier testing.
    init(infrastructure: PokemonInfrastructureProtocol) {
        self.infrastructure = infrastructure
    }

    /// Fetches a list of Pokémon from the infrastructure layer using pagination parameters.
    /// - Parameters:
    ///   - limit: Number of Pokémon to fetch.
    ///   - offset: Starting index for pagination.
    /// - Returns: A Result containing either a list of Pokémon models or an error.
    func fetchPokemonList(limit: Int, offset: Int) async -> Result<[PokemonModel], PokemonError> {
        return await infrastructure.getPokemonList(limit: limit, offset: offset)
    }
}
