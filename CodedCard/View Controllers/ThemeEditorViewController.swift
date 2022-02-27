//
//  ThemeEditorViewController.swift
//  CodedCard
//
//  Created by Terence Williams on 2/24/22.
//

import UIKit

class ThemeEditorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var sections: [ThemeSections] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
    }
    
    func setupData() {
        sections = [.avatar, .themeColor, .background]
        
        let settingsTableViewCell = UINib(nibName: "SettingsTableViewCell", bundle: nil)
        tableView.register(settingsTableViewCell, forCellReuseIdentifier: "SettingsTableViewCell")
    }
    
    //MARK: - Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as? SettingsTableViewCell
        let section = sections[indexPath.row]
        cell?.titleLabel.text = "Change \(section.rawValue)"
        DispatchQueue.main.async {
            cell?.iconImageView.image = section == .background ? UIImage(named: "GoldCard") : UIImage(named: "profile")
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = sections[indexPath.row]
        switch section {
        case .avatar:
            self.dismiss(animated: true, completion: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeAvatar"),
                                            object: nil,
                                            userInfo: nil)
            break
        case .themeColor:
            self.dismiss(animated: true, completion: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeTheme"),
                                            object: nil,
                                            userInfo: nil)
            break
        case .background:
            self.dismiss(animated: true, completion: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeBackground"),
                                            object: nil,
                                            userInfo: nil)
            break
        }
    }

}

enum ThemeSections: String {
    case avatar = "Avatar Image"
    case themeColor = "Theme Color"
    case background = "Background Image"
}
