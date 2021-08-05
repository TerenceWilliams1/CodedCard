//
//  ProfileItemCollectionViewCell.swift
//  CodedCard
//
//  Created by Terence Williams on 8/5/21.
//

import UIKit

class ProfileItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundImageView.layoutIfNeeded()
        backgroundImageView.clipsToBounds = true
        backgroundImageView.layer.cornerRadius = 15
    }

}
