import Foundation

protocol GetPokemonListProtocol {
    func execute(limit: Int, offset: Int) async -> Result<[PokemonBusinessEntity], PokemonError>
}