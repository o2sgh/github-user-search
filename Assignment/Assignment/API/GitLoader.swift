//
//  GitLoader.swift
//  Assignment
//
//  Created by kashif on 6/1/23.
//

import Foundation

public protocol GitLoader {
    typealias Result = Swift.Result<GitModel, Error>
    
    func load(username: String, completion: @escaping (Result) -> Void)
}

public protocol FollowerLoader {
    typealias Result = Swift.Result<[GitModel], Error>
    
    func load(completion: @escaping (Result) -> Void)
}
