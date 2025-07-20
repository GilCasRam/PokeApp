import Foundation

final class PokemonStatsViewModel: ObservableObject {
    let pokemon: PokemonBusinessEntity

    init(pokemon: PokemonBusinessEntity) {
        self.pokemon = pokemon
    }

    var stats: [(name: String, value: Int)] {
        pokemon.stats
    }

    var types: [String] {
        pokemon.types
    }

    var abilities: [String] {
        pokemon.abilities
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