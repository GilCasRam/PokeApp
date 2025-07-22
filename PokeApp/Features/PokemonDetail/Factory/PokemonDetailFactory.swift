//
//  PokemonDetailFactory.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 17/07/25.
//

import Foundation

/// Factory that builds and wires together all the components related to the Pokémon detail feature.
/// It follows the dependency injection pattern manually, without relying on third-party frameworks.
struct PokemonDetailFactory {

    /// Provides the infrastructure layer instance, which handles API/network calls.
    static func infrastructure() -> PokemonDetailInfrastructureProtocol {
        PokemonDetailInfrastructureImp()
    }

    /// Provides the data source layer, which communicates with the infrastructure.
    static func dataSource() -> PokemonDetailDataSourceProtocol {
        PokemonDetailDataSourceImp(infrastructure: infrastructure())
    }

    /// Provides the repository, which applies business logic and prepares the data for the domain layer.
    static func repository() -> PokemonDetailRepositoryProtocol {
        PokemonDetailRepositoryImp(dataSource: dataSource())
    }

    /// Provides the use case that is called by the ViewModel to trigger the Pokémon detail flow.
    static func useCase() -> GetPokemonDetailProtocol {
        GetPokemonDetailUseCase(repository: repository())
    }
}
