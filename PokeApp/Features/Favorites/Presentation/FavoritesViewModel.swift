import Foundation

@MainActor
final class FavoritesViewModel: ObservableObject {
    @Published var pokemons: [PokemonBusinessEntity] = []

    func loadFavorites() {
        let saved = PokemonFavoritesManager.shared.getAll()
        self.pokemons = saved.map {
            PokemonBusinessEntity(pokemon: PokemonModel(id: Int($0.id), name: $0.name ?? "", url: ""))
        }
    }
}