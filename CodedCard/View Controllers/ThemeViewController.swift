//
//  ThemeViewController.swift
//  CodedCard
//
//  Created by Terence Williams on 8/11/21.
//

import UIKit

class ThemeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var themes: [UIColor] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()

        collectionView.delegate = self
        collectionView.dataSource = self
        let themeCollectionViewCell = UINib(nibName: "ThemeCollectionViewCell", bundle: nil)
        collectionView.register(themeCollectionViewCell, forCellWithReuseIdentifier: "ThemeCollectionViewCell")
    }
    
    func setupData() {
        themes = [UIColor.QuikTheme.steelBlue,
                  UIColor.QuikTheme.wellRead,
                  UIColor.QuikTheme.mint,
                  UIColor.QuikTheme.violet,
                  UIColor.QuikTheme.sorbet,
                  UIColor.QuikTheme.seashell,
                  UIColor.QuikTheme.rose,
                  UIColor.QuikTheme.charcoal,
                  UIColor.QuikTheme.springGreen,
                  UIColor.QuikTheme.maroon,
                  UIColor.QuikTheme.midnight,
                  UIColor.QuikTheme.coffee,
                  UIColor.QuikTheme.evergreen,
                  UIColor.QuikTheme.mustard,
                  UIColor.QuikTheme.orange,
                  UIColor.QuikTheme.yellow]
    }
    
    //MARK: - Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        themes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThemeCollectionViewCell", for: indexPath)
        cell.backgroundColor = themes[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let theme = themes[indexPath.row]
        CardHelper.updatePlaceholderTheme(color: theme)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: QuikValues.didUpdateTheme.rawValue),
                                        object: nil,
                                        userInfo: nil)
        self.dismiss(animated: true, completion: nil)
    }

}
