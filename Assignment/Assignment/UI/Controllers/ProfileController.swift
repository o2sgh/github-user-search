//
//  ProfileController.swift
//  Assignment
//
//  Created by kashif on 6/1/23.
//

import UIKit
import SDWebImage

public class ProfileController: UIViewController {
    var viewModel: GitViewModel?
    var userName: String?
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var avatarview: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
        viewModel?.loadFeed(username: userName!)
    }
    
    func updateView() {
        viewModel?.onGitLoad = { [weak self] model in
            guard let self = self else { return }
            DispatchQueue.main.async {
                let firstUser = model.first
                self.avatar.sd_setImage(with: URL(string: firstUser!.avatarURL), placeholderImage: UIImage(named: "placeholder.png"))
                self.idLabel.text = "\(firstUser!.id)"
                self.nameLabel.text = firstUser?.name
                self.usernameLabel.text = firstUser?.username
                self.followersLabel.text = "\(firstUser!.followers!) followeres"
                self.followingLabel.text = "\(firstUser!.following!) following"
                self.descriptionLabel.text = firstUser?.description
            }
        }
        
        viewModel?.onLoadingStateChange = { [weak self] loading in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if(loading) {
                    self.activityIndicator.isHidden = false
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.isHidden = true
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
}
