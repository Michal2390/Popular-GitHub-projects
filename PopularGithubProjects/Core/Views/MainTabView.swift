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
//        NavigationStack(path: $path) {
//            ProjectListingView(sort: sortOrder, searchString: searchText)
//                .navigationTitle(Constants.navigationTitle)
//                .navigationDestination(for: Project.self, destination: EditProjectView.init)
//                .searchable(text: $searchText)
//                .toolbar {
//                    Button("Add Project", systemImage: "plus", action: addProject)
//                    
//                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
//                        Picker("Sort", selection: $sortOrder) {
//                            Text("Name")
//                                .tag(SortDescriptor(\Project.name))
//                            
//                            Text("Stars")
//                                .tag(SortDescriptor(\Project.stars, order: .reverse))
//                            
//                            Text("Date")
//                                .tag(SortDescriptor(\Project.date))
//                        }
//                        .pickerStyle(.inline)
//                    }
//                }
//        }
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
