//
//  GithubResponses.swift
//  GithubRecents
//
//  Created by Nick Hawryluk on 8/21/21.
//

import Foundation


struct GetCommitsResponse {
    public var error : Error?
    public var commits : [Commit]?
}

