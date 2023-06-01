//
//  RemoteGitModel.swift
//  Assignment
//
//  Created by kashif on 6/1/23.
//

import Foundation

struct RemoteGitModel: Decodable {
    let id: Int
    let login: String?
    let avatar_url: String
    let name: String?
    let bio: String?
    let followers: Int?
    let following: Int?
}

    //{
    //    "login": "UI10",
    //    "id": 58115993,
    //    "node_id": "MDQ6VXNlcjU4MTE1OTkz",
    //    "avatar_url": "https://avatars.githubusercontent.com/u/58115993?v=4",
    //    "gravatar_id": "",
    //    "url": "https://api.github.com/users/UI10",
    //    "html_url": "https://github.com/UI10",
    //    "followers_url": "https://api.github.com/users/UI10/followers",
    //    "following_url": "https://api.github.com/users/UI10/following{/other_user}",
    //    "gists_url": "https://api.github.com/users/UI10/gists{/gist_id}",
    //    "starred_url": "https://api.github.com/users/UI10/starred{/owner}{/repo}",
    //    "subscriptions_url": "https://api.github.com/users/UI10/subscriptions",
    //    "organizations_url": "https://api.github.com/users/UI10/orgs",
    //    "repos_url": "https://api.github.com/users/UI10/repos",
    //    "events_url": "https://api.github.com/users/UI10/events{/privacy}",
    //    "received_events_url": "https://api.github.com/users/UI10/received_events",
    //    "type": "User",
    //    "site_admin": false,
    //    "name": "UI",
    //    "company": null,
    //    "blog": "",
    //    "location": null,
    //    "email": null,
    //    "hireable": true,
    //    "bio": null,
    //    "twitter_username": null,
    //    "public_repos": 5,
    //    "public_gists": 0,
    //    "followers": 0,
    //    "following": 1,
    //    "created_at": "2019-11-23T16:43:46Z",
    //    "updated_at": "2023-03-03T13:50:54Z"
    //}
