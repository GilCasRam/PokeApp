//
//  PokemonDetailRepositoryImp.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 17/07/25.
//


final class PokemonDetailRepositoryImp: PokemonDetailRepositoryProtocol {
    private let dataSource: PokemonDetailDataSourceProtocol
    private let mapper: PokemonDetailMapper

    init(
        dataSource: PokemonDetailDataSourceProtocol,
        mapper: PokemonDetailMapper = PokemonDetailMapper()
    ) {
        self.dataSource = dataSource
        self.mapper = mapper
    }

    func getPokemonDetail(id: Int) async -> Result<PokemonDetailBusinessEntity, PokemonDetailError> {
        let result = await dataSource.fetchPokemonDetail(id: id)

        guard let dto = try? result.get() else {
            return .failure(.generic)
        }

        do {
            let entity = try mapper.map(dto: dto)
            return .success(entity)
        } catch let error as PokemonDetailError {
            return .failure(error)
        } catch {
            return .failure(.generic)
        }
    }
}
