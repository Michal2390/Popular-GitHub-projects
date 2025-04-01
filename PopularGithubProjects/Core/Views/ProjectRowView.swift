//
//  ProjectRowView.swift
//  PopularGithubProjects
//
//  Created by Michal Fereniec on 01/04/2025.
//

import SwiftUI

struct ProjectRowView: View {
    let project: ProjectModel
    @Environment(\.colorScheme) var colorScheme
    
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
                        .foregroundStyle(.secondary)
                }
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .shadow(radius: 2)
                
                VStack(alignment: .leading) {
                    Text(project.name)
                        .font(.headline)
                        .foregroundColor(colorScheme == .dark ? .white : .primary)
                    if let owner = project.owner {
                        Text(owner.login)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                Spacer(minLength: 0)
            }
            
            if let description = project.description {
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(colorScheme == .dark ? .white : .primary)
                    .lineLimit(2)
            } else {
                Text("No description available")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .italic()
            }
            
            Spacer(minLength: 16)
            
            HStack(spacing: 16) {
                Label {
                    Text("\(project.stars)")
                        .foregroundColor(colorScheme == .dark ? .white : .primary)
                } icon: {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                }
                
                if let language = project.language {
                    Label {
                        Text(language)
                            .foregroundColor(colorScheme == .dark ? .white : .primary)
                    } icon: {
                        Image(systemName: "circle.fill")
                            .foregroundStyle(.blue)
                    }
                }
                
                Label {
                    Text("\(project.forksCount)")
                        .foregroundColor(colorScheme == .dark ? .white : .primary)
                } icon: {
                    Image(systemName: "tuningfork")
                        .foregroundStyle(.gray)
                }
                
                Spacer(minLength: 0)
            }
            .font(.caption)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(colorScheme == .dark ? Color(.secondarySystemGroupedBackground) : .white)
        )
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: colorScheme == .dark ? .clear : .black.opacity(0.1), radius: 2, y: 1)
        .contentShape(RoundedRectangle(cornerRadius: 12))
        .transition(.scale.combined(with: .opacity))
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
