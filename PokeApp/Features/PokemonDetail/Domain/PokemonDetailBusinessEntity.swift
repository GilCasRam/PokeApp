//
//  PokemonDetailBusinessEntity.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 17/07/25.
//

import Foundation

class PokemonDetailBusinessEntity {
    private let pokemon: PokemonDetailModel

    init() {
        self.pokemon = PokemonDetailModel(
            id: 0,
            name: "",
            height: 0,
            weight: 0,
            sprites: Sprites(frontDefault: nil),
            types: [],
            stats: [],
            abilities: []
        )
    }

    init(pokemon: PokemonDetailModel) {
        self.pokemon = pokemon
    }

    // Validación de negocio
    func getValidatedPokemon() throws -> PokemonDetailModel {
        if pokemon.name.lowercased() == "missingno" {
            throw PokemonDetailBusinessRuleError.glitchedPokemon
        }
        return pokemon
    }

    // Accesos directos
    var raw: PokemonDetailModel {
        pokemon
    }
    
    var pokemonRaw: PokemonModel {
        PokemonModel(id: pokemon.id, name: pokemon.name, url: imageUrl ?? "")
    }

    var name: String {
        pokemon.name.capitalized
    }

    var id: Int {
        pokemon.id
    }

    var imageUrl: String? {
        pokemon.sprites.frontDefault
    }

    var types: [String] {
        pokemon.types.map { $0.type.name.capitalized }
    }

    var abilities: [String] {
        pokemon.abilities.map { $0.ability.name.capitalized }
    }

    var stats: [(name: String, value: Int)] {
        pokemon.stats.map { ($0.stat.name.capitalized, $0.baseStat) }
    }

    var height: Int {
        pokemon.height
    }

    var weight: Int {
        pokemon.weight
    }

    enum PokemonDetailBusinessRuleError: Error {
        case glitchedPokemon
    }
}
