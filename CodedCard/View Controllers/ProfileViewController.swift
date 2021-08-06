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

    @IBOutlet weak var collectionView: UICollectionView!
    
    var sections: [CardSection] = []
    var imagePicker = UIImagePickerController()
    var avatarData: Data?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
    }
    
    func setupUI() {
        containerView.layoutIfNeeded()
        containerView.layer.cornerRadius = 30
        containerView.clipsToBounds = true
        
        profileImageView.layoutIfNeeded()
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
        profileImageView.layer.borderWidth = 3
        profileImageView.layer.borderColor = UIColor.init(hex: ThemeColors.blue.rawValue)?.cgColor
        
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
    }
    
    func setupData() {
        sections = [.phone, .email, .address, .website, .linkedin,
                    .facebook, .instagram, .twitter, .snapchat, .tiktok,
                    .whatsapp, .youtube, .cashapp, .twitch, .github, .soundcloud,
                    .linktree, .venmo, .spotify, .etsy, .applemusic]
        
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
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeAndSave() {
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
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer? = nil) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Choose a photo", style: .default, handler: { (UIAlertAction) in
            self.imagePicker.delegate = self
            self.imagePicker.allowsEditing = true
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.allowsEditing = true
            self.imagePicker.modalPresentationStyle = .fullScreen
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Take a photo", style: .default, handler: { (UIAlertAction) in
            self.imagePicker.delegate = self
            self.imagePicker.allowsEditing = true
            self.imagePicker.sourceType = .camera
            self.imagePicker.allowsEditing = true
            self.imagePicker.modalPresentationStyle = .fullScreen
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Remove photo", style: .default, handler: { (UIAlertAction) in
            self.profileImageView.image = UIImage(named: "QuikCard1024.jpg")
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        alert.view.tintColor = self.view.tintColor
        self.present(alert, animated: true, completion: nil)
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
}
