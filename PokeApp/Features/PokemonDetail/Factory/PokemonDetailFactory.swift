//
//  PokemonDetailFactory.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 17/07/25.
//

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
