//
//  RemoteLoader.swift
//  Assignment
//
//  Created by kashif on 6/1/23.
//

import Foundation

public final class RemoteGitLoader: GitLoader {
    private var url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public typealias Result = GitLoader.Result
    
    public init(url: URL, client: HTTPClient) {
        self.client = client
        self.url = url
    }
    
    public func load(username: String, completion: @escaping (Result) -> Void) {
        url.append(path: username)
        client.get(from: url) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case let  .success((data, response)):
                print("data => \(String(data: data, encoding: .utf8))")
                completion(RemoteGitLoader.map(data, from: response))

            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
    
    private static func map(_ data: Data, from response: HTTPURLResponse) -> Result {
        do {
            let items = try GitModelMapper.map(data, response)
            let gitModel = GitModel(id: items.id, avatarURL: items.avatar_url, username: items.login, name: items.name, description: items.bio, followers: items.followers, following: items.following)
            return .success(gitModel)
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
