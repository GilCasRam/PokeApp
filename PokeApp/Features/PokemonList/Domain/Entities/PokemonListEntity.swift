//
//  PokemonListEntity.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 16/07/25.
//

import Foundation

class PokemonBusinessEntity {
    private let pokemon: PokemonModel
    
    // Default init (útil para pruebas o estados vacíos)
    init() {
        self.pokemon = PokemonModel(id: 0, name: "", url: "")
    }
    
    init(pokemon: PokemonModel) {
        self.pokemon = pokemon
    }
    
    // Validación de negocio (ejemplo)
    func getValidatedPokemon() throws -> PokemonModel {
        if pokemon.name == "MissingNo" {
            throw PokemonBusinessRuleError.glitchedPokemon
        }
        return pokemon
    }
    
    // Acceso directo
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

enum PokemonBusinessRuleError: Error {
    case glitchedPokemon
}
