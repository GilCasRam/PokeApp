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
