//
//  PaywallViewController.swift
//  CodedCard
//
//  Created by Terence Williams on 2/24/22.
//

import UIKit
import SVProgressHUD

class PaywallViewController: UIViewController {
    
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(purchaseFailed), name: NSNotification.Name(rawValue: "featurePurchaseFailed"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(purchaseComplete), name: NSNotification.Name(rawValue: "plusFeatureUnlocked"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        IAPHandler.shared.fetchAvailableProducts()
        setupUI()
    }
    
    func setupUI() {
        actionButton.setTitle(CardHelper.isQuickPlus() ? "Currently Subscribed" : "Purchase Gold Card Status", for: .normal)
        actionButton.layer.cornerRadius = 20
        actionButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        actionButton.layer.shadowOffset = CGSize(width: 0.0, height: 8.0)
        actionButton.layer.shadowOpacity = 0.8
        actionButton.layer.shadowRadius = 0.0
        actionButton.layer.masksToBounds = false
        actionButton.backgroundColor = UIColor.QuikTheme.mustard
        subtitleLabel.textColor = UIColor.QuikTheme.mustard
        
        cardImageView.layoutIfNeeded()
        cardImageView.layer.cornerRadius = 15
        cardImageView.clipsToBounds = true
        
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        actionButton.addTarget(self, action: #selector(purchaseButtonTapped), for: .touchUpInside)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(enterPin))
        longPress.minimumPressDuration = 7.0
        longPress.delaysTouchesBegan = true
        longPress.delegate = self as? UIGestureRecognizerDelegate
        actionButton.addGestureRecognizer(longPress)
    }

    //MARK: Actions
    @objc func close() {
        self.dismiss(animated: true, completion:nil)
    }
    
    @objc func purchaseButtonTapped() {
        switch CardHelper.isQuickPlus() {
        case true:
            let alert = UIAlertController(title: "Great News",
                                          message: "You're already Gold Card status, and have complete access to the available features listed.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay 😊",
                                          style: .default,
                                          handler: nil))
            self.present(alert, animated: true, completion: nil)
            break;
        default:
            IAPHandler.shared.purchaseMyProduct(selectedProductID: "goldcard")
            break;
        }
    }

    @IBAction func purchaseFailed(){
        let alert = UIAlertController.init(title: "Ah Shucks", message: "Looks like something went wrong.\n\nTry again later or\n contact us.", preferredStyle: .alert)
        let cancelButton = UIAlertAction.init(title: "Okay", style: .default) { (UIAlertAction) in
                        self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(cancelButton)
        alert.view.tintColor = self.view.tintColor
//        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func purchaseComplete() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func enterPin() {
           let pinAlertView = UIAlertController(title: "Have a secret code?", message: "Enter your code here to unlock this feature.", preferredStyle: .alert)
           
           let vc1 = UIViewController()
           vc1.preferredContentSize = CGSize(width: self.view.frame.size.width,height: 70)
           vc1.view.tintColor = self.view.tintColor
           
           let codeField = UITextField.init(frame: CGRect.init(x:0, y: 0, width: self.view.frame.size.width, height: 50))
           codeField.placeholder = "Enter your code here"
           codeField.layer.cornerRadius = 8
           codeField.borderStyle = .roundedRect
           codeField.textAlignment = .left
           codeField.keyboardType = .phonePad
           codeField.becomeFirstResponder()
           vc1.view.addSubview(codeField)
           pinAlertView.setValue(vc1, forKey: "contentViewController")
           
           let submitAction = UIAlertAction(title: "Submit Code", style: .default) { (UIAlertAction) in
               if codeField.text == "7845" {
                   CardHelper.updateQuikPlan(plan: .plus)
                   CardHelper.plan = .plus
                   SVProgressHUD.showSuccess(withStatus: "Gold Card Status Activated")
                   SVProgressHUD.dismiss(withDelay: 1.5, completion: {
                       self.dismiss(animated: true, completion: nil)
                   })
                   
               } else {
                   SVProgressHUD.showError(withStatus: "Invalid Code")
                   SVProgressHUD.dismiss(withDelay: 1.5)
               }
           }
           let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (UIAlertAction) in
           }

           pinAlertView.addAction(cancelAction)
           pinAlertView.addAction(submitAction)
           pinAlertView.view.tintColor = self.view.tintColor
           self.present(pinAlertView, animated: true, completion: nil)
       }
}
