//
//  PokemonDetailDataSourceImp.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 17/07/25.
//

import Foundation

/// Concrete implementation of the `PokemonDetailDataSourceProtocol`.
/// Responsible for retrieving Pokémon detail data by delegating to the infrastructure layer.
final class PokemonDetailDataSourceImp: PokemonDetailDataSourceProtocol {
    // Dependency to the infrastructure layer that handles the actual API or local data calls.
    private let infrastructure: PokemonDetailInfrastructureProtocol

    /// Initializes the data source with a given infrastructure implementation.
    /// This allows flexibility in switching between different data providers (e.g., mock, API).
    init(infrastructure: PokemonDetailInfrastructureProtocol) {
        self.infrastructure = infrastructure
    }

    /// Fetches the detail of a Pokémon by its ID.
    /// Delegates the work to the infrastructure layer, which abstracts the API or storage logic.
    /// Returns a `Result` to handle both success (`PokemonDetailModel`) and failure (`PokemonDetailError`) cases.
    func fetchPokemonDetail(id: Int) async -> Result<PokemonDetailModel, PokemonDetailError> {
        return await infrastructure.getPokemonDetail(id: id)
    }
}
