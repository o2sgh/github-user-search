//
//  FollowerLoader.swift
//  Assignment
//
//  Created by kashif on 6/1/23.
//

import Foundation

public final class RemoteFollowerLoader: FollowerLoader {
    private var url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public typealias Result = FollowerLoader.Result
    
    public init(url: URL, client: HTTPClient) {
        self.client = client
        self.url = url
    }
    
    public func load(completion: @escaping (Result) -> Void) {
        client.get(from: url) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case let  .success((data, response)):
                completion(RemoteFollowerLoader.map(data, from: response))
                
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
    
    private static func map(_ data: Data, from response: HTTPURLResponse) -> Result {
        do {
            let items = try FollowerGitModelMapper.map(data, response)
            return .success(items.toModels())
        } catch {
            return .failure(error)
        }
    }
}

private extension Array where Element == RemoteGitModel {
    func toModels() -> [GitModel] {
        return map { GitModel(id: $0.id, avatarURL: $0.avatar_url, username: $0.login, name: $0.name, description: $0.bio, followers: $0.followers, following: $0.following) }
    }
}
