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
    func loadPokemons() {
        guard !isLoading else { return }
        isLoading = true
        Task {
            let result = await useCase.execute(limit: limit, offset: offset)
            switch result {
            case .success(let list):
                if offset == 0 {
                    self.pokemons = list
                } else {
                    self.pokemons += list
                }
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
}
