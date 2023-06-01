//
//  GitItem.swift
//  Assignment
//
//  Created by kashif on 6/1/23.
//

import Foundation

public struct GitModel: Equatable {
    public let id: Int
    public let avatarURL: String
    public let username: String?
    public let name: String?
    public let description: String?
    public let followers: Int?
    public let following: Int?
    
    init(id: Int, avatarURL: String, username: String?, name: String?, description: String?, followers: Int?, following: Int?) {
        self.id = id
        self.avatarURL = avatarURL
        self.username = username
        self.name = name
        self.description = description
        self.followers = followers
        self.following = following
    }
}
