//
//  PokemonDetailBusinessEntity.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 17/07/25.
//

import Foundation

/// Wraps a `PokemonDetailModel` and exposes validated and formatted access to its data.
/// Acts as a business entity that enforces domain rules and prepares data for the UI or other layers.
class PokemonDetailBusinessEntity {
    // The underlying data model fetched from the API or storage.
    private let pokemon: PokemonDetailModel

    /// Default initializer, useful for previews or fallback scenarios.
    /// Initializes with empty/default values.
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

    /// Initializes the business entity with a valid `PokemonDetailModel`.
    init(pokemon: PokemonDetailModel) {
        self.pokemon = pokemon
    }
    /// Validates the Pokémon model according to a business rule.
    /// Throws an error if the Pokémon is "MissingNo", a well-known glitch character.
    func getValidatedPokemon() throws -> PokemonDetailModel {
        if pokemon.name.lowercased() == "missingno" {
            throw PokemonDetailBusinessRuleError.glitchedPokemon
        }
        return pokemon
    }

    /// Provides raw access to the full detail model.
    var raw: PokemonDetailModel {
        pokemon
    }

    /// Returns a simplified model used in lists or favorites.
    var pokemonRaw: PokemonModel {
        PokemonModel(id: pokemon.id, name: pokemon.name, url: imageUrl ?? "")
    }

    /// Formatted and capitalized name for display.
    var name: String {
        pokemon.name.capitalized
    }

    /// Pokémon ID.
    var id: Int {
        pokemon.id
    }

    /// Main image URL for the Pokémon.
    var imageUrl: String? {
        pokemon.sprites.frontDefault
    }

    /// Returns an array of capitalized type names (e.g., "Fire", "Water").
    var types: [String] {
        pokemon.types.map { $0.type.name.capitalized }
    }

    /// Returns an array of ability names, capitalized.
    var abilities: [String] {
        pokemon.abilities.map { $0.ability.name.capitalized }
    }

    /// Returns the stats as name-value pairs, formatted for display.
    var stats: [(name: String, value: Int)] {
        pokemon.stats.map { ($0.stat.name.capitalized, $0.baseStat) }
    }

    /// Height in decimeters (API standard).
    var height: Int {
        pokemon.height
    }

    /// Weight in hectograms (API standard).
    var weight: Int {
        pokemon.weight
    }

    /// Domain-level error representing business rules.
    enum PokemonDetailBusinessRuleError: Error {
        case glitchedPokemon
    }
}
