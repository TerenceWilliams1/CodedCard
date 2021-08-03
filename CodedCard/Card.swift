//
//  Card.swift
//  CodedCard
//
//  Created by Terence Williams on 8/2/21.
//

import Foundation

class CardHelper{
    
    static let info = UserDefaults.standard
    
    static func updateValue(value: String, key: String) {
        UserDefaults.standard.setValue(value, forKey: key)
    }
    
    static func valueForKey(key: String) -> String {
        return UserDefaults.standard.value(forKey: key) as? String ?? ""
    }
}

enum CardSection: String {
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
