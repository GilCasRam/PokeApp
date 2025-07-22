//
//  PokemonInfrastructureIntegrationTests.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 20/07/25.
//

import XCTest
@testable import PokeApp

final class PokemonInfrastructureIntegrationTests: XCTestCase {

    /// Unit test to verify that the mock infrastructure returns a valid list of Pokémon.
    /// Uses `async/await` and avoids relying on delayed expectations.
    func testFetchPokemonListFromMock() async throws {
        // Arrange: Create the mock infrastructure that simulates a successful API call.
        let mockInfrastructure = PokemonInfrastructureMock()

        // Act: Perform the async call to fetch the Pokémon list.
        let result = await mockInfrastructure.getPokemonList(limit: 10, offset: 0)

        // Assert: Validate the result.
        switch result {
        case .success(let models):
            // Ensure that the returned list is not empty.
            XCTAssertFalse(models.isEmpty, "Expected at least one Pokémon")
            
            // Ensure that the first Pokémon in the list has a name.
            XCTAssertNotNil(models.first?.name, "First Pokémon should have a name")
            
        case .failure(let error):
            // Fail the test if the mock unexpectedly returns an error.
            XCTFail("Mock call failed with error: \(error.localizedDescription)")
        }
    }
}
