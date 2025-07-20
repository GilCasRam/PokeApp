final class PokemonListRepositoryImpl: GetPokemonListUseCase {
    private let service: PokemonListServiceProtocol

    init(service: PokemonListServiceProtocol = PokemonListService()) {
        self.service = service
    }

    func execute(limit: Int) async throws -> [PokemonSummary] {
        return try await service.fetchPokemonList(limit: limit)
    }
}