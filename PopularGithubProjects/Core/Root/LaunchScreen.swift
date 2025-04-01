//
//  LaunchScreen.swift
//  PopularGithubProjects
//
//  Created by Michal Fereniec on 30/03/2025.
//

import SwiftUI

struct LaunchScreen: View {
    var body: some View {
        ZStack {
            Color.accentColor.ignoresSafeArea()
            VStack {
                Image("PopularGHProjAppIcon")
                    .resizable()
                    .frame(width: 200, height: 200)
            }
        }
    }
}

#Preview {
    LaunchScreen()
}
