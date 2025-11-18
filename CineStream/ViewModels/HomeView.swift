//
//  HomeView.swift
//  CineStream
//
//  Created by Neel Patel on 5/11/2025.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    var viewModel = ViewModel()
    @State private var titleDetailPath = NavigationPath()
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack(path: $titleDetailPath) {
            GeometryReader { geo in
                ScrollView(.vertical) {
                    switch viewModel.homeStatus {
                    case .notStarted:
                        EmptyView()
                    case .fetching:
                        ProgressView()
                            .frame(width: geo.size.width, height:  geo.size.height)
                    case .success:
                        LazyVStack {
                            AsyncImage(url: URL(string: viewModel.heroTitle.posterPath ?? "")) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .overlay {
                                        LinearGradient(
                                            stops: [Gradient.Stop(color: .clear, location: 0.8), Gradient.Stop(color: .gradient, location: 1)],
                                            startPoint: .top,
                                            endPoint: .bottom)
                                    }
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: geo.size.width, height: geo.size.height * 0.85)
                            
                            HStack {
                                Button {
                                    titleDetailPath.append(viewModel.heroTitle)
                                    
                                } label: {
                                    Text(Constants.playString)
                                        .ghostButton()
                                }
                                
                                Button {
                                    modelContext.insert(viewModel.heroTitle)
                                    try? modelContext.save()
                                    
                                } label: {
                                    Text(Constants.downloadString)
                                        .ghostButton()
                                }
                            }
                            
                            HorizontalListView(header: Constants.trendingMovingString, titles: viewModel.trendingMovies) { title in
                                titleDetailPath.append(title)
                            }
                            HorizontalListView(header: Constants.tredingTVString, titles: viewModel.trendingTV) { title in
                                titleDetailPath.append(title)
                            }
                            HorizontalListView(header: Constants.topRateMovieString, titles: viewModel.trendingMovies) { title in
                                titleDetailPath.append(title)
                            }
                            HorizontalListView(header: Constants.topRateTVString, titles: viewModel.topRatedTv) { title in
                                titleDetailPath.append(title)
                            }
                        }
                        
                    case let .failed(underlyingError: error):
                        Text(error.localizedDescription)
                            .erroMessage()
                            .frame(width: geo.size.width, height:  geo.size.height)
                    }
                    
                }
                .task {
                    await viewModel.getTitles()
                }
                .navigationDestination(for: Title.self) { title in
                    TitleDetailView(title: title)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
