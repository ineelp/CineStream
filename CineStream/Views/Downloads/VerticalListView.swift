//
//  VerticalListView.swift
//  CineStream
//
//  Created by Neel Patel on 17/11/2025.
//

import SwiftUI
import SwiftData

struct VerticalListView: View {
    var titles: [Title]
    let canDelete: Bool
    @Binding var navigationPath: NavigationPath
    
    @Environment(\.modelContext) var modelContext
    
    init(titles: [Title], canDelete: Bool = false, navigationPath: Binding<NavigationPath>) {
        self.titles = titles
        self.canDelete = canDelete
        self._navigationPath = navigationPath
    }
    
    var body: some View {
        List(titles) { title in
            HStack {
                AsyncImage(url: URL(string: title.posterPath ?? "")) { image in
                    HStack {
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(.rect(cornerRadius: 10))
                            .padding(5)
                        
                        Text((title.name ?? title.title) ?? "")
                            .font(.system(size: 14))
                            .bold()
                    }
                    
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 150)
            }
            .onTapGesture {
                navigationPath.append(title)
            }
            .swipeActions(edge: .trailing) {
                if canDelete {
                    Button {
                        modelContext.delete(title)
                        try? modelContext.save()
                    } label: {
                        Image(systemName: "trash")
                            .tint(.red)
                    }
                }
            }
            
        }
        .padding(10)
    }
}

#Preview {
    VerticalListView(titles: Title.previewTitles, navigationPath: .constant(NavigationPath()))
}
