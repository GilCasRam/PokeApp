//
//  PokemonListServiceProtocol.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 16/07/25.
//

import Foundation

protocol PokemonInfrastructureProtocol {
    func getPokemonList(limit: Int, offset: Int) async -> Result<[PokemonModel], PokemonError>
}

final class PokemonInfrastructureImp: PokemonInfrastructureProtocol {

    func getPokemonList(limit: Int, offset: Int) async -> Result<[PokemonModel], PokemonError> {
        let urlString = "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)"
        
        guard let url = URL(string: urlString) else {
            return .failure(.invalidURL)
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(PokemonListResponse.self, from: data)

            let models: [PokemonModel] = decoded.results.enumerated().map { index, item in
                let id = Int(item.url.split(separator: "/").last ?? "\(index)") ?? index
                return PokemonModel(id: id, name: item.name.capitalized, url: item.url)
            }

            return .success(models)
        } catch {
            return .failure(.generic)
        }
    }
}
