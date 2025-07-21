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

    func testPokemonListAppears() {
        // Verifica que la CollectionView aparece (usa el identificador correcto)
        let collectionView = app.collectionViews["PokemonListCollectionView"]

        let exists = collectionView.waitForExistence(timeout: 5)
        XCTAssertTrue(exists, "❌ No se encontró la lista de Pokémon en la pantalla principal.")
        print("✅ La lista de Pokémon aparece correctamente.")
    }
    
    func testNavigateToPokemonDetail() {
        // Busca la celda del primer Pokémon visible
        let firstCell = app.collectionViews.cells.element(boundBy: 0)

        // Espera a que aparezca
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5), "❌ No se encontró la primera celda de Pokémon.")

        // Toca la celda
        firstCell.tap()

        // Verifica que se haya mostrado la vista de detalles
        let detailLabel = app.staticTexts["PokemonDetailTitle"]
        let exists = detailLabel.waitForExistence(timeout: 5)

        XCTAssertTrue(exists, "❌ No se cargó la vista de detalles al tocar un Pokémon.")
        print("✅ Se navegó correctamente a la vista de detalles.")
    }
}
