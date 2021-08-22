//
//  UserInputViewController.swift
//  GithubRecents
//
//  Created by Nick Hawryluk on 8/21/21.
//

import UIKit

class UserInputViewController: UIViewController {
    enum ViewState {
        case normal
        case loading
    }
    
    private let SHOW_RESULTS_SEGUE_IDENTIFIER = "showResults"
    
    @IBOutlet weak var usernameTextfield : UITextField!
    @IBOutlet weak var repoTextField : UITextField!
    @IBOutlet weak var maxCommitsTextField : UITextField!
    @IBOutlet weak var fetchButton: UIButton!
    @IBOutlet weak var spinner : UIActivityIndicatorView!
    
    //MARK: - Default Search Values
    private let DEFAULT_USERNAME : String = "nick-havz"
    private let DEFAULT_REPO : String = "GithubRecents"
    private let DEFAULT_MAX_COMMITS : String = "100"
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(UserInputViewController.onBaseViewTap(_:))))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setView(state: .normal)
    }
    
    @objc func onBaseViewTap(_ gesture : UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    ///Set the view state of the loading spinner and fetch buttons
    private func setView(state : ViewState){
        spinner.isHidden = state == .normal
        fetchButton.isEnabled = state == .normal
        if (state == .loading){ spinner.startAnimating() }
        else if (state == .normal){ spinner.stopAnimating() }
    }
    
    ///Communicate with the API class to load the commits based on the supplied parameters
    private func loadCommits(username : String, repo : String, maxCount : Int){
        GithubAPI.shared.getCommits(user: username, repo: repo, limit: maxCount) { response in
            if let _ = response.error {
                let alert = UIAlertController(title: "Error", message: "An error was received processing the request", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    self.setView(state: .normal)
                }))
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
            }
            //we got a response back from the API
            else{
                guard let results = response.commits else{
                    let alert = UIAlertController(title: "Empty", message: "No results were available for that user/repo pair. This can happen if they dont exist or the repo is private", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        self.setView(state: .normal)
                    }))
                    DispatchQueue.main.async {
                        self.present(alert, animated: true, completion: nil)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: self.SHOW_RESULTS_SEGUE_IDENTIFIER, sender: results)
                }
            }
            
        }
    }
    
    //MARK: - IBActions
    ///IBAction for the Storyboard Fetch Button
    @IBAction func onFetchButtonTap(_ sender : AnyObject){
        view.endEditing(true)
        
        var username = usernameTextfield.text
        username = username == "" ? DEFAULT_USERNAME : username
        var repo = repoTextField.text
        repo = repo == "" ? DEFAULT_REPO : repo
        var maxCommitsText = maxCommitsTextField.text
        maxCommitsText = maxCommitsText == "" ? DEFAULT_MAX_COMMITS : maxCommitsText
        guard let maxCommits = Int(maxCommitsText!) else {
            debugPrint("unable to parse int value from textfield : \(String(describing: maxCommitsText?.debugDescription))")
            let alert = UIAlertController(title: "Ooops", message: "Invalid value supplied for max commits - expecting a number", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                self.maxCommitsTextField.text = ""
            }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        setView(state: .loading)
        
        loadCommits(username: username!, repo: repo!, maxCount: maxCommits)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == SHOW_RESULTS_SEGUE_IDENTIFIER){
            guard let commits = sender as? [Commit] else{
                return
            }
            
        }
    }

}
