//
//  PokemonDetailMapperTests.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 20/07/25.
//

import XCTest
@testable import PokeApp

final class PokemonDetailMapperTests: XCTestCase {

    /// Unit test to verify the correct mapping from `PokemonDetailModel` to `PokemonDetailBusinessEntity`.
    /// Ensures that fields are transformed and formatted as expected for UI or domain use.
    func testMapPokemonDetailModelToBusinessEntity() throws {
        // Arrange: Create a detailed mock DTO with realistic data.
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

        // Act: Perform the mapping to convert the DTO into a business entity.
        let entity = try mapper.map(dto: model)

        // Assert: Validate that the mapped values match expectations (including formatting).
        XCTAssertEqual(entity.id, 25)
        XCTAssertEqual(entity.name, "Pikachu") // Capitalized in the business entity
        XCTAssertEqual(entity.types, ["Electric"]) // Capitalized and parsed
        XCTAssertEqual(entity.abilities, ["Static"])
        XCTAssertEqual(entity.stats.count, 2)
        XCTAssertEqual(entity.imageUrl, "https://pokeapi.co/api/v2/sprites/pokemon/25.png")
    }
}
