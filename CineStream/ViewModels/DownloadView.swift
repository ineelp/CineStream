//
//  DownloadView.swift
//  CineStream
//
//  Created by Neel Patel on 18/11/2025.
//

import SwiftUI
import SwiftData

struct DownloadView: View {
    @Query(sort: \Title.title) var saveTitles: [Title]
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            Group {
                if saveTitles.isEmpty {
                    Text("No Downloads")
                        .padding()
                        .font(.title3)
                        .bold()
                } else {
                    VerticalListView(titles: saveTitles, canDelete: true, navigationPath: $navigationPath)
                }
            }
            .navigationDestination(for: Title.self) { title in
                TitleDetailView(title: title, isDownloaded: true)
            }
        }
    }
}
#Preview {
    DownloadView()
}
