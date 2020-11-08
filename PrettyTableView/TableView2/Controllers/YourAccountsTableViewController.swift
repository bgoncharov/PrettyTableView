//
//  YourAccountsTableViewController.swift
//  PrettyTableView
//
//  Created by Boris Goncharov on 11/7/20.
//

import Foundation
import UIKit

class YourAccountsTableViewController: UITableViewController {
    
    fileprivate let CELL_ID = "CELL_ID"
        
    var socialAccounts: [[SocialAccount]] = [
        [SocialAccount(title: "Twitter", url: "https://twitter.com/bgoncharov", imageUrl: "twitter"),
         SocialAccount(title: "Facebook", url: "https://facebook.com/bgoncharovs", imageUrl: "facebook"),
         SocialAccount(title: "Instagram", url: "https://instagram.com/bgoncharov", imageUrl: "instagram")
        ],
        [
            SocialAccount(title: "Twitter", url: "https://twitter.com/bgoncharov", imageUrl: "twitter"),

        ]
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupTableView()
        setupBarButtonItems()
    }

    fileprivate func setupBarButtonItems() {
        let item: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewSocialAccaunt))
        
        navigationItem.rightBarButtonItem = item
    }
    
    @objc fileprivate func addNewSocialAccaunt() {
        let newAccountSocialController = NewSocialAccountViewController()
        newAccountSocialController.delegate = self
        let newAccountNavigationViewController = UINavigationController(rootViewController: newAccountSocialController)
        
        newAccountNavigationViewController.modalPresentationStyle = .fullScreen
        present(newAccountNavigationViewController, animated: true, completion: nil)
    }
    
    private func setupTableView() {
        title = "Your Accounts"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(SocialAccountCell.self, forCellReuseIdentifier: CELL_ID)
        tableView.allowsSelection = false
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return socialAccounts[section].count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as! SocialAccountCell
        let socialAccount = socialAccounts[indexPath.section][indexPath.row]
        cell.socialAccount = socialAccount
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        socialAccounts.count
    }
    
    // Header
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let label = UILabel()
        
        label.text = section == 0 ? "My Accouts" : "Favorite Accounts"
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    // Row Actions
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (contextualAction, view, boolVallue) in
            print("edit the row \(indexPath.row)")
        }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, boolValue) in
            self.socialAccounts[indexPath.section].remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
        
        editAction.backgroundColor = UIColor.blue.withAlphaComponent(0.7)
        let actions = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        return actions
    }
}

extension YourAccountsTableViewController: NewSocialAccountDelegate {
    func newSocialAccount(title: String, url: String) {
        let newAccount = SocialAccount(title: title, url: url, imageUrl: "facebook")
        let section = 1
//        let row = self.socialAccounts[section].count
//        let insertionIndexPath = IndexPath(row: row, section: section)
        self.socialAccounts[section].append(newAccount)
//        tableView.insertRows(at: [insertionIndexPath], with: .automatic)
        tableView.reloadData()
    }

}
