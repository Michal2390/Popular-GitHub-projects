//
//  ProjectDetailView.swift
//  PopularGithubProjects
//
//  Created by Michal Fereniec on 31/03/2025.
//

import SwiftUI
import SwiftData

struct ProjectDetailView: View {
    @Environment(\.modelContext) private var modelContext
    let project: ProjectModel
    
    @Query private var savedProjects: [ProjectEntity]
    
    private var isProjectSaved: Bool {
        savedProjects.contains { $0.id == project.id }
    }
    
    var body: some View {
        List {
            Section { headerView }
            Section("Details") { detailsView }
            Section("License") { licenseView }
            Section("Dates") { datesView }
            Section { githubLink }
        }
        .navigationTitle(project.name)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                saveButton
            }
        }
    }
    
    private var headerView: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: project.owner?.avatarUrl ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Image(systemName: "person.circle.fill")
                    .resizable()
            }
            .frame(width: 50, height: 50)
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
    }
    
    private var detailsView: some View {
        Group {
            if let description = project.description {
                LabeledContent("Description") {
                    Text(description)
                        .font(.subheadline)
                }
            }
            
            LabeledContent("Stars") {
                Label("\(project.stars)", systemImage: "star.fill")
                    .foregroundStyle(.yellow)
            }
            
            if let language = project.language {
                LabeledContent("Language") {
                    Text(language)
                }
            }
            
            LabeledContent("Forks") {
                Label("\(project.forksCount)", systemImage: "tuningfork")
            }
            
            LabeledContent("Open Issues") {
                Label("\(project.openIssuesCount)", systemImage: "exclamationmark.circle")
            }
        }
    }
    
    private var licenseView: some View {
        Group {
            if let license = project.license {
                LabeledContent("Type") {
                    Text(license.name)
                }
                
                if let spdxId = license.spdxId {
                    LabeledContent("SPDX ID") {
                        Text(spdxId)
                    }
                }
            } else {
                Text(Constants.noLicenseInformation)
                    .foregroundStyle(.secondary)
            }
        }
    }
    
    private var datesView: some View {
        Group {
            LabeledContent("Created") {
                Text(project.createdAt.formatted(date: .long, time: .shortened))
            }
            
            LabeledContent("Last updated") {
                Text(project.updatedAt.formatted(date: .long, time: .shortened))
            }
        }
    }
    
    private var githubLink: some View {
        Link(destination: URL(string: project.htmlUrl)!) {
            HStack {
                Text(Constants.viewOnGitHub)
                Spacer()
                Image(systemName: "arrow.up.right")
            }
        }
    }
    
    private var saveButton: some View {
        Button {
            if isProjectSaved {
                if let savedProject = savedProjects.first(where: { $0.id == project.id }) {
                    modelContext.delete(savedProject)
                }
            } else {
                let entity = ProjectEntity(from: project)
                modelContext.insert(entity)
            }
        } label: {
            Image(systemName: isProjectSaved ? "bookmark.fill" : "bookmark")
        }
    }
}
