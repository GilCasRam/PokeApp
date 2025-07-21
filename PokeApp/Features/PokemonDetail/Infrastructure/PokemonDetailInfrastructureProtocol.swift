//
//  PokemonDetailInfrastructureProtocol.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 17/07/25.
//

import Foundation

protocol PokemonDetailInfrastructureProtocol {
    func getPokemonDetail(id: Int) async -> Result<PokemonDetailModel, PokemonDetailError>
}
