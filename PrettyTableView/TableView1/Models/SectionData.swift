//
//  SectionData.swift
//  TableViewPractice
//
//  Created by Boris Goncharov on 11/5/20.
//

import Foundation
import UIKit

struct SectionData {
    var open: Bool
    let data: [CellData]
}

struct CellData {
    let id: String
    let title: String
    let featureImage: UIImage
}
