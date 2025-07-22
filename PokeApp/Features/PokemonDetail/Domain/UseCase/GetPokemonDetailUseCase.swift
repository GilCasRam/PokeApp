//
//  GetPokemonDetailUseCase.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 17/07/25.
//

import Foundation

/// Use case responsible for retrieving detailed information about a Pokémon.
/// Acts as an application layer component that delegates the work to the repository.
final class GetPokemonDetailUseCase: GetPokemonDetailProtocol {
    // Repository used to access data from network or local sources.
    private let repository: PokemonDetailRepositoryProtocol

    /// Initializes the use case with a repository that conforms to the required protocol.
    /// This promotes dependency inversion and allows for testing or swapping implementations.
    init(repository: PokemonDetailRepositoryProtocol) {
        self.repository = repository
    }

    /// Executes the use case: fetches the Pokémon detail using the given ID.
    /// Delegates to the repository, which handles data retrieval and mapping.
    /// Returns a Result with either the business entity or an error.
    func execute(id: Int) async -> Result<PokemonDetailBusinessEntity, PokemonDetailError> {
        return await repository.getPokemonDetail(id: id)
    }
}
