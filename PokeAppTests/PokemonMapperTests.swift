//
//  PokemonMapperTests.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 20/07/25.
//

import XCTest
@testable import PokeApp

final class PokemonMapperTests: XCTestCase {
    
    func testMapPokemonModelToBusinessEntity() throws {
        // Arrange
        let model = PokemonModel(id: 25, name: "pikachu", url: "https://pokeapi.co/api/v2/pokemon/25/")
        let mapper = PokemonMapper()
        
        // Act
        let entity = try mapper.map(dto: model)
        
        // Assert
        XCTAssertEqual(entity.id, 25)
        XCTAssertEqual(entity.name, "pikachu")
    }
}
