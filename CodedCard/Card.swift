//
//  Card.swift
//  CodedCard
//
//  Created by Terence Williams on 8/2/21.
//

import Foundation
import UIKit

class CardHelper{
    
    static let info = UserDefaults.standard
    
    static func updateValue(value: Any, key: String) {
        UserDefaults.standard.setValue(value, forKey: key)
    }
    
    static func valueForKey(key: String) -> String {
        return UserDefaults.standard.value(forKey: key) as? String ?? ""
    }
    
    static func theme() -> UIColor {
        return UserDefaults.standard.colorForKey(key: QuikValues.themeColor.rawValue) ?? .black
    }
    
    static func placeholderTheme() -> UIColor {
        return UserDefaults.standard.colorForKey(key: QuikValues.temporaryThemeColor.rawValue) ?? .black
    }
    
    static func updatePlaceholderTheme(color: UIColor) {
        UserDefaults.standard.setColor(color: color, forKey: QuikValues.temporaryThemeColor.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    static func updateTheme(color: UIColor) {
        UserDefaults.standard.setColor(color: color, forKey: QuikValues.themeColor.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    static func shouldShowWalkthrough() -> Bool {
        return !UserDefaults.standard.bool(forKey: "hasSeenWalkThrough")
    }
    
    static func setHasSeenWalkthrough() {
        UserDefaults.standard.setValue(true, forKey: "hasSeenWalkThrough")
    }
    
    static func newVersionLaunchCount() -> Int {
        return UserDefaults.standard.integer(forKey: "newVersionLaunch1")
    }
    
    static func updateNewVersionLaunchCount(count: Int) {
           UserDefaults.standard.set(count, forKey: "newVersionLaunch1")
    }
    
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

enum CardSection: String {
    case avatar = "avatar"
    case name = "name"
    case title = "title"
    case header = "header"
    case company = "company"
    case email = "email"
    case phone = "phone"
    case address = "address"
    case website = "website"
    case website2 = "website2"
    case website3 = "website3"
    case linkedin = "linkedin"
    case facebook = "facebook"
    case instagram = "instagram"
    case twitter = "twitter"
    case snapchat = "snapchat"
    case tiktok = "tiktok"
    case whatsapp = "whatsapp"
    case youtube = "youtube"
    case cashapp = "cashapp"
    case twitch = "twitch"
    case github = "github"
    case soundcloud = "soundcloud"
    case linktree = "linktree"
    case spotify = "spotify"
    case applemusic = "apple music"
    case etsy = "etsy"
    case venmo = "venmo"
    
}

enum LinkPrefix: String {
    case none = ""
    case linkedin = "https://www.linkedin.com/in/"
    case facebook = "https://www.facebook.com/"
    case instagram = "https://www.instagram.com/"
    case twitter = "https://www.twitter.com/"
    case snapchat = "https://www.snapchat.com/add/"
    case tiktok = "https://www.tiktok.com/@"
    case whatsapp = "https://api.whatsapp.com/send?phone="
    case youtube = "https://www.youtube.com/"
    case cashapp = "https://www.cash.app/$"
    case twitch = "https://www.twitch.tv/"
    case github = "https://www.github.com/"
    case soundcloud = "https://www.soundcloud.com/"
    case venmo = "https://venmo.com/"
    case etsy = "https://www.etsy.com/shop/"
}

enum ThemeColors: String {
    case purple = "#716CB7"
    case blue = "#74B0F9"
    case accent = "#E8CA9E"
    case accent2 = "#C0CECF"
}

enum QuikValues: String {
    case themeColor = "themeColor"
    case temporaryThemeColor = "temporaryThemeColor"
    
    case didUpdateTheme = "didUpdateTheme"
    case refreshProfile = "refreshProfile"
}

extension UIColor {
    
    struct QuikTheme {
        static var steelBlue: UIColor { return UIColor(hexaRGBA: "#4581bc")! }
        static var wellRead: UIColor { return UIColor(hexaRGBA: "#C2555c")! }
        static var mint: UIColor { return UIColor(hexaRGBA: "#7fd08c")! }
        static var violet: UIColor { return UIColor(hexaRGBA: "#CBAACB")! }
        static var sorbet: UIColor { return UIColor(hexaRGBA: "#FFCCB6")! }
        static var seashell: UIColor { return UIColor(hexaRGBA: "#8FCACA")! }
        static var rose: UIColor { return UIColor(hexaRGBA: "#E3BFB7")! }
        static var charcoal: UIColor { return UIColor(hexaRGBA: "#8A9BA7")! }
        static var springGreen: UIColor { return UIColor(hexaRGBA: "#7ABAA1")! }
        static var maroon: UIColor { return UIColor(hexaRGBA: "#80003A")! }
        static var midnight: UIColor { return UIColor(hexaRGBA: "#445A67")! }
        static var coffee: UIColor { return UIColor(hexaRGBA: "#C9BB9F")! }
        static var evergreen: UIColor { return UIColor(hexaRGBA: "#3D9776")! }
        static var mustard: UIColor { return UIColor(hexaRGBA: "#EDCC8B")! }


//        static var purple: UIColor { return UIColor(hex: "#716CB7")! }
//        static var charcal: UIColor { return UIColor(hex: "#4C535B")! }
//        static var green: UIColor { return UIColor(hex: "#4cab69")! }
//        static var cranberry: UIColor { return UIColor(hex: "#994550")! }
//        static var mango: UIColor { return UIColor(hex: "#F3a34e")! }
//        static var lavendar: UIColor { return UIColor(hex: "#BB7DC2")! }
    }
        
    convenience init?(hexaRGB: String, alpha: CGFloat = 1) {
            var chars = Array(hexaRGB.hasPrefix("#") ? hexaRGB.dropFirst() : hexaRGB[...])
            switch chars.count {
            case 3: chars = chars.flatMap { [$0, $0] }
            case 6: break
            default: return nil
            }
            self.init(red: .init(strtoul(String(chars[0...1]), nil, 16)) / 255,
                    green: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                     blue: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                    alpha: alpha)
        }

        convenience init?(hexaRGBA: String) {
            var chars = Array(hexaRGBA.hasPrefix("#") ? hexaRGBA.dropFirst() : hexaRGBA[...])
            switch chars.count {
            case 3: chars = chars.flatMap { [$0, $0] }; fallthrough
            case 6: chars.append(contentsOf: ["F","F"])
            case 8: break
            default: return nil
            }
            self.init(red: .init(strtoul(String(chars[0...1]), nil, 16)) / 255,
                    green: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                     blue: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                    alpha: .init(strtoul(String(chars[6...7]), nil, 16)) / 255)
        }

        convenience init?(hexaARGB: String) {
            var chars = Array(hexaARGB.hasPrefix("#") ? hexaARGB.dropFirst() : hexaARGB[...])
            switch chars.count {
            case 3: chars = chars.flatMap { [$0, $0] }; fallthrough
            case 6: chars.append(contentsOf: ["F","F"])
            case 8: break
            default: return nil
            }
            self.init(red: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                    green: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                     blue: .init(strtoul(String(chars[6...7]), nil, 16)) / 255,
                    alpha: .init(strtoul(String(chars[0...1]), nil, 16)) / 255)
        }
}

extension String {
    func image() -> UIImage? {
        let size = CGSize(width: 40, height: 40)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.white.set()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(CGRect(origin: .zero, size: size))
        (self as AnyObject).draw(in: rect, withAttributes: [.font: UIFont.systemFont(ofSize: 40)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

extension UserDefaults {
    func colorForKey(key: String) -> UIColor? {
    var colorReturnded: UIColor?
    if let colorData = data(forKey: key) {
      do {
        if let color = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(colorData) as? UIColor {
          colorReturnded = color
        }
      } catch {
        print("Error UserDefaults")
      }
    }
    return colorReturnded
  }
  
   func setColor(color: UIColor?, forKey key: String) {
    var colorData: NSData?
    if let color = color {
      do {
        let data = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false) as NSData?
        colorData = data
      } catch {
        print("Error UserDefaults")
      }
    }
    set(colorData, forKey: key)
  }
}
