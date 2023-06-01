//
//  GitUIComposer.swift
//  Assignment
//
//  Created by kashif on 6/1/23.
//

import UIKit

public final class GitUIComposer {
    private init() {}
    
    public static func gitComposedWith(gitLoader: GitLoader) -> GitController {
        let gitViewModel = GitViewModel(gitLoader: gitLoader)
        let gitController = makeWithController()
        gitController.viewModel = gitViewModel
        return gitController
    }
    
    public static func followingComposedWith(followerLoader: FollowerLoader) -> FollowingController {
        let followingViewModel = FollowingViewModel(followerLoader: followerLoader)
        let followingController = makeWithFollowingController()
        followingController.followingViewModel = followingViewModel
        return followingController
    }
    
    public static func profileComposedWith(gitLoader: GitLoader) -> ProfileController {
        let gitViewModel = GitViewModel(gitLoader: gitLoader)
        let profileController = makeWithProfileController()
        profileController.viewModel = gitViewModel
        return profileController
    }

    
    private static func makeWithController() -> GitController {
        let bundle = Bundle(for: GitController.self)
        let storyboard = UIStoryboard(name: "Git", bundle: bundle)
        let gitController = storyboard.instantiateInitialViewController() as! GitController
        return gitController
    }
    
    private static func makeWithProfileController() -> ProfileController {
        let bundle = Bundle(for: ProfileController.self)
        let storyboard = UIStoryboard(name: "Profile", bundle: bundle)
        let profileController = storyboard.instantiateInitialViewController() as! ProfileController
        return profileController
    }
    
    private static func makeWithFollowingController() -> FollowingController {
        let bundle = Bundle(for: FollowingController.self)
        let storyboard = UIStoryboard(name: "Followers", bundle: bundle)
        let followingController = storyboard.instantiateInitialViewController() as! FollowingController
        return followingController
    }
}
