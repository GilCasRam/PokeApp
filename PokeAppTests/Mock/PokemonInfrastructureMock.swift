//
//  PokemonInfrastructureMock.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 20/07/25.
//

import Foundation
import XCTest
@testable import PokeApp

final class PokemonInfrastructureMock: PokemonInfrastructureProtocol {
    func getPokemonList(limit: Int, offset: Int) async -> Result<[PokemonModel], PokemonError> {
        let mockPokemons: [PokemonModel] = [
            PokemonModel(id: 1, name: "Bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"),
            PokemonModel(id: 2, name: "Ivysaur", url: "https://pokeapi.co/api/v2/pokemon/2/"),
            PokemonModel(id: 3, name: "Venusaur", url: "https://pokeapi.co/api/v2/pokemon/3/")
        ]
        return .success(mockPokemons)
    }
}
