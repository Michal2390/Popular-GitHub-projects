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
    @StateObject private var themeManager = ThemeManager()
    @State private var isShowingLaunchScreen = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                MainTabView()
                    .modelContainer(for: [
                        ProjectEntity.self,
                        OwnerEntity.self,
                        LicenseEntity.self
                    ])
                    .environmentObject(themeManager)
                    .preferredColorScheme(themeManager.current.colorScheme)
                
                if isShowingLaunchScreen {
                    LaunchScreen()
                        .transition(.opacity)
                        .zIndex(1)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(.easeOut(duration: 0.5)) {
                        isShowingLaunchScreen = false
                    }
                }
            }
        }
    }
}
