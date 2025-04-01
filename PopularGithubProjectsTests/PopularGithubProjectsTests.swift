//
//  PopularGithubProjectsTests.swift
//  PopularGithubProjectsTests
//
//  Created by Michal Fereniec on 30/03/2025.
//

import XCTest
import SwiftData
@testable import PopularGithubProjects

final class PopularGithubProjectsTests: XCTestCase {
    
    var modelContainer: ModelContainer!
    var modelContext: ModelContext!
    
    override func setUpWithError() throws {
        let schema = Schema([ProjectEntity.self, OwnerEntity.self, LicenseEntity.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
    }
    
    override func tearDownWithError() throws {
        modelContainer = nil
        modelContext = nil
    }
    
    func testProjectEntityCreation() throws {
        let projectModle = ProjectModel(
            id: 69,
            name: "Havi Rain Nygaard",
            fullName: "Aimbot machine",
            description: "In Faze since 2016",
            owner: nil, //karrigan
            isPrivate: true,
            htmlUrl: "https://github.com/AimbotMachine",
            stars: 420,
            language: "Norwegian",
            forksCount: 5,
            openIssuesCount: 2,
            license: nil,
            createdAt: .now,
            updatedAt: .now
        )
        
        let projectEntity = ProjectEntity(from: projectModle)
        
        XCTAssertEqual(projectEntity.id, projectModle.id)
        XCTAssertEqual(projectEntity.name, projectModle.name)
        XCTAssertEqual(projectEntity.fullName, projectModle.fullName)
        XCTAssertEqual(projectEntity.projectDescription, projectModle.description)
        XCTAssertEqual(projectEntity.stars, projectModle.stars)
        XCTAssertEqual(projectEntity.language, projectModle.language)
    }
    
    func testProjectModelToEntityConversion() throws {
        let owner = OwnerModel(
            id: 23,
            login: "yes",
            avatarUrl: "url.com",
            htmlUrl: "https://github.com/yes",
            type: "User"
        )
        
        let license = LicenseModel(
            key: "klucz",
            name: "bardzo wazny",
            url: "https://website.com/yes",
            spdxId: "MIT"
        )
        
        let projectModel = ProjectModel(
            id: 1,
            name: "test",
            fullName: "testing/test",
            description: "Test description",
            owner: owner, //karrigan
            isPrivate: false,
            htmlUrl: "https://github.com/testing/test",
            stars: 32,
            language: "Swift",
            forksCount: 54,
            openIssuesCount: 2,
            license: license,
            createdAt: .now,
            updatedAt: .now
        )
        
        let projectEntity = ProjectEntity(from: projectModel)
        let convertedModel = projectEntity.toModel()
        
        XCTAssertEqual(convertedModel.id, projectModel.id)
        XCTAssertEqual(convertedModel.name, projectModel.name)
        XCTAssertEqual(convertedModel.owner?.login, projectModel.owner?.login)
        XCTAssertEqual(convertedModel.license?.name, projectModel.license?.name)
    }
    
}
