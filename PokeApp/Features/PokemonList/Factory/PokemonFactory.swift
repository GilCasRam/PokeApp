//
//  PokemonFactory.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 17/07/25.
//

import Foundation

struct PokemonFactory {
    static func infrastructure() -> PokemonInfrastructureProtocol {
        // change implementation between real or mock
//        return PokemonInfrastructureMock()
        return PokemonInfrastructureImp()
    }
    static func dataSource() -> PokemonDataSourceProtocol {
        return PokemonDataSourceImp(infrastructure: infrastructure())
    }
    static func repository() -> PokemonRepositoryProtocol {
        return PokemonRepositoryImp(dataSource: dataSource())
    }
    static func useCase() -> GetPokemonListProtocol {
        return GetPokemonListUseCase(repository: repository())
    }
}
