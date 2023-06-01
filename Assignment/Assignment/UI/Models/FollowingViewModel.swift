//
//  FollowerViewModel.swift
//  Assignment
//
//  Created by kashif on 6/1/23.
//

import Foundation

public final class FollowingViewModel {
    typealias Observer<T> = (T) -> Void
    
    private let followerLoader: FollowerLoader
    
    init(followerLoader: FollowerLoader) {
        self.followerLoader = followerLoader
    }
    
    var onLoadingStateChange: Observer<Bool>?
    var onFollowerLoad: Observer<[GitModel]>?
    
    func loadFollow() {
        onLoadingStateChange?(true)
        followerLoader.load { [weak self] result in
            if let followers = try? result.get() {
                self?.onFollowerLoad?(followers)
            }
            self?.onLoadingStateChange?(false)
        }
    }
    
}


