//
//  UpcomingView.swift
//  CineStream
//
//  Created by Neel Patel on 17/11/2025.
//

import SwiftUI

struct UpcomingView: View {
    let viewModel = ViewModel()
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            GeometryReader { geo in
                switch viewModel.upcomingStatus {
                case .notStarted:
                    EmptyView()
                case .fetching:
                    ProgressView()
                        .frame(width: geo.size.width, height: geo.size.height)
                case .success:
                    VerticalListView(titles: viewModel.upcomingMovies, navigationPath: $navigationPath)
                case .failed(let underlyingError):
                    Text(underlyingError.localizedDescription)
                        .erroMessage()
                        .frame(width: geo.size.width, height:  geo.size.height)
                }
            }
            .task {
                await viewModel.getUpcomingMovies()
            }
            .navigationDestination(for: Title.self) { title in
                TitleDetailView(title: title)
            }
        }
    }
}

#Preview {
    UpcomingView()
}
