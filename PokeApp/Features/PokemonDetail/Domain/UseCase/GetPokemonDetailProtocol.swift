import Foundation

protocol GetPokemonDetailProtocol {
    func execute(id: Int) async -> Result<PokemonDetailBusinessEntity, PokemonDetailError>
}