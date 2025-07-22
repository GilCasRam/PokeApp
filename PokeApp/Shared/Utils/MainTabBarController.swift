//
//  MainTabBarController.swift
//  PokeApp
//
//  Created by Gil Alfredo Casimiro Ramírez on 17/07/25.
//

import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()

        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white
        appearance.stackedLayoutAppearance.selected.iconColor = .red
        appearance.stackedLayoutAppearance.normal.iconColor = .lightGray

        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }

    /// Configures the main tabs for the app using a `UITabBarController`.
    /// Sets up two sections: Pokémon list and Favorites.
    private func setupTabs() {
        // Creates the first tab: Pokémon list inside a navigation controller.
        let listVC = UINavigationController(rootViewController: PokemonListViewController())
        listVC.tabBarItem = UITabBarItem(
            title: "Pokémon",                            // Tab title
            image: UIImage(systemName: "circle.circle.fill"), // Tab icon
            tag: 0                                       // Tab index
        )

        // Creates the second tab: Favorites view inside a navigation controller.
        let favoritesVC = UINavigationController(rootViewController: FavoritesViewController())
        favoritesVC.tabBarItem = UITabBarItem(
            title: "Favoritos",
            image: UIImage(systemName: "heart"),
            tag: 1
        )

        // Assigns the created view controllers to the tab bar.
        viewControllers = [listVC, favoritesVC]
    }

}
