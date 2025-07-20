//
//  PokemonDetailRepositoryProtocol.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 17/07/25.
//


protocol PokemonDetailRepositoryProtocol {
    func getPokemonDetail(id: Int) async -> Result<PokemonDetailBusinessEntity, PokemonDetailError>
}
