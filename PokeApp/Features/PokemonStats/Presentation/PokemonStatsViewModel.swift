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

    var stats: [(name: String, value: Int)] {
        pokemon.raw.stats.map { ($0.stat.name.capitalized, $0.baseStat) }
    }

    var types: [String] {
        pokemon.raw.types.map { $0.type.name.capitalized }
    }

    var abilities: [String] {
        pokemon.raw.abilities.map { $0.ability.name.capitalized }
    }

    var name: String {
        pokemon.name
    }

    var id: Int {
        pokemon.id
    }

    var imageUrl: String? {
        pokemon.imageUrl
    }
}
