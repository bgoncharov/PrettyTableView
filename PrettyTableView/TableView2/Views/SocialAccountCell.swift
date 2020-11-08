//
//  SocialAccountCell.swift
//  PrettyTableView
//
//  Created by Boris Goncharov on 11/7/20.
//

import Foundation
import UIKit

class SocialAccountCell: UITableViewCell {
    
    var socialAccount: SocialAccount? {
        didSet {
            guard let socialAccount = socialAccount else { return }
            appLogo.image = UIImage(named: socialAccount.imageUrl)
            appTitle.text = socialAccount.title
            setupAppLinks()
        }
    }
    
    fileprivate func setupAppLinks() {
        guard let socialAccount = socialAccount else { return }
        
        let attributes:[NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.blue,
            NSAttributedString.Key.underlineColor: UIColor.blue,
            NSAttributedString.Key.underlineStyle: 1,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)
        ]
        let str = NSAttributedString(string: socialAccount.url, attributes: attributes)
        appUrl.setAttributedTitle(str, for: .normal)
        
        appUrl.addTarget(self, action: #selector(SocialAccountCell.openUrl), for: .touchUpInside)
        appUrl.isUserInteractionEnabled = true    }
    
    @objc func openUrl() {
        guard let socialAccount = socialAccount else { return }
        let appUrl = URL(string: socialAccount.url)!
        UIApplication.shared.open(appUrl, options: [:], completionHandler: nil)
    }
    
    fileprivate let appLogo: UIImageView = {
        let applogo = UIImageView()
        applogo.contentMode = .scaleAspectFit
        return applogo
    }()
    
    fileprivate let appTitle: UILabel = {
        let appTitle = UILabel()
        appTitle.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return appTitle
    }()
    
    fileprivate let appUrl = UIButton()
       
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        setupElements()
        
    }
    
    fileprivate func setupElements() {
        let stack = UIStackView(arrangedSubviews: [appTitle, appUrl])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        
        addSubview(appLogo)
        addSubview(stack)
        
        appLogo.translatesAutoresizingMaskIntoConstraints = false
        stack.translatesAutoresizingMaskIntoConstraints = false
  
        NSLayoutConstraint.activate([
            appLogo.heightAnchor.constraint(equalToConstant: 30),
            appLogo.widthAnchor.constraint(equalToConstant: 60),
            appLogo.leadingAnchor.constraint(equalTo: leadingAnchor),
            appLogo.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: centerYAnchor),
            stack.heightAnchor.constraint(equalToConstant: 40),
            stack.leadingAnchor.constraint(equalTo: appLogo.trailingAnchor, constant: 8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
