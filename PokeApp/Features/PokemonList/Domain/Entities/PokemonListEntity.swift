import Foundation

final class PokemonListEntity {

    private var id: Int
    private var name: String
    private var url: String

    init(id: Int = 0, name: String = "", url: String = "") {
        self.id = id
        self.name = name
        self.url = url
    }

    func setId(_ id: Int) {
        self.id = id
    }

    func getId() -> Int {
        return id
    }

    func setName(_ name: String) {
        self.name = name
    }

    func getName() -> String {
        return name
    }

    func setUrl(_ url: String) {
        self.url = url
    }

    func getUrl() -> String {
        return url
    }
}