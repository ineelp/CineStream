//
//  SearchView.swift
//  CineStream
//
//  Created by Neel Patel on 17/11/2025.
//

import SwiftUI

struct SearchView: View {
    @State private var searchByMovies = true
    @State private var searchText = ""
    private let searchViewModel = SearchViewModel()
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack (path: $navigationPath) {
            ScrollView {
                if let error = searchViewModel.errorMessage {
                    Text(error)
                        .foregroundStyle(.red)
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(.rect(cornerRadius: 10))
                }
                LazyVGrid(columns: [
                    GridItem(), GridItem(), GridItem()
                ]) {
                    ForEach(searchViewModel.searchTitles) { title in
                        let url = URL(string: title.posterPath ?? "")
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                ZStack {
                                    Rectangle()
                                        .fill(.quaternary)
                                        .clipShape(.rect(cornerRadius: 10))
                                    ProgressView()
                                }
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(.rect(cornerRadius: 10))
                            case .failure(_):
                                ZStack {
                                    Rectangle()
                                        .fill(.quaternary)
                                        .clipShape(.rect(cornerRadius: 10))
                                    Image(systemName: "film")
                                        .font(.largeTitle)
                                        .foregroundStyle(.secondary)
                                }
                            @unknown default:
                                Image(systemName: "film")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(.secondary)
                                    .clipShape(.rect(cornerRadius: 10))
                            }
                        }
                        .frame(width: 120, height: 200)
                        .onTapGesture {
                            navigationPath.append(title)
                        }
                    }
                }
                if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false,
                   searchViewModel.errorMessage == nil,
                   searchViewModel.searchTitles.isEmpty {
                    VStack(spacing: 8) {
                        Image(systemName: "magnifyingglass")
                            .font(.largeTitle)
                            .foregroundStyle(.secondary)
                        Text("No Results Found")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        Text("Try a different query or check your spelling.")
                            .font(.subheadline)
                            .foregroundStyle(.tertiary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 40)
                }
            }
            .navigationTitle(searchByMovies ? Constants.movieSearchString : Constants.tvSearchString)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        searchByMovies.toggle()
                        
                        Task {
                            await searchViewModel.getSearchTitles(by: searchByMovies ? "movie" : "tv", for: searchText)
                        }
                    } label: {
                        Image(systemName: searchByMovies ? Constants.movieIConString: Constants.tvIConString)
                    }
                }
            }
            .searchable(text: $searchText, prompt: searchByMovies ? Constants.moviePlaceholderString : Constants.tvPlaceholderString)
            .task(id: searchText) {
                try? await Task.sleep(for: .milliseconds(500))
                
                if Task.isCancelled {
                    return
                }
                
                await searchViewModel.getSearchTitles(by: searchByMovies ? "movie" : "tv", for: searchText)
            }
            .navigationDestination(for: Title.self) { title in
                TitleDetailView(title: title)
            }
        }
    }
}

#Preview {
    SearchView()
}
