//
//  ProjectListingView.swift
//  PopularGithubProjects
//
//  Created by Michal Fereniec on 31/03/2025.
//

import SwiftData
import SwiftUI

struct ProjectListingView: View {
    @StateObject private var viewModel = ProjectViewModel()
    @Environment(\.modelContext) var modelContext
    let sort: SortDescriptor<ProjectEntity>
    let searchString: String
    
    @Query(sort: [SortDescriptor(\ProjectEntity.stars, order: .reverse), SortDescriptor(\ProjectEntity.name)]) var projects: [ProjectEntity]
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                loadingView
            case .loaded(let projects):
                projectListView(projects)
            case .error(let error):
                errorView(error)
            }
        }
        .navigationTitle("Trending Projects")
        .navigationDestination(for: ProjectModel.self) { project in
            ProjectDetailView(project: project)
        }
        .task {
            await viewModel.fetchTrendingProjects()
        }
        .onChange(of: searchString) { _, newValue in
            viewModel.filterProjects(with: newValue)
        }
    }
    
    private var loadingView: some View {
        VStack {
            if !projects.isEmpty {
                placeholderProjectList
            }
            ProgressView()
        }
    }
    
    private var placeholderProjectList: some View {
        LazyVStack {
            ForEach(projects.prefix(10), id: \.id) { project in
                ProjectRowView(project: project.toModel())
                    .redacted(reason: .placeholder)
            }
        }
    }
    
    private func projectListView(_ projects: [ProjectModel]) -> some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                projectRows(projects)
                loadingIndicator
            }
            .padding(.horizontal)
        }
        .refreshable {
            await viewModel.fetchTrendingProjects()
        }
        .overlay {
            if projects.isEmpty {
                ContentUnavailableView.search
            }
        }
    }
    
    private func projectRows(_ projects: [ProjectModel]) -> some View {
        ForEach(projects, id: \.id) { project in
            NavigationLink(value: project) {
                ProjectRowView(project: project)
                    .onAppear {
                        Task {
                            await viewModel.loadMoreProjectsIfNeeded(
                                currentItem: project,
                                currentProjects: projects
                            )
                        }
                    }
            }
        }
    }
    
    private var loadingIndicator: some View {
        Group {
            if !projects.isEmpty {
                ProgressView()
                    .padding()
            }
        }
    }
    
    private func errorView(_ error: String) -> some View {
        ContentUnavailableView(
            "Cannot Load Projects",
            systemImage: "exclamationmark.triangle",
            description: Text(error)
        )
        .overlay(alignment: .bottom) {
            retryButton
        }
    }
    
    private var retryButton: some View {
        Button("Try Again") {
            Task {
                await viewModel.fetchTrendingProjects()
            }
        }
        .buttonStyle(.bordered)
        .padding()
    }
    
    init(sort: SortDescriptor<ProjectEntity>, searchString: String) {
        self.sort = sort
        self.searchString = searchString
        _projects = Query(filter: #Predicate<ProjectEntity> { project in
            if searchString.isEmpty {
                return true
            } else {
                return project.name.localizedStandardContains(searchString) ||
                       project.fullName.localizedStandardContains(searchString) ||
                       (project.projectDescription?.localizedStandardContains(searchString) ?? false)
            }
        }, sort: [sort])
    }
    
    func deleteProjects(_ indexSet: IndexSet) {
        for index in indexSet {
            let project = projects[index]
            modelContext.delete(project)
        }
    }
}

#Preview {
    NavigationStack {
        ProjectListingView(sort: SortDescriptor(\ProjectEntity.name), searchString: "")
    }
}
