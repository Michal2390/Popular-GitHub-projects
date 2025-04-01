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
    @State private var path = [ProjectEntity]()
    @State private var sortOrder = SortDescriptor(\ProjectEntity.stars)
    @State private var searchText = ""
    @State private var isShowingThemePicker = false
    
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
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                isShowingThemePicker.toggle()
                            } label: {
                                Image(systemName: themeManager.current.icon)
                            }
                        }
                    }
                    .confirmationDialog("Choose Theme", isPresented: $isShowingThemePicker) {
                        ForEach(Theme.allCases, id: \.self) { theme in
                            Button(theme.rawValue.capitalized) {
                                withAnimation {
                                    themeManager.current = theme
                                }
                            }
                        }
                    }
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
