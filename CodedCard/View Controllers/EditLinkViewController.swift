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
    @IBOutlet weak var backgroundImageView: UIImageView!
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
        textField.allowsEditingTextAttributes = true
        
        backgroundImageView.backgroundColor = CardHelper.placeholderTheme()
        
        let saveToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        saveToolbar.barStyle = .default
        saveToolbar.tintColor = UIColor.darkGray
        
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
        save()
        return false
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
        case .etsy:
            return .etsy
        case .venmo:
            return .venmo
        case .pinterest:
            return .pinterest
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
        case .website, .youtube, .linktree, .spotify, .applemusic:
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
            return "Enter your full address"
        case .email:
            return "Enter your email address"
        case .website, .website2, .website3, .linktree, .spotify, .applemusic:
            return "Enter the URL"
        default:
            return "Enter your username"
        }
    }
    
    //MARK: - Data
    func loadData() {
        if CardHelper.valueForKey(key: item.rawValue) != "" {
            textField.text = CardHelper.valueForKey(key: item.rawValue)
        }
    }
    
    func saveData() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        CardHelper.updateValue(value: textField.text!, key: item.rawValue)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: QuikValues.refreshProfile.rawValue),
                                        object: nil,
                                        userInfo: nil)
        self.dismiss(animated: true, completion: nil)
    }
}


