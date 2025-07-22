//
//  PokemonListViewModelTests.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 20/07/25.
//

import XCTest
@testable import PokeApp

final class PokemonListViewModelTests: XCTestCase {

    @MainActor
    /// Unit test to verify that the Pokémon list is successfully loaded and no error is returned.
    /// This test uses mock infrastructure and runs on the main queue with a delay to wait for async completion.
    func testFetchPokemonsReturnsSuccess() {
        // Arrange: Set up the full dependency chain using mock implementations.
        let expectation = XCTestExpectation(description: "Pokemons loaded")
        let infrastructure = PokemonInfrastructureMock()
        let dataSource = PokemonDataSourceImp(infrastructure: infrastructure)
        let repository = PokemonRepositoryImp(dataSource: dataSource)
        let useCase = GetPokemonListUseCase(repository: repository)
        let viewModel = PokemonListViewModel(useCase: useCase)

        // Act: Trigger the Pokémon loading process in the ViewModel.
        viewModel.loadPokemons()

        // Assert: Use a delay to allow async task to complete, then validate results.
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // Verifies that the list was populated successfully.
            XCTAssertFalse(viewModel.pokemons.isEmpty, "Expected pokemons to be loaded")

            // Verifies that no error message was produced.
            XCTAssertNil(viewModel.errorMessage, "Expected no error message")

            // Fulfill the test expectation.
            expectation.fulfill()
        }
    }
}
