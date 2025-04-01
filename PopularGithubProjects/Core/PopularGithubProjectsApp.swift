//
//  PopularGithubProjectsApp.swift
//  PopularGithubProjects
//
//  Created by Michal Fereniec on 30/03/2025.
//

import SwiftUI
import SwiftData

@main
struct PopularGithubProjectsApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
        .modelContainer(for: [
            ProjectEntity.self,
            OwnerEntity.self,
            LicenseEntity.self
        ])
    }
}
