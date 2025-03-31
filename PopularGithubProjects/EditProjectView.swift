//
//  EditProjectView.swift
//  PopularGithubProjects
//
//  Created by Michal Fereniec on 30/03/2025.
//

import SwiftData
import SwiftUI

struct EditProjectView: View {
    @Bindable var project: Project
    
    var body: some View {
        Form {
            TextField("Name", text: $project.name)
            TextField("Details", text: $project.details, axis: .vertical)
            DatePicker("Date", selection: $project.date)
            
            Stepper(value: $project.stars, in: 0...Int.max) {
                Text("Stars: \($project.stars.wrappedValue)")
            }
        }
        .navigationTitle(Constants.editProject)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Project.self, configurations: config)
        let example = Project(name: "Example Project", details: "This is some detailed info about my super github project")
        return EditProjectView(project: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
