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
    /// Returns the internal Pokémon model only if it passes a domain rule validation.
    /// - Throws: `glitchedPokemon` error if the Pokémon is "MissingNo", which is considered invalid.
    func getValidatedPokemon() throws -> PokemonModel {
        if pokemon.name == "MissingNo" {
            throw PokemonBusinessRuleError.glitchedPokemon
        }
        return pokemon
    }
    /// Provides direct access to the raw data model (DTO).
    /// This is useful when passing the model to other layers or storage.
    var rawPokemon: PokemonModel {
        pokemon
    }
    /// Returns the Pokémon's name.
    /// Could be used directly in the UI.
    var name: String {
        pokemon.name
    }
    /// Returns the Pokémon's unique identifier.
    var id: Int {
        pokemon.id
    }
    /// Dynamically constructs the image URL for this Pokémon using its ID.
    /// Follows the standard sprite URL format from the PokeAPI GitHub CDN.
    var imageUrl: String {
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
    }
}
