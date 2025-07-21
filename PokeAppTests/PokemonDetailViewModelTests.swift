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
    func testLoadDetailSuccessUpdatesEntity()  {
        // Arrange
        let mockInfrastructure = PokemonDetailInfrastructureMock()
        let dataSource = PokemonDetailDataSourceImp(infrastructure: mockInfrastructure)
        let repository = PokemonDetailRepositoryImp(dataSource: dataSource)
        let useCase = GetPokemonDetailUseCase(repository: repository)
        let viewModel = PokemonDetailViewModel(useCase: useCase)

        // Act
        viewModel.loadDetail(id: 25)

        // Assert (en MainActor por @Published)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(viewModel.entity.id, 25)
            XCTAssertEqual(viewModel.entity.name, "pikachu")
            XCTAssertNil(viewModel.errorMessage)
        }
    }
}
