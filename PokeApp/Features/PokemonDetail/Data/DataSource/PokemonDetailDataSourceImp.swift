final class PokemonDetailDataSourceImp: PokemonDetailDataSourceProtocol {
    private let infrastructure: PokemonDetailInfrastructureProtocol

    init(infrastructure: PokemonDetailInfrastructureProtocol) {
        self.infrastructure = infrastructure
    }

    func fetchPokemonDetail(id: Int) async -> Result<PokemonDetailModel, PokemonDetailError> {
        return await infrastructure.getPokemonDetail(id: id)
    }
}