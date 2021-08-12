//
//  CardViewController.swift
//  CodedCard
//
//  Created by Terence Williams on 8/2/21.
//

import UIKit
import DTOverlayController

class CardViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var sections: [CardSection] = []
    var itemTitle: String? = ""
    var iconTitle: String? = ""
    var themeColor: UIColor = UIColor.QuikTheme.charcal

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
    func setupUI() {
        menuView.layer.cornerRadius = 60
        menuView.clipsToBounds = true
                
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layoutIfNeeded()
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width / 2
        avatarImageView.layer.borderWidth = 6
        avatarImageView.layer.borderColor = themeColor.cgColor        
        cardView.backgroundColor = themeColor

        
        collectionView.dataSource = self
        collectionView.delegate = self
        let itemCollectionViewCell = UINib(nibName: "ItemCollectionViewCell", bundle: nil)
        collectionView.register(itemCollectionViewCell, forCellWithReuseIdentifier: "ItemCollectionViewCell")
    }
    
    func loadData() {
        if let imgData = UserDefaults.standard.data(forKey: CardSection.avatar.rawValue) as NSData? {
            if let image = UIImage(data: imgData as Data) {
                self.avatarImageView.image = image
            }
        }
        if CardHelper.valueForKey(key: CardSection.name.rawValue) != "" {
            nameLabel.text = CardHelper.valueForKey(key: CardSection.name.rawValue)
        }
        if CardHelper.valueForKey(key: CardSection.title.rawValue) != "" {
            titleLabel.text = CardHelper.valueForKey(key: CardSection.title.rawValue)
        }
        if CardHelper.valueForKey(key: CardSection.header.rawValue) != "" {
            headlineLabel.text = CardHelper.valueForKey(key: CardSection.header.rawValue)
        }
        if CardHelper.valueForKey(key: CardSection.company.rawValue) != "" {
            companyLabel.text = CardHelper.valueForKey(key: CardSection.company.rawValue)
        }
        if CardHelper.valueForKey(key: CardSection.email.rawValue) != "" {
            sections.append(.email)
        }
        if CardHelper.valueForKey(key: CardSection.phone.rawValue) != "" {
            sections.append(.phone)
        }
        if CardHelper.valueForKey(key: CardSection.address.rawValue) != "" {
            sections.append(.address)
        }
        if CardHelper.valueForKey(key: CardSection.website.rawValue) != "" {
            sections.append(.website)
        }
        if CardHelper.valueForKey(key: CardSection.linkedin.rawValue) != "" {
            sections.append(.linkedin)
        }
        if CardHelper.valueForKey(key: CardSection.facebook.rawValue) != "" {
            sections.append(.facebook)
        }
        if CardHelper.valueForKey(key: CardSection.instagram.rawValue) != "" {
            sections.append(.instagram)
        }
        if CardHelper.valueForKey(key: CardSection.twitter.rawValue) != "" {
            sections.append(.twitter)
        }
        if CardHelper.valueForKey(key: CardSection.snapchat.rawValue) != "" {
            sections.append(.snapchat)
        }
        if CardHelper.valueForKey(key: CardSection.tiktok.rawValue) != "" {
            sections.append(.tiktok)
        }
        if CardHelper.valueForKey(key: CardSection.whatsapp.rawValue) != "" {
            sections.append(.whatsapp)
        }
        if CardHelper.valueForKey(key: CardSection.youtube.rawValue) != "" {
            sections.append(.youtube)
        }
        if CardHelper.valueForKey(key: CardSection.cashapp.rawValue) != "" {
            sections.append(.cashapp)
        }
        if CardHelper.valueForKey(key: CardSection.venmo.rawValue) != "" {
            sections.append(.venmo)
        }
        if CardHelper.valueForKey(key: CardSection.twitch.rawValue) != "" {
            sections.append(.twitch)
        }
        if CardHelper.valueForKey(key: CardSection.github.rawValue) != "" {
            sections.append(.github)
        }
        if CardHelper.valueForKey(key: CardSection.soundcloud.rawValue) != "" {
            sections.append(.soundcloud)
        }
        if CardHelper.valueForKey(key: CardSection.spotify.rawValue) != "" {
            sections.append(.spotify)
        }
        if CardHelper.valueForKey(key: CardSection.applemusic.rawValue) != "" {
            sections.append(.applemusic)
        }
        if CardHelper.valueForKey(key: CardSection.linktree.rawValue) != "" {
            sections.append(.linktree)
        }
        if CardHelper.valueForKey(key: CardSection.etsy.rawValue) != "" {
            sections.append(.etsy)
        }
    }
    
    //MARK: - Actions
    @IBAction func closeView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as? ItemCollectionViewCell
        let item = sections[indexPath.row]
        configureCell(cell: cell!, item: item)
        return cell!
    }
    
    func configureCell(cell: ItemCollectionViewCell, item: CardSection) {
        
        cell.titleLabel.text = item.rawValue.capitalized
        cell.iconImageView.image = UIImage(named: item.rawValue)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        let item = sections[indexPath.row]
        
        let qrCodeViewController = self.storyboard?.instantiateViewController(withIdentifier: "QRCodeViewController") as! QRCodeViewController
        qrCodeViewController.item = item
        qrCodeViewController.url = code(_forSection: item)

        let overlayController = DTOverlayController(viewController: qrCodeViewController)
        overlayController.overlayHeight = .dynamic(0.6)
        overlayController.isPanGestureEnabled = true
        present(overlayController, animated: true, completion: nil)
    }
    
    func code(_forSection section: CardSection) -> String {
        switch section {
        case .address:
            return CardHelper.valueForKey(key: CardSection.address.rawValue)
        case .phone:
            return CardHelper.valueForKey(key: CardSection.phone.rawValue)
        case .email:
            return CardHelper.valueForKey(key: CardSection.email.rawValue)
        case .website:
            return CardHelper.valueForKey(key: CardSection.website.rawValue)
        case .linkedin:
            let link = CardHelper.valueForKey(key: CardSection.linkedin.rawValue)
            if (!isValid(link: link)) {
                return "https://www.linkedin.com/in/\(link)"
            }
            return CardHelper.valueForKey(key: CardSection.linkedin.rawValue)
        case .facebook:
            let link = CardHelper.valueForKey(key: CardSection.facebook.rawValue)
            if (!isValid(link: link)) {
                return "https://www.facebook.com/\(link)"
            }
            return CardHelper.valueForKey(key: CardSection.facebook.rawValue)
        case .instagram:
            let link = CardHelper.valueForKey(key: CardSection.instagram.rawValue)
            if (!isValid(link: link)) {
                return "https://www.instagram.com/\(link)"
            }
            return CardHelper.valueForKey(key: CardSection.instagram.rawValue)
        case .twitter:
            let link = CardHelper.valueForKey(key: CardSection.twitter.rawValue)
            if (!isValid(link: link)) {
                return "https://www.twitter.com/\(link)"
            }
            return CardHelper.valueForKey(key: CardSection.twitter.rawValue)
        case .snapchat:
            let link = CardHelper.valueForKey(key: CardSection.snapchat.rawValue)
            if (!isValid(link: link)) {
                return "https://www.snapchat.com/add/\(link)"
            }
            return CardHelper.valueForKey(key: CardSection.snapchat.rawValue)
        case .tiktok:
            let link = CardHelper.valueForKey(key: CardSection.tiktok.rawValue)
            if ((!isValid(link: link)) || (!link.contains("@"))) {
                return "https://www.tiktok.com/@\(link)"
            }
            return CardHelper.valueForKey(key: CardSection.tiktok.rawValue)
        case .whatsapp:
            let link = CardHelper.valueForKey(key: CardSection.whatsapp.rawValue)
            if (!isValid(link: link)) {
                return "https://api.whatsapp.com/send?phone=\(link)"
            }
            return CardHelper.valueForKey(key: CardSection.whatsapp.rawValue)
        case .youtube:
            let link = CardHelper.valueForKey(key: CardSection.youtube.rawValue)
            if (!isValid(link: link)) {
                return "https://www.youtube.com/\(link)"
            }
            return CardHelper.valueForKey(key: CardSection.youtube.rawValue)
        case .cashapp:
            let link = CardHelper.valueForKey(key: CardSection.cashapp.rawValue)
            if ((!isValid(link: link)) || (!link.contains("$"))) {
                return "https://www.cash.app/$\(link)"
            }
            return CardHelper.valueForKey(key: CardSection.cashapp.rawValue)
        case .twitch:
            let link = CardHelper.valueForKey(key: CardSection.twitch.rawValue)
            if (!isValid(link: link)) {
                return "https://www.twitch.tv/\(link)"
            }
            return CardHelper.valueForKey(key: CardSection.twitch.rawValue)
        case .github:
            let link = CardHelper.valueForKey(key: CardSection.github.rawValue)
            if (!isValid(link: link)) {
                return "https://www.github.com/\(link)"
            }
            return CardHelper.valueForKey(key: CardSection.github.rawValue)
        case .soundcloud:
            let link = CardHelper.valueForKey(key: CardSection.soundcloud.rawValue)
            if (!isValid(link: link)) {
                return "https://www.soundcloud.com/\(link)"
            }
            return CardHelper.valueForKey(key: CardSection.soundcloud.rawValue)
        case .linktree:
            return CardHelper.valueForKey(key: CardSection.linktree.rawValue)
        case .etsy:
            let link = CardHelper.valueForKey(key: CardSection.etsy.rawValue)
            if (!isValid(link: link)) {
                return "https://www.etsy.com/shop/\(link)"
            }
            return CardHelper.valueForKey(key: CardSection.etsy.rawValue)
        case .venmo:
            let link = CardHelper.valueForKey(key: CardSection.venmo.rawValue)
            if (!isValid(link: link)) {
                return "https://venmo.com/\(link)"
            }
            return CardHelper.valueForKey(key: CardSection.venmo.rawValue)
        case .spotify:
            return CardHelper.valueForKey(key: CardSection.spotify.rawValue)
        case .applemusic:
            return CardHelper.valueForKey(key: CardSection.applemusic.rawValue)
        default:
            return CardHelper.valueForKey(key: section.rawValue)
        }
    }
    
    func isValid(link: String) -> Bool {
        return link.contains(".com")
    }

}
