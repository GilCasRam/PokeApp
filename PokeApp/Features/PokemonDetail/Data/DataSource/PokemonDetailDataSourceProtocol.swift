//
//  PokemonDetailDataSourceProtocol.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 17/07/25.
//

import Foundation

protocol PokemonDetailDataSourceProtocol {
    func fetchPokemonDetail(id: Int) async -> Result<PokemonDetailModel, PokemonDetailError>
}
