//
//  PokemonDataSourceProtocol.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 17/07/25.
//

import Foundation

protocol PokemonDataSourceProtocol {
    func fetchPokemonList(limit: Int, offset: Int) async -> Result<[PokemonModel], PokemonError>
}

final class PokemonDataSourceImp: PokemonDataSourceProtocol {
    private let infrastructure: PokemonInfrastructureProtocol

    init(infrastructure: PokemonInfrastructureProtocol) {
        self.infrastructure = infrastructure
    }

    func fetchPokemonList(limit: Int, offset: Int) async -> Result<[PokemonModel], PokemonError> {
        return await infrastructure.getPokemonList(limit: limit, offset: offset)
    }
}
