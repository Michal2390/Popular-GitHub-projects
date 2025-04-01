//
//  Constants.swift
//  PopularGithubProjects
//
//  Created by Michal Fereniec on 31/03/2025.
//

struct Constants {
    
    // MARK: - UI Text
    static let navigationTitle = "Popular GitHub Projects"
    static let editProject = "Edit Project"
    
    // MARK: - API
    struct API {
        static let baseURL = "https://api.github.com"
        static let searchEndpoint = "/search/repositories"
        static let defaultQuery = "stars:>1000"
        static let sortBy = "stars"
        static let orderBy = "desc"
    }
    
    // MARK: - UI Configuration
    struct UI {
        static let maxItemsToShow = 30
        static let animationDuration = 0.3
    }
    
    // MARK: - Error Messages
    struct ErrorMessages {
        static let networkError = "Unable to fetch projects"
        static let noData = "No project available"
    }
}
