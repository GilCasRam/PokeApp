//
//  PokemonListRepositoryImpl.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 16/07/25.
//

import Foundation

final class PokemonRepositoryImp: PokemonRepositoryProtocol {
    private let dataSource: PokemonDataSourceProtocol
    private let mapper: PokemonMapper

    init(dataSource: PokemonDataSourceProtocol, mapper: PokemonMapper = PokemonMapper()) {
        self.dataSource = dataSource
        self.mapper = mapper
    }

    func getPokemonList(limit: Int, offset: Int) async -> Result<[PokemonBusinessEntity], PokemonError> {
        let dataSourceResult = await dataSource.fetchPokemonList(limit: limit, offset: offset)
        guard let result = try? dataSourceResult.get() else {
            return .failure(.generic)
        }

        do {
            let entities = try mapper.map(dtoList: result)
            return .success(entities)
        } catch let error as PokemonError {
            return .failure(error)
        } catch {
            return .failure(.generic)
        }
    }
}
