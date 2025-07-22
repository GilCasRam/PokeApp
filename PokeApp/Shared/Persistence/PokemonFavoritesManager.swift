//
//  PokemonFavoritesManager.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 17/07/25.
//

import CoreData
import UIKit

final class PokemonFavoritesManager {

    static let shared = PokemonFavoritesManager()
    let context = UIApplication.context

    // MARK: - Add
    /// Adds a new Pokémon to local storage if it's not already saved.
    /// Encrypts sensitive fields before saving for extra security.
    /// - Parameter pokemon: The business entity to be saved as a favorite.
    func add(pokemon: PokemonBusinessEntity) {
        // Checks if the Pokémon is already stored to avoid duplicates.
        guard fetch(by: pokemon.id) == nil else { return }

        // Creates a new Core Data object for the PokeApp entity.
        let entity = PokeApp(context: context)

        // Maps and encrypts the necessary properties before saving.
        entity.id = Int64(pokemon.id)
        entity.name = CryptoHelper.encrypt(pokemon.name)
        entity.imageUrl = CryptoHelper.encrypt(pokemon.imageUrl)

        // Persists the changes to Core Data.
        saveContext()
    }

    // MARK: - Remove
    /// Removes a Pokémon from local storage by its ID, if it exists.
    /// - Parameter id: The ID of the Pokémon to be removed.
    func remove(by id: Int) {
        // Attempts to fetch the existing record with the given ID.
        if let existing = fetch(by: id) {
            // If found, deletes the object from the context.
            context.delete(existing)

            // Saves the changes to persist the deletion in Core Data.
            saveContext()
        }
    }

    // MARK: - Check if exists
    /// Checks whether a Pokémon with the given ID is already saved as a favorite.
    /// - Parameter id: The Pokémon's unique identifier.
    /// - Returns: `true` if the Pokémon exists in local storage; otherwise, `false`.
    func isFavorite(id: Int) -> Bool {
        return fetch(by: id) != nil
    }

    // MARK: - Get all favorites
    /// Retrieves all saved Pokémon favorites from Core Data.
    /// - Returns: An array of `PokeApp` entities, or an empty array if the fetch fails.
    func getAll() -> [PokeApp] {
        // Creates a fetch request for the PokeApp entity.
        let request: NSFetchRequest<PokeApp> = PokeApp.fetchRequest()

        // Attempts to execute the fetch and return the results.
        // If an error occurs, returns an empty array as a fallback.
        return (try? context.fetch(request)) ?? []
    }

    // MARK: - Private Helpers
    /// Fetches a single `PokeApp` entity from Core Data by its ID.
    /// - Parameter id: The unique identifier of the Pokémon.
    /// - Returns: The matching `PokeApp` object if found, otherwise `nil`.
    private func fetch(by id: Int) -> PokeApp? {
        // Creates a fetch request for the PokeApp entity.
        let request: NSFetchRequest<PokeApp> = PokeApp.fetchRequest()
        // Adds a predicate to filter the results by the given ID.
        request.predicate = NSPredicate(format: "id == %d", id)
        // Attempts to execute the fetch and return the first matching result.
        // If the fetch fails or no match is found, returns nil.
        return try? context.fetch(request).first
    }

    /// Saves any pending changes in the Core Data context to the persistent store.
    /// Used after adding or removing Pokémon favorites.
    private func saveContext() {
        do {
            // Attempts to persist the current context changes.
            try context.save()
        } catch {
            // If the save fails, logs the error for debugging purposes.
            print("Failed to save favorite: \(error.localizedDescription)")
        }
    }
}

extension UIApplication {
    /// Provides access to the Core Data context used for saving and fetching entities.
    /// This assumes the app uses the default `AppDelegate` setup with `persistentContainer`.
    static var context: NSManagedObjectContext {
        // Attempts to retrieve the AppDelegate instance and cast it properly.
        guard let delegate = shared.delegate as? AppDelegate else {
            // If the cast fails, crashes the app — this is a critical failure during development.
            fatalError("No se pudo obtener AppDelegate")
        }

        // Returns the main view context used for Core Data operations.
        return delegate.persistentContainer.viewContext
    }
}
