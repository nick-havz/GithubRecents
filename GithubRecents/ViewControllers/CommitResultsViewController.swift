//
//  CommitResultsViewController.swift
//  GithubRecents
//
//  Created by Nick Hawryluk on 8/21/21.
//

import UIKit

class CommitResultsViewController: UIViewController {
    private var REUSE_IDENTIFIER : String = "COMMIT_CELL"
    
    var commits : [Commit]!
    
    @IBOutlet weak var commitsTableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commitsTableView.register(UINib.init(nibName: "CommitTableViewCell", bundle: nil), forCellReuseIdentifier: REUSE_IDENTIFIER)
    }
}

extension CommitResultsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: REUSE_IDENTIFIER, for: indexPath) as! CommitTableViewCell
        cell.inflateFrom(commit: commits[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commits.count
    }
}

extension CommitResultsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //we're not doing anything on selection
    }
}
