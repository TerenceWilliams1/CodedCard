import UIKit
import StoreKit
import KeychainAccess
import SVProgressHUD

enum IAPHandlerAlertType{
    case disabled
    case restored
    case purchased
    
    func message() -> String{
        switch self {
        case .disabled: return "Purchases are disabled in your device!"
        case .restored: return "You've successfully restored your purchase!"
        case .purchased: return "Thank you for your kindness!😊\nYour donation was successful."
        }
    }
}


class IAPHandler: NSObject {
    static let shared = IAPHandler.init()
    let GOLD_CARD = "goldcard"
    
    fileprivate var purchasedProductIdentifiers: [String] = []
    fileprivate var productID = ""
    fileprivate var productsRequest = SKProductsRequest()
    fileprivate var iapProducts = [SKProduct]()

    var selectedProductId = ""
    var purchaseStatusBlock: ((IAPHandlerAlertType) -> Void)?
    
    func canMakePurchases() -> Bool {  return SKPaymentQueue.canMakePayments()  }
    
    func purchaseMyProduct(selectedProductID: String) {
        if iapProducts.count == 0 { return }
        
        if self.canMakePurchases() {
            var selectedProduct = SKProduct.init()
            for product in iapProducts {
                if product.productIdentifier == selectedProductID {
                    selectedProduct = product
                    self.selectedProductId = selectedProduct.productIdentifier
                    let payment = SKPayment(product: selectedProduct)
                    SKPaymentQueue.default().add(self)
                    SKPaymentQueue.default().add(payment)
                    
                    print("PRODUCT TO PURCHASE: \(selectedProduct.productIdentifier)")
                    productID = selectedProduct.productIdentifier
                }
            }
        } else {
            purchaseStatusBlock?(.disabled)
        }
    }
    
    // MARK: - RESTORE PURCHASE
    func restorePurchase(){
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    // MARK: - FETCH AVAILABLE IAP PRODUCTS
    func fetchAvailableProducts(){
        // Put here your IAP Products ID's
        let productIdentifiers = NSSet(objects: GOLD_CARD
        )
        productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers as! Set<String>)
        productsRequest.delegate = self
        productsRequest.start()
    }
}

extension IAPHandler: SKProductsRequestDelegate, SKPaymentTransactionObserver{
    // MARK: - REQUEST IAP PRODUCTS
    func productsRequest (_ request:SKProductsRequest, didReceive response:SKProductsResponse) {
        if (response.products.count > 0) {
            iapProducts = response.products
            for product in iapProducts {
                if CardHelper.isQuickPlus() && product.productIdentifier == "goldcard" {
                    self.purchasedProductIdentifiers.append("goldcard")
                }
                let purchased = UserDefaults.standard.bool(forKey: product.productIdentifier)
                if purchased {
                    switch product.productIdentifier {
                    case "goldcard":
                        CardHelper.updateQuikPlan(plan: .plus)
                        CardHelper.plan = .plus
                    default:
                        break
                    }
                    CardHelper.purchasedProducts?.append(product)
                    self.purchasedProductIdentifiers.append(product.productIdentifier)
                }
                let numberFormatter = NumberFormatter()
                numberFormatter.formatterBehavior = .behavior10_4
                numberFormatter.numberStyle = .currency
                numberFormatter.locale = product.priceLocale
                let price1Str = numberFormatter.string(from: product.price)
                print(product.localizedDescription + "\nfor just \(price1Str!)")
            }
        }
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        purchaseStatusBlock?(.restored)
    }
    
    // MARK:- IAP PAYMENT QUEUE
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction:AnyObject in transactions {
            if let trans = transaction as? SKPaymentTransaction {
                switch trans.transactionState {
                case .purchased:
                    
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    UserDefaults.standard.set(true, forKey: self.selectedProductId)
                    switch self.selectedProductId {
                    case GOLD_CARD:
                        CardHelper.updateQuikPlan(plan: .plus)
                        NotificationCenter.default.post(name: NSNotification.Name.init("featureUnlocked"),
                                                        object: nil)
                    default:
                        break;
                    }
                case .failed:
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    NotificationCenter.default.post(name: NSNotification.Name.init("featurePurchaseFailed"),
                                                    object: nil)
                case .restored:
                    UserDefaults.standard.set(true, forKey: self.selectedProductId)
                    switch self.selectedProductId {
                    case GOLD_CARD:
                        CardHelper.updateQuikPlan(plan: .plus)
                        break
                    default:
                        break;
                    }
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    break
                case .purchasing:
                    SVProgressHUD.show(withStatus: "Purchasing...")
                    SVProgressHUD.dismiss(withDelay: 2.5)
                    break;
                default: break
                }
            }
        }
    }
}
