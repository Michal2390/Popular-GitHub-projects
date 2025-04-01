//
//  Project.swift
//  PopularGithubProjects
//
//  Created by Michal Fereniec on 30/03/2025.
//

import Foundation
import SwiftData

@Model
class ProjectEntity {
    var id: Int
    var name: String
    var fullName: String
    var projectDescription: String?
    @Relationship(deleteRule: .cascade) var owner: OwnerEntity?
    var isPrivate: Bool
    var htmlUrl: String
    var stars: Int
    var language: String?
    var forksCount: Int
    var openIssuesCount: Int
    @Relationship(deleteRule: .cascade) var license: LicenseEntity?
    var createdAt: Date
    var updatedAt: Date
    
    init(id: Int = 0,
         name: String = "",
         fullName: String = "",
         projectDescription: String? = nil,
         owner: OwnerEntity? = nil,
         isPrivate: Bool = false,
         htmlUrl: String = "",
         stars: Int = 0,
         language: String? = nil,
         forksCount: Int = 0,
         openIssuesCount: Int = 0,
         license: LicenseEntity? = nil,
         createdAt: Date = .now,
         updatedAt: Date = .now) {
        self.id = id
        self.name = name
        self.fullName = fullName
        self.projectDescription = projectDescription
        self.owner = owner
        self.isPrivate = isPrivate
        self.htmlUrl = htmlUrl
        self.stars = stars
        self.language = language
        self.forksCount = forksCount
        self.openIssuesCount = openIssuesCount
        self.license = license
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    convenience init(from model: ProjectModel) {
        self.init(
            id: model.id,
            name: model.name,
            fullName: model.fullName,
            projectDescription: model.description,
            owner: model.owner.map { OwnerEntity(from: $0) },
            isPrivate: model.isPrivate,
            htmlUrl: model.htmlUrl,
            stars: model.stars,
            language: model.language,
            forksCount: model.forksCount,
            openIssuesCount: model.openIssuesCount,
            license: model.license.map { LicenseEntity(from: $0) },
            createdAt: model.createdAt,
            updatedAt: model.updatedAt
        )
    }
    
    func toModel() -> ProjectModel {
        ProjectModel(
            id: self.id,
            name: self.name,
            fullName: self.fullName,
            description: self.projectDescription,
            owner: self.owner?.toModel(),
            isPrivate: self.isPrivate,
            htmlUrl: self.htmlUrl,
            stars: self.stars,
            language: self.language,
            forksCount: self.forksCount,
            openIssuesCount: self.openIssuesCount,
            license: self.license?.toModel(),
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
}

// MARK: - API Model
struct ProjectModel: Codable, Hashable {
    let id: Int
    let name: String
    let fullName: String
    let description: String?
    let owner: OwnerModel?
    let isPrivate: Bool
    let htmlUrl: String
    let stars: Int
    let language: String?
    let forksCount: Int
    let openIssuesCount: Int
    let license: LicenseModel?
    let createdAt: Date
    let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, owner, language
        case fullName = "full_name"
        case isPrivate = "private"
        case htmlUrl = "html_url"
        case stars = "stargazers_count"
        case forksCount = "forks_count"
        case openIssuesCount = "open_issues_count"
        case license
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: ProjectModel, rhs: ProjectModel) -> Bool {
        lhs.id == rhs.id
    }
}
