//
//  Page3ViewController.swift
//  CodedCard
//
//  Created by Terence Williams on 8/8/21.
//

import UIKit

class Page3ViewController: UIViewController {
    
    @IBOutlet weak var actionButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        actionButton.layer.cornerRadius = 5
        actionButton.addTarget(self, action: #selector(closeView), for: .touchUpInside)
    }
    
    @objc func closeView() {
        CardHelper.setHasSeenWalkthrough()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "closeWalkthrough"),
        object: nil,
        userInfo: nil)
    }

}
