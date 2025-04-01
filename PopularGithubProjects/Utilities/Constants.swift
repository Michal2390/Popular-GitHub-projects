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
    static let savedProjects = "Saved Projects"
    static let projectUnavailableText = "Your saved projects will appear here"
    static let noSavedProjects = "No Saved Projects"
    static let noDescriptionAvailable = "No description available"
    static let trendingProjects = "Trending Projects"
    static let cannotLoadProjects = "Cannot Load Projects"
    static let tryAgain = "Try Again"
    static let noLicenseInformation = "No license information available"
    static let viewOnGitHub = "View on GitHub"
    static let searchProjects = "Search projects..."
    static let trending = "Trending"
    static let saved = "Saved"
    static let areUSiur = "Are you sure you want to delete this project? This action cannot be undone."
    static let deleteProject = "Delete Project"
    static let basicInfo = "Basic Information"
    static let repoLink = "Repository Link"
    
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
