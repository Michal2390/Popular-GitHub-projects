//
//  ThemeButton.swift
//  PopularGithubProjects
//
//  Created by Michal Fereniec on 01/04/2025.
//

import SwiftUI

struct ThemeButton: View {
    let theme: Theme
    let isSelected: Bool
    let isAnimating: Bool
    let action: () -> ()
    
    var body: some View {
        Button(action: action) {
            Image(systemName: theme.icon)
                .scaleEffect(isSelected && isAnimating ? 1.2 : 1.0)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .frame(width: 45)
                .background(isSelected ? Color.accentColor : .clear)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .foregroundStyle(isSelected ? .white : .primary)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isSelected)
    }
}

#Preview {
    ThemeButton(theme: Theme.light, isSelected: false, isAnimating: false, action: { })
}
