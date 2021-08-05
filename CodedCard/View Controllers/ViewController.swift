//
//  ViewController.swift
//  CodedCard
//
//  Created by Terence Williams on 7/29/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var viewCardButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        editButton.layoutIfNeeded()
        editButton.layer.cornerRadius = 14
        editButton.clipsToBounds = true
        
        viewCardButton.layoutIfNeeded()
        viewCardButton.layer.cornerRadius = 14
        viewCardButton.clipsToBounds = true
    }

}

