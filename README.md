# PokeApp

🎮 **PokeApp** is an iOS application developed using **UIKit** and **SwiftUI**, allowing users to explore a list of Pokémon using the [PokeAPI](https://pokeapi.co/). It supports features like favorites, error handling, offline mode with Core Data, encryption, and unit/UI testing.

## 🧱 Architecture

The project is built using **Clean Architecture** + **MVVM**, ensuring modularity, separation of concerns, and scalability.

### 🟢 Presentation Layer
- UIKit is used for navigation and base view controllers.
- SwiftUI is embedded via `UIHostingController` for detail views and charts.
- Views are driven by `ViewModel` classes (`ObservableObject`), updated via `@Published` and `Combine`.

### 🔵 Domain Layer
- Contains business entities and use case protocols.
- Defines logic independently of UI or data source.

### 🟠 Data Layer
- Implements services that fetch Pokémon data from API or Core Data.
- Includes mappers, repository and DTOs to transform external data to domain models.

### 🟡 Infrastructure Layer
- Handles real API calls and Core Data integration.
- Contains encryption helper and mock data tools.

## 🔧 Technologies Used

- UIKit + SwiftUI (via bridge)
- Swift Concurrency (`async/await`)
- Combine
- Core Data
- SwiftLint
- Unit Tests (`XCTest`)
- UI Tests (`XCUITest`)
- Mocking with injected protocols
- JSON mocks for integration tests
- Encryption/Decryption for local data

## 🚀 Features

- ✅ Pokémon list with pagination.
- ✅ Detail view with stats, abilities, types.
- ✅ Favorite feature with Core Data persistence.
- ✅ Splash screen with Pokéball animation.
- ✅ Error handling with alerts and retry mechanism.
- ✅ UI Test coverage for navigation.
- ✅ Unit Test coverage for ViewModels, Mappers, Infrastructure.
- ✅ Local encryption of favorites data.
- ✅ SwiftLint with default rules (no custom overrides).

![Demo](Assets/demo.gif)

## 📦 Installation

1️⃣ Clone the repository:
```bash
git clone https://github.com/GilCasRam/PokeApp.git
cd PokeApp
```

2️⃣ Open in Xcode:
- Open `PokeApp.xcodeproj`
- Select a simulator or real device
- Run with `Cmd + R`

3️⃣  Ensure `brew` and `SwiftLint` are installed on your machine. SwiftLint will help enforce style rules.
## 🧪 Testing

### 📍 Unit Tests
Run all tests with:
```bash
Cmd + U
```
Includes:
- ✅ ViewModel tests
- ✅ Mapper tests
- ✅ Infrastructure mock tests
- ✅ Core Data tests

### 📍 UI Tests
```swift
func testNavigateToPokemonDetail() {
    let bulbasaurCell = app.staticTexts["Bulbasaur"]
    XCTAssertTrue(bulbasaurCell.waitForExistence(timeout: 5))
    bulbasaurCell.tap()

    let detailView = app.otherElements["PokemonDetailView"]
    XCTAssertTrue(detailView.waitForExistence(timeout: 5))
}
```

## 📁 Folder Structure

```
PokeApp/
│
├── Features/
│   ├── Favorites
│   ├── PokemonList
│   ├── PokemonDetail
│   └── PokemonStats
│
├── Shared/
│   ├── Persistence/
│   └── Mock/
│
├── Utils/
│   └── CryptoHelper, Assets, Loader
│
├── Mocks/
│   └── PokemonListMock
│
├── AppDelegate, SceneDelegate
```

## 📘 SwiftLint

- Uses default configuration (`.swiftlint.yml`) with opt-in rules like:
  - `force_unwrapping`
  - `unused_declaration`
  - `explicit_init`
- Disabled rules for `line_length`, `todo`, etc.

## 🔐 Extras

- Favorites are stored encrypted using `CryptoHelper`.
- A decrypt button is available in the UI to demonstrate decoding.
- Splash animation uses a pulsating Pokéball effect.

## 🙌 Thank you!

Thank you for reviewing **PokeApp**!  
Feel free to fork, use, or suggest improvements.  
Made by Gil CasRam
