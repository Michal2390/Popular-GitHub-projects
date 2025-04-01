//
//  License.swift
//  PopularGithubProjects
//
//  Created by Michal Fereniec on 01/04/2025.
//
import Foundation
import SwiftData

@Model
class LicenseEntity {
    var key: String
    var name: String
    var url: String?
    var spdxId: String?
    
    init(key: String = "",
         name: String = "",
         url: String? = nil,
         spdxId: String? = nil) {
        self.key = key
        self.name = name
        self.url = url
        self.spdxId = spdxId
    }
    
    convenience init(from model: LicenseModel) {
        self.init(
            key: model.key,
            name: model.name,
            url: model.url,
            spdxId: model.spdxId
        )
    }
    
    func toModel() -> LicenseModel {
        LicenseModel(
            key: self.key,
            name: self.name,
            url: self.url,
            spdxId: self.spdxId
        )
    }
}

// MARK: - API Model
struct LicenseModel: Codable, Hashable {
    let key: String
    let name: String
    let url: String?
    let spdxId: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(key)
        hasher.combine(name)
    }
        
    static func == (lhs: LicenseModel, rhs: LicenseModel) -> Bool {
        lhs.key == rhs.key &&
        lhs.name == rhs.name
    }
}
