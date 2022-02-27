//
//  CardImagePickerViewController.swift
//  CodedCard
//
//  Created by Terence Williams on 2/23/22.
//

import UIKit

class CardImagePickerViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var actionButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    var imagerData: Data?
    
    @IBOutlet weak var cardImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            self.changeAvatarImage()
        }
    }
    
    func setupUI() {
        actionButton.layoutIfNeeded()
        actionButton.layer.cornerRadius = 20
        actionButton.clipsToBounds = true
        actionButton.backgroundColor = CardHelper.placeholderTheme()
        
        if let imgData = UserDefaults.standard.data(forKey: CardSection.background.rawValue) as NSData? {
            if let image = UIImage(data: imgData as Data) {
                self.cardImageView.image = image
            }
        }
    }
    
    @IBAction func changeImage() {
        self.changeAvatarImage()
    }
    
    func changeAvatarImage() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Choose a Photo", style: .default, handler: { (UIAlertAction) in
            self.imagePicker.delegate = self
            self.imagePicker.allowsEditing = true
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.allowsEditing = true
            self.imagePicker.modalPresentationStyle = .fullScreen
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Take a Photo", style: .default, handler: { (UIAlertAction) in
            self.imagePicker.delegate = self
            self.imagePicker.allowsEditing = true
            self.imagePicker.sourceType = .camera
            self.imagePicker.allowsEditing = true
            self.imagePicker.modalPresentationStyle = .fullScreen
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Remove Photo", style: .default, handler: { (UIAlertAction) in
            self.cardImageView.image = UIImage()
            self.closeView()
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { UIAlertAction in
            self.closeView()
        }))

        alert.view.tintColor = UIColor.darkGray
        
        let popPresenter = alert.popoverPresentationController
        popPresenter?.sourceView = cardImageView
        popPresenter?.sourceRect = cardImageView.bounds
        self.present(alert, animated: true, completion: nil)
    }
    
    func closeView() {
        if let image = cardImageView.image {
            let imageData = image.jpegData(compressionQuality: 1.0)
            UserDefaults.standard.setValue(imageData, forKey: CardSection.background.rawValue)
        }
        self.dismiss(animated: true, completion: nil)
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
        self.cardImageView.image = image
        self.imagerData = (image)!.pngData()
        if let image = cardImageView.image {
            let imageData = image.jpegData(compressionQuality: 1.0)
            UserDefaults.standard.setValue(imageData, forKey: CardSection.background.rawValue)
        }
        picker.dismiss(animated: true, completion: self.closeView)
    }

}
