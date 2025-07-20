import Foundation

struct PokemonDetailFactory {
    
    static func infrastructure() -> PokemonDetailInfrastructureProtocol {
        PokemonDetailInfrastructureImp()
    }

    static func dataSource() -> PokemonDetailDataSourceProtocol {
        PokemonDetailDataSourceImp(infrastructure: infrastructure())
    }

    static func repository() -> PokemonDetailRepositoryProtocol {
        PokemonDetailRepositoryImp(dataSource: dataSource())
    }

    static func useCase() -> GetPokemonDetailProtocol {
        GetPokemonDetailUseCase(repository: repository())
    }
}