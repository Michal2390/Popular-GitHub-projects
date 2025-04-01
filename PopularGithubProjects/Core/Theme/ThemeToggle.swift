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
                Button {
                    if themeManager.current != theme {
                        withAnimation(.smooth(duration: 0.4, extraBounce: 0.5)) {
                            themeManager.current = theme
                            isAnimating = true
                        }

                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            isAnimating = false
                        }
                    }
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: theme.icon)
                            .scaleEffect(themeManager.current == theme && isAnimating ? 1.2 : 1.0)
                        Text(theme.label)
                    }
                   // .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .frame(width: 95)
                    .background(themeManager.current == theme ? Color.accentColor : .clear)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .foregroundStyle(themeManager.current == theme ? .white : .primary)
                .animation(.spring(response: 0.3, dampingFraction: 0.7), value: themeManager.current)
            }
        }
        .padding(3)
        .background(.clear)
        .scaleEffect(isAnimating ? 0.95 : 1.0)
    }
}
