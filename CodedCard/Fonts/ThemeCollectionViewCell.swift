//
//  ThemeCollectionViewCell.swift
//  CodedCard
//
//  Created by Terence Williams on 8/11/21.
//

import UIKit

class ThemeCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layoutIfNeeded()
        self.clipsToBounds = true
        self.layer.cornerRadius = self.bounds.width / 2
    }

}
