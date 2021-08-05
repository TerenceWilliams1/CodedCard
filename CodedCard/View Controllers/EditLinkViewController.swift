//
//  EditLinkViewController.swift
//  CodedCard
//
//  Created by Terence Williams on 8/5/21.
//

import UIKit

class EditLinkViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var saveButton: UIButton!

    var item: CardSection = .avatar
    var prefix: LinkPrefix = .none
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        loadData()
        setupUI()
    }
    
    func setupData() {
        prefix = prefix(forItem: item)
    }
    
    func setupUI() {
        textField.delegate = self
        textField.becomeFirstResponder()
        textField.keyboardType = keyboardType()
        textField.textContentType = contentType()
        
        let saveToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        saveToolbar.barStyle = .default
        saveToolbar.tintColor = self.view.tintColor
        
        let flexspace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let saveBtton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(save))
        
        var items = [UIBarButtonItem]()
        items.append(flexspace)
        items.append(saveBtton)
        items.append(flexspace)
        
        saveToolbar.items = items
        saveToolbar.sizeToFit()
        textField.inputAccessoryView = saveToolbar
        
        iconImageView.image = UIImage(named: item.rawValue)
        titleLabel.text = item.rawValue.capitalized
        urlLabel.text = prefix.rawValue
        descriptionLabel.text = description()
    }
    
    //MARK: - Text Field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        urlLabel.text = "\(prefix.rawValue)\(textField.text ?? "")"
    }
    
    //MARK: - Actions
    @objc func save() {
        saveData()
    }
    
    //MARK: - Helpers
    func prefix(forItem item: CardSection) -> LinkPrefix {
        switch item {
        case .facebook:
            return .facebook
        case .linkedin:
            return .linkedin
        case .instagram:
            return .instagram
        case .twitter:
            return .twitter
        case .snapchat:
            return .snapchat
        case .tiktok:
            return .tiktok
        case .whatsapp:
            return .whatsapp
        case .youtube:
            return .youtube
        case .cashapp:
            return .cashapp
        case .twitch:
            return .twitch
        case .github:
            return .github
        case .soundcloud:
            return .soundcloud
        default:
            return .none
        }
    }
    
    func keyboardType() -> UIKeyboardType {
        switch item {
        case .phone, .whatsapp:
            return .numberPad
        case .email:
            return .emailAddress
        case .website, .youtube, .linktree:
            return .URL
        default:
            return .default
        }
    }
    
    func contentType() -> UITextContentType? {
        switch item {
        case .phone:
            return .telephoneNumber
        case .email:
            return .emailAddress
        case .address:
            return .fullStreetAddress
        default:
            return nil
        }
    }
    
    func description() -> String {
        switch item {
        case .phone, .whatsapp:
            return "Enter your number"
        case .address:
            return "Enter your address"
        case .email:
            return "Enter your email address"
        case .website, .linktree:
            return "Enter weblink"
        default:
            return "Enter your username"
        }
    }
    
    //MARK: - Data
    func loadData() {
        switch item {
        case .phone:
            if CardHelper.valueForKey(key: CardSection.phone.rawValue) != "" {
                textField.text = CardHelper.valueForKey(key: CardSection.phone.rawValue)
            }
        case .email:
            if CardHelper.valueForKey(key: CardSection.email.rawValue) != "" {
                textField.text = CardHelper.valueForKey(key: CardSection.email.rawValue)
            }
        case .address:
            if CardHelper.valueForKey(key: CardSection.address.rawValue) != "" {
                textField.text = CardHelper.valueForKey(key: CardSection.address.rawValue)
            }
        case .website:
            if CardHelper.valueForKey(key: CardSection.website.rawValue) != "" {
                textField.text = CardHelper.valueForKey(key: CardSection.website.rawValue)
            }
        case .linkedin:
            if CardHelper.valueForKey(key: CardSection.linkedin.rawValue) != "" {
                textField.text = CardHelper.valueForKey(key: CardSection.linkedin.rawValue)
            }
        case .facebook:
            if CardHelper.valueForKey(key: CardSection.facebook.rawValue) != "" {
                textField.text = CardHelper.valueForKey(key: CardSection.facebook.rawValue)
            }
        case .instagram:
            if CardHelper.valueForKey(key: CardSection.instagram.rawValue) != "" {
                textField.text = CardHelper.valueForKey(key: CardSection.instagram.rawValue)
            }
        case .twitter:
            if CardHelper.valueForKey(key: CardSection.twitter.rawValue) != "" {
                textField.text = CardHelper.valueForKey(key: CardSection.twitter.rawValue)
            }
        case .snapchat:
            if CardHelper.valueForKey(key: CardSection.snapchat.rawValue) != "" {
                textField.text = CardHelper.valueForKey(key: CardSection.snapchat.rawValue)
            }
        case .tiktok:
            if CardHelper.valueForKey(key: CardSection.tiktok.rawValue) != "" {
                textField.text = CardHelper.valueForKey(key: CardSection.tiktok.rawValue)
            }
        case .whatsapp:
            if CardHelper.valueForKey(key: CardSection.whatsapp.rawValue) != "" {
                textField.text = CardHelper.valueForKey(key: CardSection.whatsapp.rawValue)
            }
        case .youtube:
            if CardHelper.valueForKey(key: CardSection.youtube.rawValue) != "" {
                textField.text = CardHelper.valueForKey(key: CardSection.youtube.rawValue)
            }
        case .cashapp:
            if CardHelper.valueForKey(key: CardSection.cashapp.rawValue) != "" {
                textField.text = CardHelper.valueForKey(key: CardSection.cashapp.rawValue)
            }
        case .twitch:
            if CardHelper.valueForKey(key: CardSection.twitch.rawValue) != "" {
                textField.text = CardHelper.valueForKey(key: CardSection.twitch.rawValue)
            }
        case .github:
            if CardHelper.valueForKey(key: CardSection.github.rawValue) != "" {
                textField.text = CardHelper.valueForKey(key: CardSection.github.rawValue)
            }
        case .soundcloud:
            if CardHelper.valueForKey(key: CardSection.soundcloud.rawValue) != "" {
                textField.text = CardHelper.valueForKey(key: CardSection.soundcloud.rawValue)
            }
        case .linktree:
            if CardHelper.valueForKey(key: CardSection.linktree.rawValue) != "" {
                textField.text = CardHelper.valueForKey(key: CardSection.linktree.rawValue)
            }
        default:
            textField.text = ""
        }
    }
    
    func saveData() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        CardHelper.updateValue(value: textField.text!, key: item.rawValue)
        self.dismiss(animated: true, completion: nil)
    }
}


