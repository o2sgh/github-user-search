//
//  GitController.swift
//  Assignment
//
//  Created by kashif on 6/1/23.
//

import UIKit
import SDWebImage

public class GitController: UIViewController {
    var viewModel: GitViewModel?
    @IBOutlet weak var userimage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var userDescription: UILabel!
    @IBOutlet weak var followersButton: UIButton!
    @IBOutlet weak var followingButton: UIButton!
    @IBOutlet weak var notFoundLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mainStack: UIStackView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        mainStack.isHidden = true
        notFoundLabel.text = "Search for User"
        updateView()
    }
    
    @IBAction func followerBtnTapped(_ sender: UIButton) {
        let remoteURL = URL(string: "https://api.github.com/users/\(username.text!)/followers")!
        let remoteClient = makeRemoteClient()
        let remoteFollowingLoader = RemoteFollowerLoader(url: remoteURL, client: remoteClient)
        let followingController = GitUIComposer.followingComposedWith(followerLoader: remoteFollowingLoader)
        navigationController?.pushViewController(followingController, animated: true)
    }
    
    @IBAction func followingBtnTapped(_ sender: UIButton) {
        let remoteURL = URL(string: "https://api.github.com/users/\(username.text!)/following")!
        let remoteClient = makeRemoteClient()
        let remoteFollowingLoader = RemoteFollowerLoader(url: remoteURL, client: remoteClient)
        let followingController = GitUIComposer.followingComposedWith(followerLoader: remoteFollowingLoader)
        navigationController?.pushViewController(followingController, animated: true)
    }
    
    func makeRemoteClient() -> HTTPClient {
        return URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    }
    
    func updateView() {
        viewModel?.onGitLoad = { [weak self] model in
            guard let self = self else { return }
            DispatchQueue.main.async {
                let firstUser = model.first
                if(model.isEmpty) {
                    self.hideNoFoundView(condition: false)
                    self.notFoundLabel.text = "User not found"
                } else {
                    self.hideNoFoundView(condition: true)
                    self.userimage.sd_setImage(with: URL(string: firstUser!.avatarURL), placeholderImage: UIImage(named: "placeholder.png"))
                    self.username.text = firstUser?.username
                    self.name.text = firstUser?.name
                    self.userDescription.text = firstUser?.description ?? "No Description"
                    self.followersButton.setTitle("\(firstUser?.followers ?? 0) Followers", for: .normal)
                    self.followingButton.setTitle("\(firstUser?.following ?? 0) Following", for: .normal)
                }
            }
        }
    }
    
    func hideNoFoundView(condition: Bool) {
        self.mainStack.isHidden = !condition
        self.notFoundLabel.isHidden = condition
    }
}

extension GitController: UISearchBarDelegate {
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel?.loadFeed(username: searchBar.searchTextField.text ?? "")
    }
}
