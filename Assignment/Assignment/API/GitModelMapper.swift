//
//  GitMapper.swift
//  Assignment
//
//  Created by kashif on 6/1/23.
//

import Foundation

final  class GitModelMapper {
    static var OK_200: Int { return 200 }
    
    static func map(_ data: Data, _ response: HTTPURLResponse) throws -> RemoteGitModel {
        guard response.statusCode == OK_200,
              let root = try?  JSONDecoder().decode(RemoteGitModel.self, from: data) else {
            throw RemoteGitLoader.Error.invalidData
        }
        
        return root
    }
}

final  class FollowerGitModelMapper {
    static var OK_200: Int { return 200 }
    
    static func map(_ data: Data, _ response: HTTPURLResponse) throws -> [RemoteGitModel] {
        guard response.statusCode == OK_200,
              let root = try?  JSONDecoder().decode([RemoteGitModel].self, from: data) else {
            throw RemoteGitLoader.Error.invalidData
        }
        
        return root
    }
}
