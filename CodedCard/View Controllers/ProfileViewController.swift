//
//  ProfileViewController.swift
//  CodedCard
//
//  Created by Terence Williams on 8/5/21.
//

import UIKit
import DTOverlayController
import Photos


class ProfileViewController: UIViewController, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    //Bio Section
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var bioView: UIView!

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var headlineTextField: UITextField!
    @IBOutlet weak var closeButton: UIButton!

    @IBOutlet weak var collectionView: UICollectionView!
    
    var sections: [CardSection] = []
    var imagePicker = UIImagePickerController()
    var avatarData: Data?
    var themeColor: UIColor = CardHelper.theme()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
    }
    
    func setupUI() {
        bioView.backgroundColor = themeColor
        
        containerView.layoutIfNeeded()
        containerView.layer.cornerRadius = 30
        containerView.clipsToBounds = true
        
        profileImageView.layoutIfNeeded()
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.white.cgColor
        
        nameTextField.delegate = self
        companyTextField.delegate = self
        titleTextField.delegate = self
        headlineTextField.delegate = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        let profileItemCollectionViewCell = UINib(nibName: "ProfileItemCollectionViewCell", bundle: nil)
        collectionView.register(profileItemCollectionViewCell, forCellWithReuseIdentifier: "ProfileItemCollectionViewCell")

        let tap = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(_:)))
        profileImageView.addGestureRecognizer(tap)
        
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Name",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.6)])
        companyTextField.attributedPlaceholder = NSAttributedString(string: "Company",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.6)])
        titleTextField.attributedPlaceholder = NSAttributedString(string: "Title",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.6)])
        headlineTextField.attributedPlaceholder = NSAttributedString(string: "Headline",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.6)])
    }
    
    func setupData() {
        sections = [.phone, .email, .address, .website, .website2, .website3, .linkedin,
                    .facebook, .instagram, .twitter, .snapchat, .tiktok,
                    .whatsapp, .pinterest, .youtube, .cashapp, .twitch, .github, .soundcloud,
                    .linktree, .venmo, .etsy, .spotify, .applemusic]
        
        if CardHelper.valueForKey(key: CardSection.name.rawValue) != "" {
            nameTextField.text = CardHelper.valueForKey(key: CardSection.name.rawValue)
        }
        if CardHelper.valueForKey(key: CardSection.title.rawValue) != "" {
            titleTextField.text = CardHelper.valueForKey(key: CardSection.title.rawValue)
        }
        if CardHelper.valueForKey(key: CardSection.header.rawValue) != "" {
            headlineTextField.text = CardHelper.valueForKey(key: CardSection.header.rawValue)
        }
        if CardHelper.valueForKey(key: CardSection.company.rawValue) != "" {
            companyTextField.text = CardHelper.valueForKey(key: CardSection.company.rawValue)
        }
        if let imgData = UserDefaults.standard.data(forKey: CardSection.avatar.rawValue) as NSData? {
            if let image = UIImage(data: imgData as Data) {
                self.profileImageView.image = image
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateTheme),
                                               name: NSNotification.Name(rawValue: QuikValues.didUpdateTheme.rawValue),
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshPage),
                                               name: NSNotification.Name(rawValue: QuikValues.refreshProfile.rawValue),
                                               object: nil)
    }
    
    //MARK: - Text Field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: - Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileItemCollectionViewCell", for: indexPath) as? ProfileItemCollectionViewCell
        
        let item = sections[indexPath.row]
        cell?.titleLabel.text = item.rawValue.capitalized
        cell?.iconImageView.image = UIImage(named: item.rawValue)
        cell?.backgroundImageView.backgroundColor = themeColor
        cell?.backgroundImageView.alpha = statusForSection(item: item) ? 1.0 : 0.6
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        nameTextField.resignFirstResponder()
        headlineTextField.resignFirstResponder()
        companyTextField.resignFirstResponder()
        titleTextField.resignFirstResponder()
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        let item = sections[indexPath.row]
        
        let editLinkViewController = self.storyboard?.instantiateViewController(withIdentifier: "EditLinkViewController") as! EditLinkViewController
        editLinkViewController.item = item

        let overlayController = DTOverlayController(viewController: editLinkViewController)
        overlayController.overlayHeight = .dynamic(0.8)
        overlayController.isPanGestureEnabled = true
        present(overlayController, animated: true, completion: nil)
    }
    
    //MARK: - Actions
    @IBAction func closeView() {
        let alert = UIAlertController(title: nil, message: "Are you sure you want to discard your profile changes?", preferredStyle: .actionSheet)
                
        alert.addAction(UIAlertAction(title: "Discard Changes", style: .default, handler: { UIAlertAction in
            CardHelper.updatePlaceholderTheme(color: CardHelper.theme())
            self.dismiss(animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Keep Editing", style: .cancel, handler: nil))
        alert.view.tintColor = UIColor.darkGray
        
        let popPresenter = alert.popoverPresentationController
        popPresenter?.sourceView = closeButton
        popPresenter?.sourceRect = closeButton.bounds
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func closeAndSave() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        if let name = nameTextField.text {
            CardHelper.updateValue(value: name, key: CardSection.name.rawValue)
        }
        if let title = titleTextField.text {
            CardHelper.updateValue(value: title, key: CardSection.title.rawValue)
        }
        if let header = headlineTextField.text {
            CardHelper.updateValue(value: header, key: CardSection.header.rawValue)
        }
        if let company = companyTextField.text {
            CardHelper.updateValue(value: company, key: CardSection.company.rawValue)
        }
        if let image = profileImageView.image {
            let imageData = image.jpegData(compressionQuality: 1.0)
            UserDefaults.standard.setValue(imageData, forKey: CardSection.avatar.rawValue)
        }
        
        CardHelper.updateTheme(color: themeColor)
        CardHelper.updatePlaceholderTheme(color: themeColor)

        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer? = nil) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Take a photo", style: .default, handler: { (UIAlertAction) in
            self.imagePicker.delegate = self
            self.imagePicker.allowsEditing = true
            self.imagePicker.sourceType = .camera
            self.imagePicker.allowsEditing = true
            self.imagePicker.modalPresentationStyle = .fullScreen
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Choose a photo", style: .default, handler: { (UIAlertAction) in
            self.imagePicker.delegate = self
            self.imagePicker.allowsEditing = true
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.allowsEditing = true
            self.imagePicker.modalPresentationStyle = .fullScreen
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Remove photo", style: .default, handler: { (UIAlertAction) in
            self.profileImageView.image = UIImage(named: "QuikCard1024.jpg")
        }))
        
        alert.addAction(UIAlertAction(title: "Change Theme Color", style: .default, handler: { (UIAlertAction) in
            self.changeTheme()
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        alert.view.tintColor = UIColor.darkGray
        
        let popPresenter = alert.popoverPresentationController
        popPresenter?.sourceView = profileImageView
        popPresenter?.sourceRect = profileImageView.bounds
        self.present(alert, animated: true, completion: nil)
    }
    
    func changeTheme() {
        let themeViewController = self.storyboard?.instantiateViewController(withIdentifier: "ThemeViewController") as! ThemeViewController

        let overlayController = DTOverlayController(viewController: themeViewController)
        overlayController.overlayHeight = .dynamic(0.4)
        overlayController.isPanGestureEnabled = false
        present(overlayController, animated: true, completion: nil)
    }
    
    @objc func updateTheme() {
        themeColor = CardHelper.placeholderTheme()
        self.refreshPage()
    }
    
    @objc func refreshPage() {
        self.setupUI()
        self.collectionView.reloadData()
    }
    
    //MARK: - UIImage Picker Delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var image: UIImage!
        
        if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            image = img
        }
        else if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = img
        }
        self.profileImageView.image = image
        self.avatarData = (image)!.pngData()
        picker.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Helpers
    func statusForSection(item: CardSection) -> Bool {
        return CardHelper.valueForKey(key: item.rawValue) != ""
    }
}
