//
//  PokemonDetailMapperTests.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 20/07/25.
//

import XCTest
@testable import PokeApp

final class PokemonDetailMapperTests: XCTestCase {

    func testMapPokemonDetailModelToBusinessEntity() throws {
        // Arrange
        let model = PokemonDetailModel(
            id: 25,
            name: "pikachu",
            height: 4,
            weight: 60,
            sprites: Sprites(frontDefault: "https://pokeapi.co/api/v2/sprites/pokemon/25.png"),
            types: [
                PokemonTypeSlot(slot: 1, type: NamedAPIResource(name: "electric", url: "https://pokeapi.co/api/v2/type/13/"))
            ],
            stats: [
                PokemonStat(baseStat: 35, stat: NamedAPIResource(name: "hp", url: "https://pokeapi.co/api/v2/stat/1/")),
                PokemonStat(baseStat: 55, stat: NamedAPIResource(name: "attack", url: "https://pokeapi.co/api/v2/stat/2/"))
            ],
            abilities: [
                PokemonAbilitySlot(ability: NamedAPIResource(name: "static", url: "https://pokeapi.co/api/v2/ability/9/"), isHidden: false)
            ]
        )

        let mapper = PokemonDetailMapper()

        // Act
        let entity = try mapper.map(dto: model)

        // Assert
        XCTAssertEqual(entity.id, 25)
        XCTAssertEqual(entity.name, "Pikachu") 
        XCTAssertEqual(entity.types, ["Electric"])
        XCTAssertEqual(entity.abilities, ["Static"])
        XCTAssertEqual(entity.stats.count, 2)
        XCTAssertEqual(entity.imageUrl, "https://pokeapi.co/api/v2/sprites/pokemon/25.png")
    }
}
