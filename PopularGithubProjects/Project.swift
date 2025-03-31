//
//  Project.swift
//  PopularGithubProjects
//
//  Created by Michal Fereniec on 30/03/2025.
//

import Foundation
import SwiftData

@Model
class Project {
    var name: String
    var details: String
    var date: Date
    var stars: Int
    
    init(name: String = "", details: String = "", date: Date = .now, stars: Int = 0) {
        self.name = name
        self.details = details
        self.date = date
        self.stars = stars
    }
}
