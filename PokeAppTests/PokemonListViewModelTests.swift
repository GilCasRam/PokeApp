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
    func testFetchPokemonsReturnsSuccess() {
        // Arrange
        let expectation = XCTestExpectation(description: "Pokemons loaded")
        let infrastructure = PokemonInfrastructureMock()
        let dataSource = PokemonDataSourceImp(infrastructure: infrastructure)
        let repository = PokemonRepositoryImp(dataSource: dataSource)
        let useCase = GetPokemonListUseCase(repository: repository)
        let viewModel = PokemonListViewModel(useCase: useCase)

        // Act
        viewModel.loadPokemons()

        // Assert
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertFalse(viewModel.pokemons.isEmpty, "Expected pokemons to be loaded")
            XCTAssertNil(viewModel.errorMessage, "Expected no error message")
            expectation.fulfill()
        }
    }
}
