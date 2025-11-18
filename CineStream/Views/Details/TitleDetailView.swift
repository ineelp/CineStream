//
//  TitleDetailView.swift
//  CineStream
//
//  Created by Neel Patel on 15/11/2025.
//

import SwiftUI
import SwiftData

struct TitleDetailView: View {
    let title: Title
    let isDownloaded: Bool
    var titleName: String {
        return (title.name ?? title.title) ?? ""
    }
    let viewModel: ViewModel
    @Environment(\.modelContext) var modelContext
    
    init(title: Title, isDownloaded: Bool = false) {
        self.title = title
        self.isDownloaded = isDownloaded
        self.viewModel = ViewModel()
    }
    
    var body: some View {
        GeometryReader { geometry in
            switch viewModel.videoIdStatus {
            case .notStarted:
                EmptyView()
            case .fetching:
                ProgressView()
                    .frame(width: geometry.size.width, height: geometry.size.height)
            case .success:
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        YoutubePlayer(videoId: viewModel.videoId)
                            .aspectRatio(1.3, contentMode: .fit)
                        
                        Text(titleName)
                            .bold()
                            .font(.title2)
                            .padding(5)
                        
                        
                        Text(title.overview ?? "")
                            .padding(5)
                        
                        if !isDownloaded {
                            HStack {
                                Spacer()
                                
                                Button {
                                    let saveTitle = title
                                    saveTitle.title = titleName
                                    modelContext.insert(saveTitle)
                                    try? modelContext.save()
                                    
                                } label: {
                                    
                                    Text(Constants.downloadString)
                                        .ghostButton()
                                }
                                
                                Spacer()
                            }
                        }
                        
                    }
                }
            case .failed(let underlyingError):
                Text(underlyingError.localizedDescription)
                    .erroMessage()
                    .frame(width: geometry.size.width, height:  geometry.size.height)
            }
        }
        .task {
            await viewModel.getVideoId(for: titleName)
        }
        
    }
}

#Preview {
    TitleDetailView(title: Title.previewTitles[0])
}
