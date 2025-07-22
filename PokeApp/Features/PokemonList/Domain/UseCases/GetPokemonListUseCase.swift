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

    func execute(limit: Int, offset: Int) async -> Result<[PokemonBusinessEntity], PokemonError> {
        return await repository.getPokemonList(limit: limit, offset: offset)
    }
}
