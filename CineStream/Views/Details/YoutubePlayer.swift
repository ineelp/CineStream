//
//  YoutubePlayer.swift
//  CineStream
//
//  Created by Neel Patel on 15/11/2025.
//

import SwiftUI
import WebKit

struct YoutubePlayer: UIViewRepresentable {
    let webView = WKWebView()
    let videoId: String
    let youtubeBaseURL = APIConfig.shared?.youtubeBaseURL
    
    func makeUIView(context: Context) -> some UIView {
        webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let baseURLString = youtubeBaseURL,
              let baseURL = URL(string: baseURLString) else {return}
        let fullURL = baseURL.appending(path: videoId)
        
        var request = URLRequest(url: fullURL)
        
        // YouTube's security expects "Referer" to validate embed requests.
        // Set the Referer HTTP header
        // YouTube player returns ERROR: 153 (Video player configuration error)
        request.setValue(youtubeBaseURL, forHTTPHeaderField: "Referer")
        webView.load(request)
    }
}
