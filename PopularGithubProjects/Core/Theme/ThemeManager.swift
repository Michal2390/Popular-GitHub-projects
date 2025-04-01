//
//  ThemeManager.swift
//  PopularGithubProjects
//
//  Created by Michal Fereniec on 01/04/2025.
//
import Foundation
import SwiftUI

class ThemeManager: ObservableObject {
    @AppStorage("selectedTheme") private var selectedTheme = Theme.dark
    
    var current: Theme {
        get { selectedTheme }
        set {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                selectedTheme = newValue
                applyTheme()
            }
        }
    }
    
    private func applyTheme() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        window.overrideUserInterfaceStyle = current.colorScheme == .dark ? .dark : .light
    }
}
