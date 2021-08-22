//
//  GithubAPI.swift
//  GithubRecents
//
//  Created by Nick Hawryluk on 8/21/21.
//

import Foundation

enum APIError : Error {
    case malformedURL
    case httpError
    case responseError
    case parseError
}

class GithubAPI {
    static let shared = GithubAPI()
    
    //the base URL of the github API- this will have the full path appended to it per request
    private let endpoint : String = "https://api.github.com"
    
    
    //MARK: API Methods
    ///This function will return the commits to a specific repo base on the supplied username and repo name as defined by: https://docs.github.com/en/rest/reference/repos#list-commits
    /// ```
    /// getCommits(user: "nick-havz", repo: "GithubRecents", limit: 30) {
    ///     //implementation
    /// }
    /// ```
    /// - Parameter user: The user name to search for
    /// - Parameter repo: The repository to pull commits from
    /// - Parameter limit: The max results (default: 100, max: 100)
    /// - Parameter onComplete: The callback to execute after request
    func getCommits(user : String, repo : String, limit: Int, onComplete : @escaping (_ : GetCommitsResponse) -> Void){
        guard let requestURL = URL(string: "\(self.endpoint)/repos/\(user)/\(repo)/commits") else {
            //we were unable to create the URL from the string - return an error and break
            debugPrint("failed to create URL from string: \(self.endpoint)/repos/\(user)/\(repo)/commits)")
            onComplete(GetCommitsResponse(error: APIError.malformedURL, commits: nil))
            return
        }
        
        var apiRequest = URLRequest(url: requestURL)
        apiRequest.httpMethod = "GET"
        apiRequest.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        let getCommitsTask = URLSession.shared.dataTask(with: apiRequest) { data, response, error in
            if let error = error {
                debugPrint("\(error.localizedDescription)")
                //we received an error from the api request (this is probably a networking error)
                onComplete(GetCommitsResponse(error: error, commits: nil))
                return
            }
            if let data = data {
                do{
                    let commits = try JSONDecoder().decode([Commit].self, from: data)
                    onComplete(GetCommitsResponse(error: nil, commits: commits))
                    
                }catch{
                    onComplete(GetCommitsResponse(error: APIError.parseError, commits: nil))
                    debugPrint("failed to decode response : \(error.localizedDescription)")
                }
                
            }
            else{
                debugPrint("Failed to parse response data")
                onComplete(GetCommitsResponse(error: APIError.responseError, commits: nil))
            }
            
        }
        getCommitsTask.resume()
    }
}
