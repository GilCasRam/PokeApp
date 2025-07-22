//
//  GetPokemonListUseCase.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 16/07/25.
//

import Foundation

final class GetPokemonListUseCase: GetPokemonListProtocol {
    private let repository: PokemonRepositoryProtocol

    init(repository: PokemonRepositoryProtocol) {
        self.repository = repository
    }

    /// Executes the use case to retrieve a list of Pokémon with pagination support.
    /// Delegates the task to the repository, which handles data access and transformation.
    /// - Parameters:
    ///   - limit: The number of Pokémon to fetch.
    ///   - offset: The starting index for pagination.
    /// - Returns: A `Result` containing either a list of business entities or an error.
    func execute(limit: Int, offset: Int) async -> Result<[PokemonBusinessEntity], PokemonError> {
        return await repository.getPokemonList(limit: limit, offset: offset)
    }
}
