//
//  PokemonListUITests.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 20/07/25.
//

import XCTest

final class PokemonListUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    /// UI test to verify that the Pokémon list appears on screen within a reasonable time.
    /// Looks for a UICollectionView identified by the accessibility identifier "PokemonListCollectionView".
    func testPokemonListAppears() {
        // Attempts to locate the collection view using its accessibility identifier.
        let collectionView = app.collectionViews["PokemonListCollectionView"]

        // Waits up to 5 seconds for the collection view to appear in the view hierarchy.
        let exists = collectionView.waitForExistence(timeout: 5)

        // Asserts that the collection view exists on screen.
        XCTAssertTrue(exists, "No se encontró la lista de Pokémon en la pantalla principal.")
        print("La lista de Pokémon aparece correctamente.")
    }
    /// UI test to verify that tapping on a Pokémon cell navigates to the detail screen.
    func testNavigateToPokemonDetail() {
        // Attempts to find the first visible Pokémon cell in the collection view.
        let firstCell = app.collectionViews.cells.element(boundBy: 0)

        // Waits for the cell to appear, up to 5 seconds.
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5), "No se encontró la primera celda de Pokémon.")

        // Simulates a user tap on the first cell.
        firstCell.tap()

        // Tries to find a static text element that confirms the detail view is loaded.
        // This element should have the accessibility identifier "PokemonDetailTitle".
        let detailLabel = app.staticTexts["PokemonDetailTitle"]
        let exists = detailLabel.waitForExistence(timeout: 5)

        // Asserts that the detail screen was successfully shown.
        XCTAssertTrue(exists, "No se cargó la vista de detalles al tocar un Pokémon.")
        print("Se navegó correctamente a la vista de detalles.")
    }

}
