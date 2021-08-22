//
//  CommitTableViewCell.swift
//  GithubRecents
//
//  Created by Nick Hawryluk on 8/21/21.
//

import UIKit

class CommitTableViewCell: UITableViewCell {
    @IBOutlet var authorLabel : UILabel!
    @IBOutlet var shaLabel : UILabel!
    @IBOutlet var messageLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func inflateFrom(commit : Commit){
        self.authorLabel.text = commit.commit.author.name
        self.shaLabel.text = commit.sha
        self.messageLabel.text = commit.commit.message
    }
    
}
