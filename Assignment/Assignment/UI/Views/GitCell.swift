//
//  GitCell.swift
//  Assignment
//
//  Created by kashif on 6/1/23.
//

import UIKit

public final class GitCell: UITableViewCell {
    @IBOutlet private(set) public var usernameLabel: UILabel!
    @IBOutlet private(set) public var nameLabel: UILabel!
    @IBOutlet private(set) public var descriptionLabel: UILabel!
    @IBOutlet private(set) public var avatarImageView: UIImageView!
    @IBOutlet private(set) public var avatarImageViewContainer: UIView!
    @IBOutlet private(set) public var followerButton: UIButton!
    @IBOutlet private(set) public var followingButton: UIButton!
    
    var onFollowerTapped: (() -> Void)?
    var onFollowingTapped: (() -> Void)?
    
    @IBAction private func followerButtonTapped() {
        onFollowerTapped?()
    }
    
    @IBAction private func followingButtonTapped() {
        onFollowingTapped?()
    }
}
