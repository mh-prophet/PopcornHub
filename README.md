# PopcornHub 🎬

PopcornHub is a SwiftUI-based iOS application that allows users to discover popular and trending movies with a smooth, modern UI.  
It follows a **Modular MVVM architecture** for scalability and maintainability.

---

## 🚀 Features
- 🎥 Browse popular movies  
- 📄 Detailed movie pages with poster, description, and ratings  
- 🔍 Search movies quickly  
- 💎 Clean, responsive SwiftUI interface  
- 🧩 Modular MVVM architecture for better scalability  

---

## 📂 Folder Structure

<details>
<summary>Click to expand</summary>

```plaintext
📁 PopcornHub/
│
├── 📁 App/                         # Application entry point, assets, and persistence
│   ├── 📝 PopcornHubApp.swift
│   ├── 📁 Assets.xcassets/
│   ├── 📁 PopcornHub.xcdatamodeld/
│   └── 📝 PersistenceController.swift
│
├── 📁 Data/                        # Data layer - API, repositories, entities
│   ├── 📁 API/
│   │   ├── 📝 APIClient.swift
│   │   ├── 📝 Endpoints.swift
│   │   └── 📝 RequestBuilder.swift
│   ├── 📁 Repositories/
│   │   └── 📝 MovieRepository.swift
│   ├── 📁 Entities/
│   │   └── 📝 MovieEntity.swift
│
├── 📁 Domain/                      # Business logic - models, repo implementations, utils
│   ├── 📁 Repositories/
│   │   └── 📝 MovieRepositoryImpl.swift
│   ├── 📝 Models.swift
│   └── 📝 Secrets.swift
│
├── 📁 Presentation/                # UI layer - SwiftUI views, view models, components
│   ├── 📁 Modules/
│   │   ├── 📁 Home/
│   │   │   ├── 📝 HomeView.swift
│   │   │   └── 📝 HomeViewModel.swift
│   │   ├── 📁 MovieDetail/
│   │   │   ├── 📝 MovieDetailView.swift
│   │   │   └── 📝 MovieDetailViewModel.swift
│   │   └── 📁 Shared/
│   │       └── 📁 Components/
│   │           ├── 📝 MovieGridItemView.swift
│   │           ├── 📝 MovieGridView.swift
│   │           └── 📝 PosterPlaceholderView.swift
│
├── 📁 PopcornHubTests/              # Unit tests
│   ├── 📁 Domain/
│   │   └── 📝 ModelTests.swift
│   ├── 📁 Data/
│   │   └── 📝 RepositoryTests.swift
│   ├── 📁 Presentation/
│   │   ├── 📝 HomeViewModelTests.swift
│   │   └── 📝 MovieDetailViewModelTests.swift
│   └── 📁 Mocks/
│       └── 📝 TestDoubles.swift     # All mocks
```
</details>

---

## 🛠 Tech Stack
- **SwiftUI** – Declarative UI framework
- **Combine** – Reactive programming for data binding
- **MVVM** – Clear separation of concerns
- **Xcode** – iOS development IDE

---

## 📦 Setup & Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/mh-prophet/PopcornHub.git
   cd PopcornHub
   ```
2. Open the `.xcodeproj` file in Xcode  
3. Add your API key in `Secrets.swift`  
4. Build & run the project on an iOS Simulator or device  

> **Note:** Sometimes TMDB API doesn't respond; please try with a VPN in that case.

---

## 🧪 Running Tests
- Open the project in Xcode
- Press `Cmd+U` to run all tests
- Tests use Combine-based expectations and in-memory Core Data for isolation
