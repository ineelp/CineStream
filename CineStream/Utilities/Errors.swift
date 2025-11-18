//
//  Errors.swift
//  CineStream
//
//  Created by Neel Patel on 10/11/2025.
//

import Foundation

enum APIConfigError: Error, LocalizedError {
    case fileNotFound
    case dataLodingFailed(underlyingError: Error)
    case decodingFailed(underlyingError: Error)
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "API configuration file not found."
        case let .dataLodingFailed(underlyingError):
            return "Failed to load API configuration data. \(underlyingError.localizedDescription)"
        case let .decodingFailed(underlyingError):
            return "Failed to decode API configuration. \(underlyingError.localizedDescription)"
        }
    }
}

enum NetworkError: Error, LocalizedError {
    case badURLResponse(underlyingError: Error)
    case missingConfig
    case urlBuildFailed
    
    var errorDescription: String? {
        switch self {
        case let .badURLResponse(underlyingError):
            return "Bad URL response. \(underlyingError.localizedDescription)"
        case .missingConfig:
            return "Missing API configuration."
        case .urlBuildFailed:
            return "Failed to build URL."
        }
    }
}
