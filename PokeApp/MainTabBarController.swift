import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }

    private func setupTabs() {
        let listVC = UINavigationController(rootViewController: PokemonListViewController())
        listVC.tabBarItem = UITabBarItem(title: "Pokémon", image: UIImage(systemName: "list.bullet"), tag: 0)

        let favoritesVC = UINavigationController(rootViewController: FavoritesViewController())
        favoritesVC.tabBarItem = UITabBarItem(title: "Favoritos", image: UIImage(systemName: "heart"), tag: 1)

        viewControllers = [listVC, favoritesVC]
    }
}