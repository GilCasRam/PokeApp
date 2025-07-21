//
//  PokemonListServiceProtocol.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 16/07/25.
//

import Foundation

protocol PokemonInfrastructureProtocol {
    func getPokemonList(limit: Int, offset: Int) async -> Result<[PokemonModel], PokemonError>
}
