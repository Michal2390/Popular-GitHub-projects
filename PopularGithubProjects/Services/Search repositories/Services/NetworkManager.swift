//
//  NetworkManager.swift
//  PopularGithubProjects
//
//  Created by Michal Fereniec on 01/04/2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case serverError(Int)
    case unknown
}

protocol Networking {
    func fetchTrendingRepositories(page: Int) async throws -> [ProjectModel]
}

@Observable
final class NetworkManager: Networking {
    var isLoading = false
    
    func fetchTrendingRepositories(page: Int = 1) async throws -> [ProjectModel] {
        isLoading = true
        defer { isLoading = false } //thx Antonie van der Lee ;) aka SwiftLee - I am FANCY now :D
        
        var components = URLComponents(string: Constants.API.baseURL + Constants.API.searchEndpoint)
        components?.queryItems = [
            URLQueryItem(name: "q", value: Constants.API.defaultQuery),
            URLQueryItem(name: "sort", value: Constants.API.sortBy),
            URLQueryItem(name: "order", value: Constants.API.orderBy),
            URLQueryItem(name: "per_page", value: "\(Constants.UI.maxItemsToShow)"),
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        if let jsonString = String(data: data, encoding: .utf8) {
            print("Raw JSON response: \(jsonString)")
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(httpResponse.statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let searchResponse = try decoder.decode(SearchResponse.self, from: data)
            return searchResponse.items
        } catch {
            print("Decoding error: \(error)")
            throw NetworkError.decodingError
        }
    }
}
