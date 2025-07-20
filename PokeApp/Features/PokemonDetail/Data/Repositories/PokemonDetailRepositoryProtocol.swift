protocol PokemonDetailRepositoryProtocol {
    func getPokemonDetail(id: Int) async -> Result<PokemonDetailEntity, PokemonDetailError>
}