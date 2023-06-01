//
//  GitViewModel.swift
//  Assignment
//
//  Created by kashif on 6/1/23.
//

import Foundation

final class GitViewModel {
    typealias Observer<T> = (T) -> Void
    
    private let gitLoader: GitLoader
    
    init(gitLoader: GitLoader) {
        self.gitLoader = gitLoader
    }
    
    var onLoadingStateChange: Observer<Bool>?
    var onGitLoad: Observer<[GitModel]>?
    
    func loadFeed(username: String) {
        onLoadingStateChange?(true)
        gitLoader.load(username: username) { [weak self] result in
            if let git = try? result.get() {
                self?.onGitLoad?([git])
            } else {
                self?.onGitLoad?([])
            }
            self?.onLoadingStateChange?(false)
        }
    }
    
}


