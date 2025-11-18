# CineStream 🎬✨

CineStream is a lightweight SwiftUI iOS starter app that fetches movie and TV metadata from The Movie Database (TMDB) and performs YouTube searches to show trailers. Titles can be viewed, searched, and saved locally using SwiftData. 🍿

# Preview
<img width="332" height="728" alt="Screenshot 2025-11-18 at 6 28 39 pm" src="https://github.com/user-attachments/assets/73cc4f8f-c658-4fcc-bf22-60750584819b" />


Project structure (MVVM) - clean and scalable 🗂️
- CineStream/
  - App/ 🚀
    - CineStreamApp.swift
    - ContentView.swift
  - Models/ 🎯
    - Title.swift
    - APIConfig.swift
    - YoutubeSearchResponse.swift
  - ViewModels/ 🧭
    - HomeViewModel.swift
    - SearchViewModel.swift
    - DetailsViewModel.swift
    - DownloadsViewModel.swift
  - Views/ 🖼️
    - Home/
      - HomeView.swift
      - HorizontalListView.swift
    - Search/
      - SearchView.swift
    - Details/
      - TitleDetailView.swift
      - YoutubePlayer.swift
    - Downloads/
      - DownloadView.swift
      - VerticalListView.swift
    - Upcoming/
      - UpcomingView.swift
  - Services/ 🌐
    - DataFetcher.swift
    - APIConfig.json
  - Utilities/ 🔧
    - Constants.swift
    - Errors.swift
  - Resources/ 📁
    - Assets.xcassets/
    - Info.plist

Why this layout?
- Clear separation of concerns (Models, ViewModels, Views, Services).
- Easier testing and DI for ViewModels and Services.
- Scales by feature — add folders per feature for Views + matching ViewModels.
- Keeps configuration and networking isolated from UI logic.

Requirements
- Xcode Version: 26.1.1  🛠️
- iOS device or simulator 📱
- Valid API keys for TMDB and YouTube stored in Services/APIConfig.json 🔐

Setup & Configuration
1. Open the project:
   - Open CineStream.xcodeproj
2. Configure API keys:
   - Add your TMDB and YouTube API keys to Services/APIConfig.json.
   - For production, keep keys out of source control (XCConfig, Keychain, CI secrets).

API Keys 🔑
- Please enter your API Key from The Movie Database into Services/APIConfig.json: https://www.themoviedb.org/?language=en-US
- You'll also need a key from Google Developer Console for the YouTube API: https://console.cloud.google.com/

Build & run ▶️
- In Xcode:
  - Select a simulator or device and run.
  - App entry point: CineStreamApp (registers SwiftData model container for Title).

Features Overview ⭐
- Home: trending and top rated lists with hero poster.
- Search: debounced search for movies/TV.
- Upcoming: upcoming movies list.
- Detail: title details with embedded YouTube trailer.
- Downloaded: saved titles using SwiftData.

Networking 🌐
- Centralised in Services/DataFetcher.swift.
- TMDB endpoints and YouTube search configured via Services/APIConfig.json.
- Errors surfaced via Utilities/Errors.swift.
