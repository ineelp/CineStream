//
//  YoutubeSearchResponse.swift
//  CineStream
//
//  Created by Neel Patel on 15/11/2025.
//
import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [ItemProperties]?
}

struct ItemProperties: Codable {
    let id: IdProperties?
}

struct IdProperties: Codable {
    let videoId: String?
}
