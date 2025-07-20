import CoreData
import UIKit

final class PokemonFavoritesManager {

    static let shared = PokemonFavoritesManager()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    // MARK: - Add
    func add(pokemon: PokemonBusinessEntity) {
        let entity = PokeApp(context: context)
        entity.id = Int64(pokemon.id)
        entity.name = pokemon.name
        entity.imageUrl = pokemon.rawPokemon.imageUrl

        saveContext()
    }

    // MARK: - Remove
    func remove(by id: Int) {
        if let existing = fetch(by: id) {
            context.delete(existing)
            saveContext()
        }
    }

    // MARK: - Check if exists
    func isFavorite(id: Int) -> Bool {
        return fetch(by: id) != nil
    }

    // MARK: - Get all favorites
    func getAll() -> [PokeApp] {
        let request: NSFetchRequest<PokeApp> = PokeApp.fetchRequest()
        return (try? context.fetch(request)) ?? []
    }

    // MARK: - Private Helpers
    private func fetch(by id: Int) -> PokeApp? {
        let request: NSFetchRequest<PokeApp> = PokeApp.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        return try? context.fetch(request).first
    }

    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("❌ Failed to save favorite: \(error.localizedDescription)")
        }
    }
}