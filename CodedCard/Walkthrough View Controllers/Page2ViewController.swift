//
//  Page2ViewController.swift
//  CodedCard
//
//  Created by Terence Williams on 8/8/21.
//

import UIKit

class Page2ViewController: UIViewController {

    @IBOutlet weak var actionButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        actionButton.layer.cornerRadius = 5
        actionButton.addTarget(self, action: #selector(goToPage3), for: .touchUpInside)
    }

    @objc func goToPage3() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "continueWalkthrough2"),
        object: nil,
        userInfo: nil)
    }
}
