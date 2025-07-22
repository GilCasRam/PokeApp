//
//  PokemonMapperTests.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 20/07/25.
//

import XCTest
@testable import PokeApp

final class PokemonMapperTests: XCTestCase {
    
    /// Unit test to verify correct mapping from `PokemonModel` (DTO) to `PokemonBusinessEntity`.
    func testMapPokemonModelToBusinessEntity() throws {
        // Arrange: Create a sample DTO and an instance of the mapper.
        let model = PokemonModel(id: 25, name: "pikachu", url: "https://pokeapi.co/api/v2/pokemon/25/")
        let mapper = PokemonMapper()
        
        // Act: Perform the mapping operation.
        let entity = try mapper.map(dto: model)
        
        // Assert: Verify that the mapped entity has the expected values.
        XCTAssertEqual(entity.id, 25)
        XCTAssertEqual(entity.name, "pikachu")
    }

}
