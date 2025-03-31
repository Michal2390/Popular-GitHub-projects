//
//  ContentView.swift
//  PopularGithubProjects
//
//  Created by Michal Fereniec on 30/03/2025.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var path = [Project]()
    @State private var sortOrder = SortDescriptor(\Project.name)
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack(path: $path) {
            ProjectListingView(sort: sortOrder, searchString: searchText)
                .navigationTitle(Constants.navigationTitle)
                .navigationDestination(for: Project.self, destination: EditProjectView.init)
                .searchable(text: $searchText)
                .toolbar {
                    Button("Add Project", systemImage: "plus", action: addProject)
                    
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Name")
                                .tag(SortDescriptor(\Project.name))
                            
                            Text("Stars")
                                .tag(SortDescriptor(\Project.stars, order: .reverse))
                            
                            Text("Date")
                                .tag(SortDescriptor(\Project.date))
                        }
                        .pickerStyle(.inline)
                    }
                }
        }
    }
    
    func addProject() {
        let project = Project()
        modelContext.insert(project)
        path = [project]
    }
}

#Preview {
    ContentView()
}
