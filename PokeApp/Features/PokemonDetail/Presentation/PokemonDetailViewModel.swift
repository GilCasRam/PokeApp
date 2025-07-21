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
    func loadDetail(id: Int) {
        currentPokemonId = id
        Task {
            isLoading = true
            let result = await useCase.execute(id: id)
            switch result {
            case .success(let detail):
                self.entity = detail
                self.isFavorite = PokemonFavoritesManager.shared.isFavorite(id: detail.id)
                self.errorMessage = nil
                self.isDetailLoaded = true
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
    func toggleFavorite() {
        let id = entity.id
        if isFavorite {
            PokemonFavoritesManager.shared.remove(by: id)
        } else {
            let pokemon = PokemonBusinessEntity(pokemon: entity.pokemonRaw)
            PokemonFavoritesManager.shared.add(pokemon: pokemon)
        }
        isFavorite.toggle()
        // Haptic Feedback
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        NotificationCenter.default.post(name: .favoriteStatusChanged, object: nil)
    }
    func retry() {
        guard let id = currentPokemonId else { return }
        loadDetail(id: id)
    }
}

extension Notification.Name {
    static let favoriteStatusChanged = Notification.Name("favoriteStatusChanged")
}
