//
//  SavedProjectsView.swift
//  PopularGithubProjects
//
//  Created by Michal Fereniec on 31/03/2025.
//

import SwiftUI
import SwiftData

struct SavedProjectsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \ProjectEntity.stars, order: .reverse) private var savedProjects: [ProjectEntity]
    
    var body: some View {
        Group {
            if savedProjects.isEmpty {
                ContentUnavailableView(
                    Constants.noSavedProjects,
                    systemImage: "bookmark",
                    description: Text(Constants.projectUnavailableText)
                )
            } else {
                List {
                    ForEach(savedProjects) { project in
                        NavigationLink {
                            EditProjectView(project: project)
                        } label: {
                            savedProjectRow(project)
                        }
                    }
                    .onDelete(perform: deleteProjects)
                }
            }
        }
        .navigationTitle(Constants.savedProjects)
    }
    
    private func savedProjectRow(_ project: ProjectEntity) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 12) {
                AsyncImage(url: URL(string: project.owner?.avatarUrl ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                }
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text(project.name)
                        .font(.headline)
                    if let owner = project.owner {
                        Text(owner.login)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            
            HStack(spacing: 16) {
                Label("\(project.stars)", systemImage: "star.fill")
                    .foregroundStyle(.yellow)
                
                if let language = project.language {
                    Label(language, systemImage: "circle.fill")
                        .foregroundStyle(.blue)
                }
            }
            .font(.caption)
        }
        .padding(.vertical, 4)
    }
    
    private func deleteProjects(_ indexSet: IndexSet) {
        for index in indexSet {
            let project = savedProjects[index]
            modelContext.delete(project)
        }
    }
}

#Preview {
    NavigationStack {
        SavedProjectsView()
    }
}
