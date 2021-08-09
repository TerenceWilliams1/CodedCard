//
//  Page1ViewController.swift
//  CodedCard
//
//  Created by Terence Williams on 8/8/21.
//

import UIKit

class Page1ViewController: UIViewController {
    
    @IBOutlet weak var actionButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        actionButton.layer.cornerRadius = 5
        actionButton.addTarget(self, action: #selector(goToPage2), for: .touchUpInside)
    }
    
    @objc func goToPage2() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "continueWalkthrough"),
        object: nil,
        userInfo: nil)
    }

}
