//
//  CustomTextField.swift
//  PrettyTableView
//
//  Created by Boris Goncharov on 11/8/20.
//

import UIKit

class CustomTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        layer.cornerRadius = 4
        borderStyle = UITextField.BorderStyle.roundedRect
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
