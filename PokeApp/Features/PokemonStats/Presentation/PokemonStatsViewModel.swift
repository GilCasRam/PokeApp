//
//  PokemonStatsViewModel.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 17/07/25.
//

import Foundation

final class PokemonStatsViewModel: ObservableObject {
    let pokemon: PokemonDetailBusinessEntity

    init(pokemon: PokemonDetailBusinessEntity) {
        self.pokemon = pokemon
    }

    /// Returns a list of Pokémon stats formatted as (name, value) tuples.
    /// Example: [("HP", 45), ("Attack", 60), ...]
    var stats: [(name: String, value: Int)] {
        pokemon.raw.stats.map { ($0.stat.name.capitalized, $0.baseStat) }
    }

    /// Returns a list of the Pokémon's type names, capitalized for display.
    /// Example: ["Fire", "Flying"]
    var types: [String] {
        pokemon.raw.types.map { $0.type.name.capitalized }
    }

    /// Returns a list of the Pokémon's abilities, also capitalized for presentation.
    /// Example: ["Overgrow", "Chlorophyll"]
    var abilities: [String] {
        pokemon.raw.abilities.map { $0.ability.name.capitalized }
    }

    /// Returns the Pokémon's name as-is (assumed to already be formatted).
    var name: String {
        pokemon.name
    }

    /// Returns the Pokémon's ID.
    var id: Int {
        pokemon.id
    }

    /// Returns the URL to the Pokémon's image, if available.
    var imageUrl: String? {
        pokemon.imageUrl
    }

}
