//
//  EditProjectView.swift
//  PopularGithubProjects
//
//  Created by Michal Fereniec on 30/03/2025.
//

import SwiftData
import SwiftUI

struct EditProjectView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Bindable var project: ProjectEntity
    @State private var showingDeleteAlert = false
    
    var body: some View {
        Form {
            basicInformationSection
            statisticsSection
            datesSection
            repositoryLinkSection
            deleteSection
        }
        .navigationTitle(Constants.editProject)
        .navigationBarTitleDisplayMode(.inline)
        .alert(Constants.deleteProject, isPresented: $showingDeleteAlert) {
            deleteAlert
        } message: {
            Text(Constants.areUSiur) // yes, i am funny :-)
        }
    }
    
    private var basicInformationSection: some View {
        Section(Constants.basicInfo) {
            TextField("Name", text: $project.name)
            TextField("Full Name", text: $project.fullName)
            
            if let description = project.projectDescription {
                TextEditor(text: Binding(
                    get: { description },
                    set: { project.projectDescription = $0 }
                ))
                .frame(minHeight: 100)
            }
        }
    }
    
    private var statisticsSection: some View {
        Section("Statistics") {
            starsField
            languageField
            forksField
            issuesField
        }
    }
    
    private var starsField: some View {
        Stepper("Stars: \(project.stars)", value: $project.stars)
            .foregroundStyle(.primary)
    }
    
    private var languageField: some View {
        Group {
            if let language = project.language {
                TextField("Language", text: Binding(
                    get: { language },
                    set: { project.language = $0 }
                ))
            }
        }
    }
    
    private var forksField: some View {
        Stepper("Forks: \(project.forksCount)", value: $project.forksCount)
            .foregroundStyle(.primary)
    }
    
    private var issuesField: some View {
        Stepper("Open Issues: \(project.openIssuesCount)", value: $project.openIssuesCount)
            .foregroundStyle(.primary)
    }
    
    private var datesSection: some View {
        Section("Dates") {
            DatePicker("Created", selection: $project.createdAt)
            DatePicker("Last Updated", selection: $project.updatedAt)
        }
    }
    
    private var repositoryLinkSection: some View {
        Section(Constants.repoLink) {
            TextField("HTML URL", text: $project.htmlUrl)
        }
    }
    
    private var deleteSection: some View {
        Section {
            Button(role: .destructive) {
                showingDeleteAlert = true
            } label: {
                deleteButton
            }
        }
    }
    
    private var deleteButton: some View {
        HStack {
            Image(systemName: "trash")
            Text(Constants.deleteProject)
        }
    }
    
    private var deleteAlert: some View {
        Group {
            Button("Delete", role: .destructive) {
                modelContext.delete(project)
                dismiss()
            }
            Button("Cancel", role: .cancel) { }
        }
    }
}
