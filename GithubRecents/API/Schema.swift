//
//  Schema.swift
//  GithubRecents
//
//  Created by Nick Hawryluk on 8/21/21.
//

import Foundation

// MARK: - Commit
public struct Commit : Codable {
    public let sha: String
    public let commit: CommitClass

    public init(sha: String, commit: CommitClass) {
        self.sha = sha
        self.commit = commit
    }
}

// MARK: - CommitClass
public struct CommitClass : Codable {
    public let author: CommitAuthorClass
    public let message: String

    public init(author: CommitAuthorClass, message: String) {
        self.author = author
        self.message = message
    }
}

// MARK: - CommitAuthorClass
public struct CommitAuthorClass : Codable {
    public let name: String
    public let email: String
    public let date: String

    public init(name: String, email: String, date: String) {
        self.name = name
        self.email = email
        self.date = date
    }
}





