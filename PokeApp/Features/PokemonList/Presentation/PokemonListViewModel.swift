//
//  PokemonListViewModel.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 16/07/25.
//

import Foundation

@MainActor
final class PokemonListViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var pokemons: [PokemonBusinessEntity] = []
    @Published var limit: Int = 20
    @Published var offset: Int = 0
    @Published var isLoading = false
    var useCase: GetPokemonListProtocol
    init(useCase: GetPokemonListProtocol = PokemonFactory.useCase()) {
        self.useCase = useCase
    }
    /// Loads a list of Pokémon using the current pagination values.
    /// Prevents duplicate loading and handles both initial and paginated states.
    func loadPokemons() {
        // Avoid triggering multiple loads simultaneously.
        guard !isLoading else { return }

        // Set the loading flag so the UI can display a spinner.
        isLoading = true

        // Launch an asynchronous task to execute the use case.
        Task {
            let result = await useCase.execute(limit: limit, offset: offset)

            switch result {
            case .success(let list):
                if offset == 0 {
                    // If offset is 0, it's the initial load — replace the list.
                    self.pokemons = list
                } else {
                    // If offset > 0, it's a paginated load — append to existing list.
                    self.pokemons += list
                }

            case .failure(let error):
                // Handle and display any error that occurred during fetching.
                self.errorMessage = error.localizedDescription
            }

            // Reset the loading flag after the task finishes.
            isLoading = false
        }
    }

}
