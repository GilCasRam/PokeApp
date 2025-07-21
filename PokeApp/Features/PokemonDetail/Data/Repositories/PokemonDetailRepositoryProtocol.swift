//
//  PokemonDetailRepositoryProtocol.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 17/07/25.
//

import Foundation

protocol PokemonDetailRepositoryProtocol {
    func getPokemonDetail(id: Int) async -> Result<PokemonDetailBusinessEntity, PokemonDetailError>
}
