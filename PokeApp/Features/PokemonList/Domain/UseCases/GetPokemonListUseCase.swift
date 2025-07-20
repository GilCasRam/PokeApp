protocol GetPokemonListUseCase {
    func execute(limit: Int) async throws -> [PokemonSummary]
}