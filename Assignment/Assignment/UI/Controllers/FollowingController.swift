//
//  FollowingController.swift
//  Assignment
//
//  Created by kashif on 6/1/23.
//

import UIKit

public class FollowingController: UITableViewController {
    
    var tableModel = [GitModel]() {
        didSet { DispatchQueue.main.async {
            self.tableView.reloadData()
        } }
    }
    
    public var followingViewModel: FollowingViewModel?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        followingViewModel?.loadFollow()
        getFollowing()
    }
    
    @IBAction func refresh() {
        followingViewModel?.loadFollow()
    }
    
    func getFollowing() {
        followingViewModel?.onFollowerLoad = { [weak self] followers in
            self!.tableModel = followers
            DispatchQueue.main.async {self?.tableView.reloadData()}
        }
        
        followingViewModel?.onLoadingStateChange = { [weak self] loading in
            DispatchQueue.main.async {
                if(loading) {
                    self!.refreshControl?.beginRefreshing()
                } else {
                    self!.refreshControl?.endRefreshing()
                }
            }
        }
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableModel.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FollowerCell = tableView.dequeueReusableCell()
        cell.idLabel.text = "\(tableModel[indexPath.row].id)"
        cell.userName.text = tableModel[indexPath.row].username
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToProfile(username: tableModel[indexPath.row].username!)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func navigateToProfile(username: String) {
        let remoteURL = URL(string: "https://api.github.com/users/")!
        let remoteClient = makeRemoteClient()
        let remoteGitLoader = RemoteGitLoader(url: remoteURL, client: remoteClient)
        let profileViewController = GitUIComposer.profileComposedWith(gitLoader: MainQueueDispatchDecorator(decoratee: remoteGitLoader))
        profileViewController.userName = username
        navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    func makeRemoteClient() -> HTTPClient {
        return URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    }
}
