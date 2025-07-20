import Foundation

@MainActor
final class PokemonListViewModel {
    
    // MARK: - State
    private(set) var pokemons: [PokemonModel] = []
    private(set) var isLoading: Bool = false
    private(set) var errorMessage: String?

    // MARK: - Callback
    var onStateChange: (() -> Void)?

    // MARK: - Dependencies
    private let getPokemonListUseCase: GetPokemonListUseCase

    init(getPokemonListUseCase: GetPokemonListUseCase = PokemonListRepositoryImpl()) {
        self.getPokemonListUseCase = getPokemonListUseCase
    }

    func fetchPokemons(limit: Int = 20) {
        Task {
            isLoading = true
            errorMessage = nil
            onStateChange?()

            do {
                self.pokemons = try await getPokemonListUseCase.execute(limit: limit)
            } catch {
                self.errorMessage = error.localizedDescription
            }

            isLoading = false
            onStateChange?()
        }
    }
}