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
}

enum ThemeColors: String {
    case purple = "716CB7"
    case blue = "74B0F9"
    case accent = "E8CA9E"
    case accent2 = "C0CECF"
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}
