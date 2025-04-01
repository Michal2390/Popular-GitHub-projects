//
//  SearchResponse.swift
//  PopularGithubProjects
//
//  Created by Michal Fereniec on 01/04/2025.
//
import Foundation

struct SearchResponse: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [ProjectModel]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}
  
