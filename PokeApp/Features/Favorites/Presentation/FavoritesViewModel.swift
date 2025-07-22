//
//  FavoritesViewModel.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 17/07/25.
//

import Foundation

@MainActor
final class FavoritesViewModel: ObservableObject {
    @Published var pokemons: [PokemonBusinessEntity] = []
    /// Loads all favorited Pokémon from Core Data and maps them into business entities.
    /// Used to populate the favorites screen in the app.
    func loadFavorites() {
        // Retrieves all saved Pokémon entries from local storage (Core Data).
        let saved = PokemonFavoritesManager.shared.getAll()

        // Maps each Core Data object (`PokeApp`) into a business entity.
        // If any field is missing (e.g. name), provides a default fallback.
        self.pokemons = saved.map {
            PokemonBusinessEntity(
                pokemon: PokemonModel(
                    id: Int($0.id),
                    name: $0.name ?? "",
                    url: ""
                )
            )
        }
    }
    /// Loads favorited Pokémon from Core Data and decrypts their fields before displaying.
    /// Used to populate the favorites list with readable and secure data.
    func loadFavoritesDecryp() {
        // Retrieves all stored favorite Pokémon entities.
        let saved = PokemonFavoritesManager.shared.getAll()

        // Maps each encrypted Core Data object (`PokeApp`) into a decrypted business entity.
        self.pokemons = saved.map {
            // Decrypts the name and capitalizes it for display.
            let decryptedName = CryptoHelper.decrypt($0.name ?? "").capitalized
            // Decrypts the image URL for use in UI.
            let decryptedImageUrl = CryptoHelper.decrypt($0.imageUrl ?? "")
            // Wraps the decrypted values into a business entity for presentation.
            return PokemonBusinessEntity(pokemon: PokemonModel(
                id: Int($0.id),
                name: decryptedName,
                url: decryptedImageUrl
            ))
        }
    }
}
