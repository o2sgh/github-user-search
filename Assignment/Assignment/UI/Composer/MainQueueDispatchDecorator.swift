//
//  MainQueueDispatchDecorator.swift
//  Assignment
//
//  Created by kashif on 6/1/23.
//

import Foundation

final class MainQueueDispatchDecorator<T> {
    private let decoratee: T
    
    init(decoratee: T) {
        self.decoratee = decoratee
    }
    
    func dispatch(completion: @escaping () -> Void) {
        guard Thread.isMainThread else {
            return DispatchQueue.main.async(execute: completion)
        }
        
        completion()
    }
}

extension MainQueueDispatchDecorator: GitLoader where T == GitLoader{
    func load(username: String, completion: @escaping (GitLoader.Result) -> Void) {
        decoratee.load(username: username) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}
