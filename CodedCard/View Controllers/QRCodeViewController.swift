//
//  QRCodeViewController.swift
//  CodedCard
//
//  Created by Terence Williams on 8/4/21.
//

import UIKit
import Photos

class QRCodeViewController: UIViewController {
    
    @IBOutlet weak var QRImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var quikcardLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    
    var item: CardSection = .avatar
    var url: String? = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        backgroundImageView.backgroundColor = CardHelper.theme()
        titleLabel.text = title(_forItem: item)

        if let qrImage = generateQRCode(from: url ?? "") {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.QRImageView.image = qrImage
                self.urlLabel.text = CardHelper.valueForKey(key: self.item.rawValue)
            }
        }
    }
    
    //MARK: - Helpers
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 32, y: 32)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output.tinted(using: .white)!)
            }
        }
        return nil
    }
    
    func title(_forItem item: CardSection) -> String {
        switch item {
        case .venmo:
            return "Scan to pay with \(item.rawValue.capitalized)"
        case .cashapp:
            return "Scan to pay with Cash App"
        case .address:
            return "Scan to for address"
        case .phone:
            return "Scan for phone number"
        case .website2, .website, .website3, .linktree:
            return "Scan to visit website"
        case .spotify, .applemusic:
            return "Scan to listen on \(item.rawValue.capitalized)"
        default:
            return "Scan to connect via \(item.rawValue.capitalized)"
        }
    }
    
    //MARK: - Actions
    @IBAction func share() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Share QR Code", style: .default, handler: { UIAlertAction in
            self.shareButton.isHidden = true
            
            var screenshotImage :UIImage?
            let layer = self.view.layer
            layer.frame.size.height = self.quikcardLabel.frame.origin.y + self.quikcardLabel.bounds.height + 10
            UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, 0.0);
            let context = UIGraphicsGetCurrentContext()
            layer.render(in:context!)
            screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            if let image = screenshotImage {
                let itemsToShare = [image] as [Any]
                
                let activityViewController = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view
                self.present(activityViewController, animated: true, completion: nil)
            }
            
            self.shareButton.isHidden = false
        }))
        
        alert.addAction(UIAlertAction(title: "Share Link", style: .default, handler: { UIAlertAction in
            if let url = self.url {
                let itemsToShare = [url] as [Any]
                
                let activityViewController = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view
                self.present(activityViewController, animated: true, completion: nil)
            }

        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
        alert.view.tintColor = UIColor.darkGray
        
        let popPresenter = alert.popoverPresentationController
        popPresenter?.sourceView = shareButton
        popPresenter?.sourceRect = shareButton.bounds
        self.present(alert, animated: true, completion: nil)
        }
}
