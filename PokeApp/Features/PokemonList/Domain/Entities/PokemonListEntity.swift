//
//  PokemonListEntity.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 16/07/25.
//

import Foundation

class PokemonBusinessEntity {
    private let pokemon: PokemonModel
    
    init() {
        self.pokemon = PokemonModel(id: 0, name: "", url: "")
    }
    init(pokemon: PokemonModel) {
        self.pokemon = pokemon
    }
    
    func getValidatedPokemon() throws -> PokemonModel {
        if pokemon.name == "MissingNo" {
            throw PokemonBusinessRuleError.glitchedPokemon
        }
        return pokemon
    }

    var rawPokemon: PokemonModel {
        pokemon
    }
    var name: String {
        pokemon.name
    }
    var id: Int {
        pokemon.id
    }
    var imageUrl: String {
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
    }
}
