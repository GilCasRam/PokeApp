import Foundation

final class GetPokemonDetailUseCase: GetPokemonDetailProtocol {
    private let repository: PokemonDetailRepositoryProtocol

    init(repository: PokemonDetailRepositoryProtocol) {
        self.repository = repository
    }

    func execute(id: Int) async -> Result<PokemonDetailBusinessEntity, PokemonDetailError> {
        return await repository.getPokemonDetail(id: id)
    }
}