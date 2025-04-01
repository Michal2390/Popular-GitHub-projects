//
//  ProjectViewModel.swift
//  PopularGithubProjects
//
//  Created by Michal Fereniec on 01/04/2025.
//

import Foundation
import SwiftUI

class ProjectViewModel: ObservableObject {
    enum State {
        case loading
        case loaded([ProjectModel])
        case error(String)
    }
    
    private let networkManager: Networking
    @Published var state: State = .loading
    private var currentPage = 1
    private var isLoadingMore = false
    private var hasMorePages = true
    private var allProjects: [ProjectModel] = []
    
    init(networkManager: Networking = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    @MainActor
    func fetchTrendingProjects() async {
        state = .loading
        currentPage = 1
        hasMorePages = true
        
        do {
            allProjects = try await networkManager.fetchTrendingRepositories(page: currentPage)
            state = .loaded(allProjects)
        } catch {
            state = .error(error.localizedDescription)
        }
    }
    
    @MainActor
    func filterProjects(with searchText: String) {
        guard !searchText.isEmpty else {
            state = .loaded(allProjects)
            return
        }
        
        let filteredProjects = allProjects.filter { project in
            project.name.localizedStandardContains(searchText) ||
            project.fullName.localizedStandardContains(searchText) ||
            (project.description?.localizedStandardContains(searchText) ?? false)
        }
        
        state = .loaded(filteredProjects)
    }
    
    @MainActor
    func loadMoreProjectsIfNeeded(currentItem item: ProjectModel? = nil, currentProjects: [ProjectModel]) async {
        guard let item = item else { return }
        
        let thresholdIndex = currentProjects.index(currentProjects.endIndex, offsetBy: -5)
        if currentProjects.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
            await loadMoreProjects(currentProjects: currentProjects)
        }
    }
    
    @MainActor
    private func loadMoreProjects(currentProjects: [ProjectModel]) async {
        guard !isLoadingMore && hasMorePages else { return }
        
        isLoadingMore = true
        currentPage += 1
        
        do {
            let newProjects = try await networkManager.fetchTrendingRepositories(page: currentPage)
            if newProjects.isEmpty {
                hasMorePages = false
            } else {
                allProjects.append(contentsOf: newProjects)
                state = .loaded(allProjects)
            }
        } catch {
            // If loading more fails, we'll just stop pagination but keep existing data
            hasMorePages = false
        }
        isLoadingMore = false
    }
}
