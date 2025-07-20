protocol PokemonDetailDataSourceProtocol {
    func fetchPokemonDetail(id: Int) async -> Result<PokemonDetailModel, PokemonDetailError>
}