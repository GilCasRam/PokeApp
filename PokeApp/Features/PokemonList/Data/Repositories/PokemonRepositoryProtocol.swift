//
//  PokemonRepositoryProtocol.swift
//  PokeApp
//
//  Created by Gil CasRam on 21/07/25.
//

import Foundation

protocol PokemonRepositoryProtocol {
    func getPokemonList(limit: Int, offset: Int) async -> Result<[PokemonBusinessEntity], PokemonError>
}
