protocol PokemonDetailInfrastructureProtocol {
    func getPokemonDetail(id: Int) async -> Result<PokemonDetailModel, PokemonDetailError>
}