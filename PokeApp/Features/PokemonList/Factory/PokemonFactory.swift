//
//  PokemonFactory.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 17/07/25.
//

import Foundation

struct PokemonFactory {
    /// Factory methods for constructing the components of the Pokémon list feature.
    /// Useful for switching between production and mock environments during development or testing.
    static func infrastructure() -> PokemonInfrastructureProtocol {
        // Toggle between real or mock implementation by commenting/uncommenting as needed.
        // return PokemonInfrastructureMock() // ← Use this for testing without hitting the real API
        return PokemonInfrastructureImp()     // ← Default production implementation
    }

    /// Creates the data source by injecting the infrastructure layer.
    /// The data source acts as a bridge between infrastructure and repository.
    static func dataSource() -> PokemonDataSourceProtocol {
        return PokemonDataSourceImp(infrastructure: infrastructure())
    }

    /// Creates the repository by injecting the data source.
    /// The repository prepares the data for domain use and handles mapping or error handling.
    static func repository() -> PokemonRepositoryProtocol {
        return PokemonRepositoryImp(dataSource: dataSource())
    }

    /// Provides the use case that the ViewModel will use to load the Pokémon list.
    static func useCase() -> GetPokemonListProtocol {
        return GetPokemonListUseCase(repository: repository())
    }

}
