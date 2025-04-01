//
//  MainTabView.swift
//  PopularGithubProjects
//
//  Created by Michal Fereniec on 30/03/2025.
//

import SwiftData
import SwiftUI

struct MainTabView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: [SortDescriptor(\ProjectEntity.stars, order: .reverse), SortDescriptor(\ProjectEntity.name)]) var projects: [ProjectEntity]
    @State private var path = [ProjectEntity]()
    @State private var sortOrder = SortDescriptor(\ProjectEntity.stars)
    @State private var searchText = ""
    
    var body: some View {
        TabView {
            NavigationStack {
                ProjectListingView(sort: sortOrder, searchString: searchText)
                    .navigationTitle("Trending")
                    .searchable(
                        text: $searchText,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: "Search projects..."
                    )
            }
            .tabItem {
                Label("Trending", systemImage: "star.fill")
            }
            
            NavigationStack {
                SavedProjectsView()
            }
            .tabItem {
                Label("Saved", systemImage: "bookmark.fill")
            }
        }
    }
    
    func addProject() {
        let project = ProjectEntity()
        modelContext.insert(project)
        path = [project]
    }
}

#Preview {
    MainTabView()
}
