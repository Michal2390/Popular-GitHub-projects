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
    @State private var newComment = ""
    
    var body: some View {
        Form {
            TextField("Name", text: $project.name)
            TextField("Details", text: $project.fullName, axis: .vertical)
            DatePicker("Date", selection: $project.createdAt)
            
            Stepper(value: $project.stars, in: 0...Int.max) {
                Text("Stars: \($project.stars.wrappedValue)")
            }
            
//            Section("Comments") {
//                ForEach(project.comments) { comment in
//                    Text(comment.text)
//                }
//                .onDelete(perform: deleteComment)
                
//                HStack {
//                    TextField("Add a new comment in \(project.name)", text: $newComment)
//                    
//                    Button("Add", action: addComment)
//                }
            }
        }
       // .navigationTitle(Constants.editProject)
        //.navigationBarTitleDisplayMode(.inline)
}
    
//    func addComment() {
//        guard newComment.isEmpty == false else { return }
//        
//        withAnimation {
//            let comment = Comment(text: newComment)
//            project.comments.append(comment)
//            newComment = ""
//        }
//    }
//    
//    func deleteComment(_ indexSet: IndexSet) {
//        for index in indexSet {
//            let comment = projectComments[index]
//            modelContext.delete(comment)
//        }
//    }


//#Preview {
//    do {
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: Project.self, configurations: config)
//        let example = Project(name: "Example Project", details: "This is some detailed info about my super github project")
//        return EditProjectView(project: example)
//            .modelContainer(container)
//    } catch {
//        fatalError("Failed to create model container.")
//    }
//}
