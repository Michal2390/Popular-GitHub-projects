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
    @Query(sort: \Project.stars, order: .reverse) var projects: [Project]
    @State private var path = [Project]()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(projects) { project in
                    NavigationLink(value: project) {
                        VStack(alignment: .leading) {
                            Text(project.name)
                                .font(.headline)
                            
                            Text(project.details)
                                .font(.caption)
                            
                            Text(project.date.formatted(date: .long, time: .shortened))
                        }
                    }
                }
                .onDelete(perform: deleteProjects)
            }
            .navigationTitle(Constants.navigationTitle)
            .navigationDestination(for: Project.self, destination: EditProjectView.init)
            .toolbar {
                Button("Add Project", systemImage: "plus", action: addProject)
            }
        }
    }
    
    func addProject() {
        let project = Project()
        modelContext.insert(project)
        path = [project]
    }
    
    func deleteProjects(_ indexSet: IndexSet) {
        for index in indexSet {
            let project = projects[index]
            modelContext.delete(project)
        }
    }
}

#Preview {
    ContentView()
}
