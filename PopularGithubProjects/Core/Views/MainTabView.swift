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
    @EnvironmentObject private var themeManager: ThemeManager
    @Query(sort: [SortDescriptor(\ProjectEntity.stars, order: .reverse), SortDescriptor(\ProjectEntity.name)]) var projects: [ProjectEntity]
    @State private var sortOrder = SortDescriptor(\ProjectEntity.stars)
    @State private var searchText = ""
    @State private var isShowingThemePicker = false
    
    var body: some View {
        TabView {
            NavigationStack {
                ProjectListingView(sort: sortOrder, searchString: searchText)
                    .navigationTitle(Constants.trending)
                    .searchable(
                        text: $searchText,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: Constants.searchProjects
                    )
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            ThemeToggle()
                        }
                    }
            }
            .tabItem {
                Label(Constants.trending, systemImage: "star.fill")
            }
            
            NavigationStack {
                SavedProjectsView()
            }
            .tabItem {
                Label(Constants.saved, systemImage: "bookmark.fill")
            }
        }
    }
}

#Preview {
    MainTabView()
}
