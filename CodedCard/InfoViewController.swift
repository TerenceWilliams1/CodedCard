//
//  InfoViewController.swift
//  CodedCard
//
//  Created by Terence Williams on 7/31/21.
//

import UIKit
import CoreData

class InfoViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var nameStack: UIStackView!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var companyStack: UIStackView!
    @IBOutlet weak var companyTextField: UITextField!
    
    @IBOutlet weak var titleStack: UIStackView!
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var phoneStack: UIStackView!
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var emailStack: UIStackView!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var headerStack: UIStackView!
    @IBOutlet weak var headerTextField: UITextField!

    @IBOutlet weak var addressStack: UIStackView!
    @IBOutlet weak var addressTextField: UITextField!

    @IBOutlet weak var websiteStack: UIStackView!
    @IBOutlet weak var websiteTextField: UITextField!

    @IBOutlet weak var facebookStack: UIStackView!
    @IBOutlet weak var facebookTextField: UITextField!

    @IBOutlet weak var instagramStack: UIStackView!
    @IBOutlet weak var instagramTextField: UITextField!

    @IBOutlet weak var snapchatStack: UIStackView!
    @IBOutlet weak var snapchatTextField: UITextField!

    @IBOutlet weak var twitterStack: UIStackView!
    @IBOutlet weak var twitterTextField: UITextField!

    @IBOutlet weak var linkedinStack: UIStackView!
    @IBOutlet weak var linkedinTextField: UITextField!
    
    @IBOutlet weak var tiktokStack: UIStackView!
    @IBOutlet weak var tiktokTextField: UITextField!
    
    @IBOutlet weak var youtubeStack: UIStackView!
    @IBOutlet weak var youtubeTextField: UITextField!
    
    @IBOutlet weak var githubStack: UIStackView!
    @IBOutlet weak var githubTextField: UITextField!
    
    @IBOutlet weak var cashappStack: UIStackView!
    @IBOutlet weak var cashappTextField: UITextField!
    
    @IBOutlet weak var twitchStack: UIStackView!
    @IBOutlet weak var twitchTextField: UITextField!
    
    @IBOutlet weak var whatsappStack: UIStackView!
    @IBOutlet weak var whatsappTextField: UITextField!
    
    @IBOutlet weak var soundcloudStack: UIStackView!
    @IBOutlet weak var soundcloudTextField: UITextField!
    
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate //Singlton instance
    let context = appDelegate.persistentContainer.viewContext
    var card: [NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        setupui()
        loadData()
    }

    func setupui() {
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Name",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)])
        titleTextField.attributedPlaceholder = NSAttributedString(string: "Title",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)])
        companyTextField.attributedPlaceholder = NSAttributedString(string: "Company",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)])
        headerTextField.attributedPlaceholder = NSAttributedString(string: "Header",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)])
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)])
        phoneTextField.attributedPlaceholder = NSAttributedString(string: "Phone",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)])
        addressTextField.attributedPlaceholder = NSAttributedString(string: "Address",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)])
        websiteTextField.attributedPlaceholder = NSAttributedString(string: "Website",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)])
        linkedinTextField.attributedPlaceholder = NSAttributedString(string: "LinkedIn",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)])
        facebookTextField.attributedPlaceholder = NSAttributedString(string: "Facebook/",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)])
        instagramTextField.attributedPlaceholder = NSAttributedString(string: "Instagram/",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)])
        twitterTextField.attributedPlaceholder = NSAttributedString(string: "Twitter @",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)])
        snapchatTextField.attributedPlaceholder = NSAttributedString(string: "Snapchat",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)])
        tiktokTextField.attributedPlaceholder = NSAttributedString(string: "Tiktok",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)])
        whatsappTextField.attributedPlaceholder = NSAttributedString(string: "Whatsapp",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)])
        youtubeTextField.attributedPlaceholder = NSAttributedString(string: "Youtube",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)])
        twitchTextField.attributedPlaceholder = NSAttributedString(string: "Twitch",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)])
        cashappTextField.attributedPlaceholder = NSAttributedString(string: "CashApp $",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)])
        githubTextField.attributedPlaceholder = NSAttributedString(string: "Github",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)])
        soundcloudTextField.attributedPlaceholder = NSAttributedString(string: "Soundcloud",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)])
        soundcloudTextField.tag = 4
        
        nameTextField.delegate = self
        titleTextField.delegate = self
        headerTextField.delegate = self
        titleTextField.delegate = self
        emailTextField.delegate = self
        phoneTextField.delegate = self
        addressTextField.delegate = self
        websiteTextField.delegate = self
        linkedinTextField.delegate = self
        facebookTextField.delegate = self
        instagramTextField.delegate = self
        twitterTextField.delegate = self
        snapchatTextField.delegate = self
        tiktokTextField.delegate = self
        youtubeTextField.delegate = self
        cashappTextField.delegate = self
        twitchTextField.delegate = self
        githubTextField.delegate = self
        soundcloudTextField.delegate = self
    }
    
    func setupData() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    //Mark: - Helpers
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 4 {
            loadData()
        }
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = .zero
        } else {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom + 50, right: 0)
        }

        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
    
    //MARK: - Actions
    func loadData() {
        if CardHelper.valueForKey(key: CardSection.name.rawValue) != "" {
            nameTextField.text = CardHelper.valueForKey(key: CardSection.name.rawValue)
        }
        if CardHelper.valueForKey(key: CardSection.title.rawValue) != "" {
            titleTextField.text = CardHelper.valueForKey(key: CardSection.title.rawValue)
        }
        if CardHelper.valueForKey(key: CardSection.header.rawValue) != "" {
            headerTextField.text = CardHelper.valueForKey(key: CardSection.header.rawValue)
        }
        if CardHelper.valueForKey(key: CardSection.company.rawValue) != "" {
            companyTextField.text = CardHelper.valueForKey(key: CardSection.company.rawValue)
        }
        if CardHelper.valueForKey(key: CardSection.email.rawValue) != "" {
            emailTextField.text = CardHelper.valueForKey(key: CardSection.email.rawValue)
        }
        if CardHelper.valueForKey(key: CardSection.phone.rawValue) != "" {
            phoneTextField.text = CardHelper.valueForKey(key: CardSection.phone.rawValue)
        }
        if CardHelper.valueForKey(key: CardSection.address.rawValue) != "" {
            addressTextField.text = CardHelper.valueForKey(key: CardSection.address.rawValue)
        }
        if CardHelper.valueForKey(key: CardSection.website.rawValue) != "" {
            websiteTextField.text = CardHelper.valueForKey(key: CardSection.website.rawValue)
        }
        if CardHelper.valueForKey(key: CardSection.linkedin.rawValue) != "" {
            linkedinTextField.text = CardHelper.valueForKey(key: CardSection.linkedin.rawValue)
        }
        if CardHelper.valueForKey(key: CardSection.facebook.rawValue) != "" {
            facebookTextField.text = CardHelper.valueForKey(key: CardSection.facebook.rawValue)
        }
        if CardHelper.valueForKey(key: CardSection.instagram.rawValue) != "" {
            instagramTextField.text = CardHelper.valueForKey(key: CardSection.instagram.rawValue)
        }
        if CardHelper.valueForKey(key: CardSection.twitter.rawValue) != "" {
            twitterTextField.text = CardHelper.valueForKey(key: CardSection.twitter.rawValue)
        }
        if CardHelper.valueForKey(key: CardSection.snapchat.rawValue) != "" {
            snapchatTextField.text = CardHelper.valueForKey(key: CardSection.snapchat.rawValue)
        }
        if CardHelper.valueForKey(key: CardSection.tiktok.rawValue) != "" {
            tiktokTextField.text = CardHelper.valueForKey(key: CardSection.tiktok.rawValue)
        }
        if CardHelper.valueForKey(key: CardSection.whatsapp.rawValue) != "" {
            whatsappTextField.text = CardHelper.valueForKey(key: CardSection.whatsapp.rawValue)
        }
        if CardHelper.valueForKey(key: CardSection.youtube.rawValue) != "" {
            youtubeTextField.text = CardHelper.valueForKey(key: CardSection.youtube.rawValue)
        }
        if CardHelper.valueForKey(key: CardSection.cashapp.rawValue) != "" {
            cashappTextField.text = CardHelper.valueForKey(key: CardSection.cashapp.rawValue)
        }
        if CardHelper.valueForKey(key: CardSection.twitch.rawValue) != "" {
            twitchTextField.text = CardHelper.valueForKey(key: CardSection.twitch.rawValue)
        }
        if CardHelper.valueForKey(key: CardSection.github.rawValue) != "" {
            githubTextField.text = CardHelper.valueForKey(key: CardSection.github.rawValue)
        }
        if CardHelper.valueForKey(key: CardSection.soundcloud.rawValue) != "" {
            soundcloudTextField.text = CardHelper.valueForKey(key: CardSection.soundcloud.rawValue)
        }
    }
    
    @IBAction func saveInfo() {
        if let name = nameTextField.text {
            CardHelper.updateValue(value: name, key: CardSection.name.rawValue)
        }
        if let title = titleTextField.text {
            CardHelper.updateValue(value: title, key: CardSection.title.rawValue)
        }
        if let header = headerTextField.text {
            CardHelper.updateValue(value: header, key: CardSection.header.rawValue)
        }
        if let company = companyTextField.text {
            CardHelper.updateValue(value: company, key: CardSection.company.rawValue)
        }
        if let email = emailTextField.text {
            CardHelper.updateValue(value: email, key: CardSection.email.rawValue)
        }
        if let phone = phoneTextField.text {
            CardHelper.updateValue(value: phone, key: CardSection.phone.rawValue)
        }
        if let address = addressTextField.text {
            CardHelper.updateValue(value: address, key: CardSection.address.rawValue)
        }
        if let website = websiteTextField.text {
            CardHelper.updateValue(value: website, key: CardSection.website.rawValue)
        }
        if let linkedin = linkedinTextField.text {
            CardHelper.updateValue(value: linkedin, key: CardSection.linkedin.rawValue)
        }
        if let facebook = facebookTextField.text {
            CardHelper.updateValue(value: facebook, key: CardSection.facebook.rawValue)
        }
        if let instagram = instagramTextField.text {
            CardHelper.updateValue(value: instagram, key: CardSection.instagram.rawValue)
        }
        if let twitter = twitterTextField.text {
            CardHelper.updateValue(value: twitter, key: CardSection.twitter.rawValue)
        }
        if let snapchat = snapchatTextField.text {
            CardHelper.updateValue(value: snapchat, key: CardSection.snapchat.rawValue)
        }
        if let tiktok = tiktokTextField.text {
            CardHelper.updateValue(value: tiktok, key: CardSection.tiktok.rawValue)
        }
        if let whatsapp = whatsappTextField.text {
            CardHelper.updateValue(value: whatsapp, key: CardSection.whatsapp.rawValue)
        }
        if let youtube = youtubeTextField.text {
            CardHelper.updateValue(value: youtube, key: CardSection.youtube.rawValue)
        }
        if let cashapp = cashappTextField.text {
            CardHelper.updateValue(value: cashapp, key: CardSection.cashapp.rawValue)
        }
        if let twitch = twitchTextField.text {
            CardHelper.updateValue(value: twitch, key: CardSection.twitch.rawValue)
        }
        if let github = githubTextField.text {
            CardHelper.updateValue(value: github, key: CardSection.github.rawValue)
        }
        if let soundcloud = soundcloudTextField.text {
            CardHelper.updateValue(value: soundcloud, key: CardSection.soundcloud.rawValue)
        }
    }
}

