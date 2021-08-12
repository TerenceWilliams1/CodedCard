//
//  ViewController.swift
//  CodedCard
//
//  Created by Terence Williams on 7/29/21.
//

import UIKit
import StoreKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var viewCardButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        showWalkthroughIfNeeded()
        promptForReview()
        if !CardHelper.hasSeenNotificationPrompt() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.enableNotifications()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupUI()
    }
    
    func setupUI() {
        editButton.layoutIfNeeded()
        editButton.layer.cornerRadius = 10
        editButton.clipsToBounds = true
        editButton.setTitleColor(CardHelper.theme(), for: .normal)
        
        viewCardButton.layoutIfNeeded()
        viewCardButton.layer.cornerRadius = 10
        viewCardButton.clipsToBounds = true
        viewCardButton.backgroundColor = CardHelper.theme()
    }

    func showWalkthroughIfNeeded() {
        if CardHelper.shouldShowWalkthrough() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                let walkthrough = WalkThroughPageViewController(coder: nil)
                walkthrough?.modalPresentationStyle = .fullScreen
                walkthrough?.modalTransitionStyle = .coverVertical
                self.present(walkthrough!, animated: true, completion: nil)
            }
        }
    }
    
    func promptForReview() {
        //Ask For  Review
        let currentCount = CardHelper.newVersionLaunchCount()
        if (currentCount == 3 || currentCount == 8 || currentCount == 15 || currentCount == 30){
            SKStoreReviewController.requestReview()
        }
    }
    
    func enableNotifications() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "registerNotifications"),
                                        object: nil,
                                        userInfo: nil)
    }
}

