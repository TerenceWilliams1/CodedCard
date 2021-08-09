//
//  QRCodeViewController.swift
//  CodedCard
//
//  Created by Terence Williams on 8/4/21.
//

import UIKit

class QRCodeViewController: UIViewController {
    
    @IBOutlet weak var QRImageView: UIImageView!
    @IBOutlet weak var urlLabel: UILabel!
    
    var item: CardSection = .avatar
    var url: String? = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        QRImageView.layer.cornerRadius = 24
        QRImageView.clipsToBounds = true
        
        if let QRImage = generateQRCode(from: url ?? "") {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.QRImageView.image = QRImage
                self.urlLabel.text = self.url
            }
        }
    }
    
    //MARK: - Helpers
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
}
