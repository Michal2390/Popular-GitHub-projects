//
//  Theme.swift
//  PopularGithubProjects
//
//  Created by Michal Fereniec on 01/04/2025.
//
import SwiftUI

enum Theme: String, CaseIterable {
    case dark, light
    
    var colorScheme: ColorScheme {
        switch self {
        case .light: return .light
        case .dark: return .dark
        }
    }
    
    var icon: String {
        switch self {
        case .light: return "sun.max.fill"
        case .dark: return "moon.stars.fill"
        }
    }
    
    var label: String {
        switch self {
        case .light: return "Light"
        case .dark: return "Dark"
        }
    }
}
