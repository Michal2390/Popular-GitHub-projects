//
//  ThemeToggle.swift
//  PopularGithubProjects
//
//  Created by Michal Fereniec on 01/04/2025.
//

import Foundation
import SwiftUI

struct ThemeToggle: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @State private var isAnimating = false
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach([Theme.dark, Theme.light], id: \.self) { theme in
                ThemeButton(
                    theme: theme,
                    isSelected: themeManager.current == theme,
                    isAnimating: isAnimating
                ) {
                    handleThemeChange(to: theme)
                }
            }
        }
        .padding(3)
        .background(.clear)
        .scaleEffect(isAnimating ? 0.95 : 1.0)
    }
    
    private func handleThemeChange(to theme: Theme) {
        guard themeManager.current != theme else { return }
        let timeAnimation = 0.4
        
        withAnimation(.smooth(duration: timeAnimation, extraBounce: 0.5)) {
            themeManager.current = theme
            isAnimating = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + timeAnimation) {
            isAnimating = false
        }
    }
}
