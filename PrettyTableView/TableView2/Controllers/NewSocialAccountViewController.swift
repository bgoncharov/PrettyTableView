//
//  NewSocialAccountViewController.swift
//  PrettyTableView
//
//  Created by Boris Goncharov on 11/7/20.
//

import UIKit

class NewSocialAccountViewController: UIViewController {
    
    let titleField = CustomTextField()
    let urlField = CustomTextField()
    let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "New account"
        return label
    }()
    let urlLabel: UILabel = {
         let label = UILabel()
         label.text = "New url"
         return label
    }()
    
    var delegate: NewSocialAccountDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupElements()
    }
    
    fileprivate func setupElements() {
        let views: [UIView] = [titleLabel, titleField, urlLabel, urlField]
        let stack = UIStackView(arrangedSubviews: views)
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 12
        
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        navigationItem.title = "Add new account"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissController))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addNewAccount))
        
        NSLayoutConstraint.activate([
            stack.heightAnchor.constraint(equalToConstant: 150),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stack.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
        ])

    }
    
    @objc fileprivate func addNewAccount() {
        let newAccount: String = titleField.text ?? ""
        let newUrl: String = urlField.text ?? ""
        
        let emptyFieldColor = UIColor.red.cgColor
        
        if newAccount.isEmpty {
            titleField.layer.borderColor = emptyFieldColor
        } else {
            titleField.layer.borderColor = UIColor.gray.cgColor
        }
        
        if newUrl.isEmpty {
            urlField.layer.borderColor = emptyFieldColor
        } else {
            urlField.layer.borderColor = UIColor.gray.cgColor
        }
        
        if !newAccount.isEmpty && !newUrl.isEmpty {
            dismiss(animated: true, completion: nil)
            guard let delegate = self.delegate else { return }
            delegate.newSocialAccount(title: newAccount, url: newUrl)
        }
    }
    
    @objc fileprivate func dismissController() {
        dismiss(animated: true, completion: nil)
    }
}
