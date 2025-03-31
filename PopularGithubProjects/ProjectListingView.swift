//
//  ProjectListingView.swift
//  PopularGithubProjects
//
//  Created by Michal Fereniec on 31/03/2025.
//

import SwiftData
import SwiftUI

struct ProjectListingView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\Project.stars, order: .reverse), SortDescriptor(\Project.name)]) var projects: [Project]
    
    var body: some View {
        List {
            ForEach(projects) { project in
                NavigationLink(value: project) {
                    VStack(alignment: .leading) {
                        Text(project.name)
                            .font(.headline)
                        
                        Text(project.details)
                            .font(.caption)
                        HStack(spacing: 8) {
                            Text(project.date.formatted(date: .long, time: .shortened))
                                .foregroundStyle(.accent)
                            
                            Spacer()
                            
                            Label("\(project.stars) \(project.stars == 1 ? "star" : "stars")", systemImage: "star.circle.fill")
                                .labelStyle(.titleAndIcon)
                        }
                    }
                }
            }
            .onDelete(perform: deleteProjects)
        }
    }
    
    init(sort: SortDescriptor<Project>, searchString: String) {
        _projects = Query(filter: #Predicate {
            if searchString.isEmpty {
                return true
            } else {
                return $0.name.localizedStandardContains(searchString)
            }
            //$0.stars >= 100
        },sort: [sort]) // _projects is a query object and we want that in this case, not an array
    }
    
    func deleteProjects(_ indexSet: IndexSet) {
        for index in indexSet {
            let project = projects[index]
            modelContext.delete(project)
        }
    }
}

#Preview {
    ProjectListingView(sort: SortDescriptor(\Project.name), searchString: "")
}
