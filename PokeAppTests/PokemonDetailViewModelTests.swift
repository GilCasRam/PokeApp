//
//  PokemonDetailViewModelTests.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 20/07/25.
//

import XCTest
@testable import PokeApp

final class PokemonDetailViewModelTests: XCTestCase {
    
    @MainActor
    /// Unit test to verify that the ViewModel correctly loads and updates Pokémon detail
    /// when the use case returns a successful result.
    func testLoadDetailSuccessUpdatesEntity() {
        // Arrange: Set up the entire dependency chain using mock implementations.
        let mockInfrastructure = PokemonDetailInfrastructureMock()
        let dataSource = PokemonDetailDataSourceImp(infrastructure: mockInfrastructure)
        let repository = PokemonDetailRepositoryImp(dataSource: dataSource)
        let useCase = GetPokemonDetailUseCase(repository: repository)
        let viewModel = PokemonDetailViewModel(useCase: useCase)

        // Act: Trigger the loadDetail call on the ViewModel.
        viewModel.loadDetail(id: 25)

        // Assert: Delay assertion to allow async operation to complete.
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // Verify that the entity was populated with the correct data.
            XCTAssertEqual(viewModel.entity.id, 25)
            XCTAssertEqual(viewModel.entity.name, "pikachu")

            // Verify that no error occurred during loading.
            XCTAssertNil(viewModel.errorMessage)
        }
    }
}
