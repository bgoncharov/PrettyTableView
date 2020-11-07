//
//  CardCell.swift
//  TableViewPractice
//
//  Created by Boris Goncharov on 11/5/20.
//

import Foundation
import UIKit

class CardCell: UITableViewCell {
    var cellData: CellData! {
        didSet {
            futureImage.image = cellData.featureImage
            titleLabel.text = cellData.title
        }
    }
    
    fileprivate var futureImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 2
        return iv
    }()
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.monospacedSystemFont(ofSize: 15, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let infoText: UITextView = {
        let infoText = UITextView()
        infoText.font = UIFont.systemFont(ofSize: 12, weight: .light)
        infoText.textColor = .black
        infoText.isEditable = false
        infoText.translatesAutoresizingMaskIntoConstraints = false
        infoText.backgroundColor = .clear
        infoText.text = "Test text just to check how everythig here works. Thank you in advance!"
        return infoText
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .white
        backgroundColor = .clear
        
        contentView.backgroundColor = .white
        setupConstraints()
    }
    
    fileprivate var imageHeightOpened: NSLayoutConstraint!
    fileprivate var imageHeightClosed: NSLayoutConstraint!
    
    fileprivate func setupConstraints() {
        contentView.addSubview(futureImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoText)
        

        
        NSLayoutConstraint.activate([
            futureImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            futureImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            futureImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        ])
        
        imageHeightOpened = futureImage.heightAnchor.constraint(equalToConstant: 140)
        imageHeightClosed = futureImage.heightAnchor.constraint(equalToConstant: 140)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: futureImage.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 13),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        ])
        
        NSLayoutConstraint.activate([
            infoText.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -4),
            infoText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            infoText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            infoText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
        
        
    }
    
    func animate() {
        self.imageHeightOpened.isActive = false
        self.imageHeightClosed.isActive = true
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            self.imageHeightClosed.isActive = false
            self.imageHeightOpened.isActive = true
            
            UIView.animate(withDuration: 0.3, delay: 0.1, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
                self.contentView.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
