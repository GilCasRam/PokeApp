//
//  PokemonDetailInfrastructureMock.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 20/07/25.
//

import Foundation
import XCTest
@testable import PokeApp

final class PokemonDetailInfrastructureMock: PokemonDetailInfrastructureProtocol {
    
    /// Simulates a successful API response by returning a hardcoded `PokemonDetailModel`.
    /// This is used in mock infrastructure during unit tests or SwiftUI previews.
    /// - Parameter id: The ID to assign to the mock Pokémon.
    /// - Returns: A `Result` containing a `PokemonDetailModel` with realistic data.
    func getPokemonDetail(id: Int) async -> Result<PokemonDetailModel, PokemonDetailError> {
        
        // Creates a hardcoded mock detail model for a Pokémon (Pikachu).
        let mockDetail = PokemonDetailModel(
            id: id,
            name: "pikachu",
            height: 4,
            weight: 60,
            sprites: Sprites(
                frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png"
            ),
            types: [
                PokemonTypeSlot(
                    slot: 1,
                    type: NamedAPIResource(name: "electric", url: "https://pokeapi.co/api/v2/type/13/")
                )
            ],
            stats: [
                PokemonStat(
                    baseStat: 35,
                    stat: NamedAPIResource(name: "hp", url: "https://pokeapi.co/api/v2/stat/1/")
                ),
                PokemonStat(
                    baseStat: 55,
                    stat: NamedAPIResource(name: "attack", url: "https://pokeapi.co/api/v2/stat/2/")
                )
            ],
            abilities: [
                PokemonAbilitySlot(
                    ability: NamedAPIResource(name: "static", url: "https://pokeapi.co/api/v2/ability/9/"),
                    isHidden: false
                ),
                PokemonAbilitySlot(
                    ability: NamedAPIResource(name: "lightning-rod", url: "https://pokeapi.co/api/v2/ability/31/"),
                    isHidden: true
                )
            ]
        )

        // Returns the mock detail wrapped in a success result.
        return .success(mockDetail)
    }
}
