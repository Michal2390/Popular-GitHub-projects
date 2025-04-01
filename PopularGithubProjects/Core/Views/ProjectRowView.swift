//
//  ProjectRowView.swift
//  PopularGithubProjects
//
//  Created by Michal Fereniec on 01/04/2025.
//

import SwiftUI

struct ProjectRowView: View {
    let project: ProjectModel
    
    var body: some View {
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
            
            if let description = project.description {
                Text(description)
                    .font(.subheadline)
                    .lineLimit(2)
                    .foregroundStyle(.secondary)
            }
            
            HStack(spacing: 16) {
                Label("\(project.stars)", systemImage: "star.fill")
                    .foregroundStyle(.yellow)
                
                if let language = project.language {
                    Label(language, systemImage: "circle.fill")
                        .foregroundStyle(.blue)
                }
                
                Label("\(project.forksCount)", systemImage: "tuningfork")
                    .foregroundStyle(.gray)
            }
            .font(.caption)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ProjectRowView(project: .init(
        id: 1,
        name: "Example Project",
        fullName: "user/project",
        description: "This is an example project description that might be a bit longer to test multiple lines.",
        owner: .init(
            id: 1,
            login: "username",
            avatarUrl: "",
            htmlUrl: "",
            type: "User"
        ),
        isPrivate: false,
        htmlUrl: "",
        stars: 1000,
        language: "Swift",
        forksCount: 100,
        openIssuesCount: 10,
        license: nil,
        createdAt: .now,
        updatedAt: .now
    ))
    .padding()
}
