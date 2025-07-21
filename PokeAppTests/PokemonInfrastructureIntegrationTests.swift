//
//  PokemonInfrastructureIntegrationTests.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 20/07/25.
//

import XCTest
@testable import PokeApp

final class PokemonInfrastructureIntegrationTests: XCTestCase {

    func testFetchPokemonListFromMock() async throws {
        // Arrange
        let mockInfrastructure = PokemonInfrastructureMock()

        // Act
        let result = await mockInfrastructure.getPokemonList(limit: 10, offset: 0)

        // Assert
        switch result {
        case .success(let models):
            XCTAssertFalse(models.isEmpty, "Expected at least one Pokémon")
            XCTAssertNotNil(models.first?.name, "First Pokémon should have a name")
        case .failure(let error):
            XCTFail("Mock call failed with error: \(error.localizedDescription)")
        }
    }
}
