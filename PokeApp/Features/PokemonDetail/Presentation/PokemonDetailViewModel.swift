//
//  PokemonDetailViewModel.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 17/07/25.
//

import Foundation
import UIKit

@MainActor
final class PokemonDetailViewModel: ObservableObject {
    private var currentPokemonId: Int?
    // MARK: - Dependencies
    private let useCase: GetPokemonDetailProtocol

    // MARK: - State
    @Published var errorMessage: String?
    @Published var entity = PokemonDetailBusinessEntity()
    @Published var isLoading: Bool = false
    @Published var isFavorite: Bool = false
    @Published var isDetailLoaded: Bool = false

    // MARK: - Init
    init(useCase: GetPokemonDetailProtocol = PokemonDetailFactory.useCase()) {
        self.useCase = useCase
    }

    // MARK: - Public Methods
    /// Loads the Pokémon detail using the given ID.
    /// Updates the ViewModel's state based on the result of the use case execution.
    func loadDetail(id: Int) {
        // Store the current Pokémon ID for reference (e.g., for retry or other operations).
        currentPokemonId = id

        // Starts an asynchronous task in the ViewModel context.
        Task {
            // Sets the loading flag to true so the UI can show a spinner or loading indicator.
            isLoading = true

            // Executes the use case to fetch Pokémon details.
            let result = await useCase.execute(id: id)

            // Handles the result of the async call.
            switch result {
            case .success(let detail):
                // If successful, update the domain entity used in the UI.
                self.entity = detail

                // Check if this Pokémon is marked as favorite and update the state accordingly.
                self.isFavorite = PokemonFavoritesManager.shared.isFavorite(id: detail.id)

                // Clear any previous error message and mark the detail as loaded.
                self.errorMessage = nil
                self.isDetailLoaded = true

            case .failure(let error):
                // If the request fails, set the error message to be displayed in the UI.
                self.errorMessage = error.localizedDescription
            }

            // Marks the end of the loading state.
            isLoading = false
        }
    }

    /// Toggles the favorite status of the current Pokémon.
    /// Adds or removes it from persistent storage and updates the local UI state.
    func toggleFavorite() {
        let id = entity.id

        if isFavorite {
            // If it's already a favorite, remove it from local storage.
            PokemonFavoritesManager.shared.remove(by: id)
        } else {
            // If it's not a favorite, wrap it in a business entity and save it.
            let pokemon = PokemonBusinessEntity(pokemon: entity.pokemonRaw)
            PokemonFavoritesManager.shared.add(pokemon: pokemon)
        }

        // Flip the local favorite state so the UI can update immediately.
        isFavorite.toggle()

        // Trigger haptic feedback to enhance user experience.
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()

        // Notify other parts of the app (e.g. favorites list) that the favorite status has changed.
        NotificationCenter.default.post(name: .favoriteStatusChanged, object: nil)
    }
    /// Retries loading the Pokémon detail using the last known Pokémon ID.
    /// Useful after a failed request or when the user taps a "Try Again" button.
    func retry() {
        // Ensures there's a valid ID to retry with.
        guard let id = currentPokemonId else { return }

        // Calls the same method used for the initial load.
        loadDetail(id: id)
    }
}

/// Defines a custom notification used to broadcast when a Pokémon's favorite status has changed.
/// This helps keep different parts of the app in sync (e.g., list and detail views).
extension Notification.Name {
    static let favoriteStatusChanged = Notification.Name("favoriteStatusChanged")
}
