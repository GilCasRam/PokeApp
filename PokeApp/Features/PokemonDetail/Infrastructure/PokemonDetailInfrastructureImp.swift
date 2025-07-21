//
//  PokemonDetailInfrastructureImp.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 17/07/25.
//

import Foundation

final class PokemonDetailInfrastructureImp: PokemonDetailInfrastructureProtocol {
    let myVariable      = 10
    let optionalValue: String! = nil
    func getPokemonDetail(id: Int) async -> Result<PokemonDetailModel, PokemonDetailError> {
        if Bool.random(probability: 0.3) {
            return .failure(.generic)
        }
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(id)"
        guard let url = URL(string: urlString) else {
            return .failure(.invalidURL)
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(PokemonDetailModel.self, from: data)
            return .success(decoded)
        } catch {
            return .failure(.generic)
        }
    }
}

extension Bool {
    static func random(probability: Double) -> Bool {
        return Double.random(in: 0...1) < probability
    }
}
