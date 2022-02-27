//
//  ViewController.swift
//  CodedCard
//
//  Created by Terence Williams on 7/29/21.
//

import UIKit
import StoreKit
import DTOverlayController

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var viewCardButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        //showWalkthroughIfNeeded()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    func promptForReview() {
        //Ask For  Review
        let currentCount = CardHelper.newVersionLaunchCount()
        if (currentCount == 2 || currentCount == 5 || currentCount == 12 || currentCount == 18){
            SKStoreReviewController.requestReview()
        }
    }
    
    func enableNotifications() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "registerNotifications"),
                                        object: nil,
                                        userInfo: nil)
    }
    
    @IBAction func shareApp() {
        let promoText = "Create QR codes for all of your sites and social accounts with the Quik Card app. It's the ultimate virtual business card.\n\nhttps://apps.apple.com/us/app/quikcard-digital-social-card/id1579777525"
        let promoImage = UIImage(named: "QuikCardPromo2 3.JPG")
        let itemsToShare = [promoText, promoImage] as [Any]
        
        let activityViewController = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        let popPresenter = activityViewController.popoverPresentationController
        popPresenter?.sourceView = shareButton
        popPresenter?.sourceRect = shareButton.bounds
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func openSettings() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let settingsViewController = storyBoard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        let navViewController = UINavigationController(rootViewController: settingsViewController)
        navViewController.navigationBar.prefersLargeTitles = true
        navViewController.navigationBar.barTintColor = .black
        navViewController.navigationBar.titleTextAttributes = [ NSAttributedString.Key.foregroundColor : UIColor.white ]
        navViewController.navigationBar.largeTitleTextAttributes = [ NSAttributedString.Key.foregroundColor : UIColor.white ]
        
        let overlayController = DTOverlayController(viewController: navViewController)
        overlayController.overlayHeight = .dynamic(0.8)
        overlayController.isPanGestureEnabled = false
        present(overlayController, animated: true, completion: nil)
    }
}

