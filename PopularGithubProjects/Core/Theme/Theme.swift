//
//  Theme.swift
//  PopularGithubProjects
//
//  Created by Michal Fereniec on 01/04/2025.
//
import SwiftUI

enum Theme: String, CaseIterable {
    case light, dark, system
    
    var colorScheme: ColorScheme? {
        switch self {
        case .light: return .light
        case .dark: return .dark
        case .system: return nil
        }
    }
    
    var icon: String {
        switch self {
        case .light: return "sun.max.fill"
        case .dark: return "moon.fill"
        case .system: return "gear"
        }
    }
}

class ThemeManager: ObservableObject {
    @AppStorage("selectedTheme") private var selectedTheme = Theme.system
    
    var current: Theme {
        get { selectedTheme }
        set {
            selectedTheme = newValue
            applyTheme()
        }
    }
    
    private func applyTheme() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        
        window.overrideUserInterfaceStyle = selectedTheme.colorScheme.map { $0 == .dark ? .dark : .light } ?? .unspecified
    }
}
