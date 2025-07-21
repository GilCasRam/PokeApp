//
//  UserInfrastructureMock.swift
//  PokeApp
//
//  Created by Gil CasRam on 21/07/25.
//

import Foundation

final class PokemonInfrastructureMock: PokemonInfrastructureProtocol {
    func getPokemonList(limit: Int, offset: Int) async -> Result<[PokemonModel], PokemonError> {
        let result: Result<PokemonListResponse, MockDataErrors> = Bundle.main.getMockData(from: "PokemonListMock")

        switch result {
        case .success(let response):
            let models = response.results.compactMap { item -> PokemonModel? in
                guard let id = Int(item.url.trimmingCharacters(
                    in: CharacterSet(charactersIn: "/")).components(separatedBy: "/").last ?? "") else {
                    return nil
                }
                return PokemonModel(id: id, name: item.name.capitalized, url: item.url)
            }
            return .success(models)
        case .failure(let error):
            print("Error: \(error)")
            return .failure(.generic)
        }
    }
}
