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
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.colorScheme) var colorScheme
    let sort: SortDescriptor<ProjectEntity>
    let searchString: String
    
    @Query(sort: [SortDescriptor(\ProjectEntity.stars, order: .reverse), SortDescriptor(\ProjectEntity.name)]) var projects: [ProjectEntity]
    @Namespace private var animation
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                loadingView
                    .transition(.opacity)
            case .loaded(let projects):
                projectListView(projects)
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
            case .error(let error):
                errorView(error)
                    .transition(.scale)
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
            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                viewModel.filterProjects(with: newValue)
            }
        }
    }
    
    private var loadingView: some View {
        VStack {
            if !projects.isEmpty {
                placeholderProjectList
            }
            ProgressView()
                .scaleEffect(1.5)
        }
    }
    
    private var placeholderProjectList: some View {
        LazyVStack {
            ForEach(projects.prefix(10), id: \.id) { project in
                ProjectRowView(project: project.toModel())
                    .redacted(reason: .placeholder)
                    .shimmering()
            }
        }
        .padding(.horizontal)
    }
    
    private func projectListView(_ projects: [ProjectModel]) -> some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                if sizeClass == .regular {
                    // iPad Layout
                    LazyVGrid(columns: [
                        GridItem(.adaptive(minimum: 300, maximum: 400), spacing: 16)
                    ], spacing: 16) {
                        projectRows(projects)
                    }
                } else {
                    // iPhone Layout
                    projectRows(projects)
                }
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
                    .transition(.scale.combined(with: .opacity))
            }
        }
        .background(Color(.systemGroupedBackground))
    }
    
    private func projectRows(_ projects: [ProjectModel]) -> some View {
        ForEach(projects, id: \.id) { project in
            NavigationLink(value: project) {
                ProjectRowView(project: project)
                    .matchedGeometryEffect(id: project.id, in: animation)
                    .onAppear {
                        Task {
                            await viewModel.loadMoreProjectsIfNeeded(
                                currentItem: project,
                                currentProjects: projects
                            )
                        }
                    }
            }
            .transition(.scale(scale: 0.9).combined(with: .opacity))
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
