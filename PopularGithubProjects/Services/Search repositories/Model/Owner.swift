//
//  Owner.swift
//  PopularGithubProjects
//
//  Created by Michal Fereniec on 01/04/2025.
//
import Foundation
import SwiftData

@Model
class OwnerEntity {
    var id: Int
    var login: String
    var avatarUrl: String
    var htmlUrl: String
    var type: String
    
    init(id: Int = 0,
         login: String = "",
         avatarUrl: String = "",
         htmlUrl: String = "",
         type: String = "User") {
        self.id = id
        self.login = login
        self.avatarUrl = avatarUrl
        self.htmlUrl = htmlUrl
        self.type = type
    }
    
    convenience init(from model: OwnerModel) {
        self.init(
            id: model.id,
            login: model.login,
            avatarUrl: model.avatarUrl,
            htmlUrl: model.htmlUrl,
            type: model.type
        )
    }
    
    func toModel() -> OwnerModel {
        OwnerModel(
            id: self.id,
            login: self.login,
            avatarUrl: self.avatarUrl,
            htmlUrl: self.htmlUrl,
            type: self.type
        )
    }
}

// MARK: - API Model
struct OwnerModel: Codable, Hashable {
    let id: Int
    let login: String
    let avatarUrl: String
    let htmlUrl: String
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case id, login, type
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
        
    static func == (lhs: OwnerModel, rhs: OwnerModel) -> Bool {
        lhs.id == rhs.id
    }
}
