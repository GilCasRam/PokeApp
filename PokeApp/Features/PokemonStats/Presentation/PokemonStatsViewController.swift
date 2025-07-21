//
//  PokemonStatsViewController.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 17/07/25.
//

import UIKit
import SwiftUI

final class PokemonStatsViewController: UIViewController {

    private let pokemon: PokemonBusinessEntity
    private let pokemonDetail: PokemonDetailBusinessEntity
    
    init(pokemon: PokemonBusinessEntity, pokemonDetail: PokemonDetailBusinessEntity) {
        self.pokemon = pokemon
        self.pokemonDetail = pokemonDetail
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHostingView()
    }

    private func setupHostingView() {
        let viewModel = PokemonStatsViewModel(pokemon: pokemonDetail)
        let statsView = PokemonStatsView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: statsView)

        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        hostingController.didMove(toParent: self)
    }
}
