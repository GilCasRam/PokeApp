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

    /// Retrieves Pokémon detail data, maps it into a business entity, and handles potential errors.
    /// This function orchestrates the flow between the data source and the domain layer.
    func getPokemonDetail(id: Int) async -> Result<PokemonDetailBusinessEntity, PokemonDetailError> {
        // Calls the data source to fetch the Pokémon detail model (DTO) asynchronously.
        let result = await dataSource.fetchPokemonDetail(id: id)

        // Tries to extract the value from the Result.
        // If it fails (e.g., due to a network or decoding error), returns a generic failure.
        guard let dto = try? result.get() else {
            return .failure(.generic)
        }

        do {
            // Attempts to map the DTO to a domain/business entity using the mapper.
            // If mapping is successful, returns the entity as a success case.
            let entity = try mapper.map(dto: dto)
            return .success(entity)
        } catch let error as PokemonDetailError {
            // If the mapper throws a specific `PokemonDetailError`, return it as-is.
            return .failure(error)
        } catch {
            // If another unexpected error occurs, return a generic failure.
            return .failure(.generic)
        }
    }
}
