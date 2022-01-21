//
//  DataModels.swift
//  TrueNothReddit
//
//  Created by Manuel Alvarez on 1/21/22.
//

import Foundation

    // MARK: - Welcome
struct Welcome: Codable {
    var kind: String?
    var data: WelcomeData?
}

    // MARK: - WelcomeData
struct WelcomeData: Codable {
    var after: String?
    var dist: Int?
    var modhash, geoFilter: String?
    var children: [Child]?
    var before: String?
    
    enum CodingKeys: String, CodingKey {
        case after, dist, modhash
        case geoFilter = "geo_filter"
        case children, before
    }
}

    // MARK: - Child
struct Child: Codable {
    var data: ChildData?
}

// MARK: - ChildData
struct ChildData: Codable {
    var authorFullname: String?
    var title: String?
    var thumbnail: String?
    var visited: Bool?
    var author: String?
    var numComments: Int?
    var url: String?
    var createdUTC: Int?
    var urlOverriddenByDest: String?
    var name: String?
    
    enum CodingKeys: String, CodingKey {

        case authorFullname = "author_fullname"
        case title, thumbnail, visited, author, url, name
        case createdUTC = "created_utc"
        case numComments = "num_comments"
        case urlOverriddenByDest = "url_overridden_by_dest"

    }
}
