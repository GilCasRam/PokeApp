protocol PokemonDataSourceProtocol {
    func fetchPokemonList(limit: Int) async -> Result<[PokemonModel], PokemonError>
}