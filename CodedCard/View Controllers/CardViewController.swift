//
//  CardViewController.swift
//  CodedCard
//
//  Created by Terence Williams on 8/2/21.
//

import UIKit

class CardViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var sections: [CardSection] = []
    var itemTitle: String? = ""
    var iconTitle: String? = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
    func setupUI() {
        menuView.layer.cornerRadius = 60
        menuView.clipsToBounds = true
        
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width / 2
        avatarImageView.layer.borderWidth = 6
        avatarImageView.layer.borderColor = UIColor.init(hex: ThemeColors.blue.rawValue)?.cgColor
        
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
        //-------
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
        if CardHelper.valueForKey(key: CardSection.twitch.rawValue) != "" {
            sections.append(.twitch)
        }
        if CardHelper.valueForKey(key: CardSection.github.rawValue) != "" {
            sections.append(.github)
        }
        if CardHelper.valueForKey(key: CardSection.soundcloud.rawValue) != "" {
            sections.append(.soundcloud)
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

}
