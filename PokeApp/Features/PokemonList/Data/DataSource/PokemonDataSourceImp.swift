//
//  PokemonDataSourceImp.swift
//  PokeApp
//
//  Created by Gil CasRam on 21/07/25.
//

import Foundation

final class PokemonDataSourceImp: PokemonDataSourceProtocol {
    private let infrastructure: PokemonInfrastructureProtocol

    init(infrastructure: PokemonInfrastructureProtocol) {
        self.infrastructure = infrastructure
    }

    func fetchPokemonList(limit: Int, offset: Int) async -> Result<[PokemonModel], PokemonError> {
        return await infrastructure.getPokemonList(limit: limit, offset: offset)
    }
}
