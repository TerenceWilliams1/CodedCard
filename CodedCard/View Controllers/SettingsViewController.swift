//
//  SettingsViewController.swift
//  TIFT
//
//  Created by Terence Williams on 1/26/22.
//

import UIKit
import SafariServices

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SFSafariViewControllerDelegate {
    
    @IBOutlet weak var table: UITableView!
    
    var sections: [SettingSection] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
    }
    
    func setupData() {
        sections = [.notifications,
                    .upgrade,
                    .review,
                    .share,
                    .contact,
                    .privacy]
        
        let settingsTableViewCell = UINib(nibName: "SettingsTableViewCell", bundle: nil)
        table.register(settingsTableViewCell, forCellReuseIdentifier: "SettingsTableViewCell")
    }
    
    // MARK: - Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as? SettingsTableViewCell
        let section = sections[indexPath.row]
        cell?.titleLabel.text = title(_forSection: section)
        DispatchQueue.main.async {
            cell?.iconImageView.image = section == .upgrade ? UIImage(named: "GoldCard") : UIImage(named: section.rawValue)
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = sections[indexPath.row]
        switch section {
        case .notifications:
            UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            break
        case .upgrade:
            let paywallViewController = PaywallViewController(nibName: "PaywallViewController", bundle: nil)
            paywallViewController.modalPresentationStyle = .fullScreen
            self.present(paywallViewController, animated: true, completion: nil)
            break
        case .widget:
            break
        case .share:
            let promoText = "Create QR codes for all of your sites and social accounts with the Quik Card app. It's the ultimate virtual business card.\n\nhttps://apps.apple.com/us/app/quikcard-digital-social-card/id1579777525"
            let promoImage = UIImage(named: "QuikCardPromo2 3.JPG")
            let itemsToShare = [promoText, promoImage] as [Any]
            
            let activityViewController = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
            break
        case .contact:
            self.openWebLink(url: "https://www.oaklandsoftwareco.com/contact")
            break
        case .review:
            let url = URL.init(string: "https://apps.apple.com/us/app/quik-card/id1579777525")
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            break
        case .privacy:
            self.openWebLink(url: "https://www.oaklandsoftwareco.com/privacy")
            break
        }
    }
    
    //MARK: - Helpers
    func title(_forSection section:SettingSection) -> String {
        switch section {
        case .notifications:
            return "Notifications"
        case .upgrade:
            return "Upgrade to a Gold Card"
        case .widget:
            return "Widget"
        case .share:
            return "Share QuikCard"
        case .contact:
            return "Contact Us"
        case .review:
            return "Leave us a Review"
        case .privacy:
            return "Privacy Policy"
        }
    }
    
    func openWebLink(url:String) {
        let url = URL.init(string: url)
        let safari = SFSafariViewController.init(url: url!)
        safari.delegate = self
        safari.modalPresentationCapturesStatusBarAppearance = true
        safari.view.tintColor = self.view.tintColor
        self.present(safari, animated: true, completion: nil)
    }
}

enum SettingSection: String {
    case notifications = "notifications"
    case widget = "widget"
    case share = "share"
    case contact = "contact"
    case review = "review"
    case privacy = "privacy"
    case upgrade = "Upgrade"
}
