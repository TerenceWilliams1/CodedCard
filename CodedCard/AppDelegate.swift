//
//  AppDelegate.swift
//  CodedCard
//
//  Created by Terence Williams on 7/29/21.
//

import UIKit
import CoreData
import OneSignal
import SafariServices

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        CardHelper.updateNewVersionLaunchCount(count: CardHelper.newVersionLaunchCount() + 1)
        
        OneSignal.initWithLaunchOptions(launchOptions)
        OneSignal.setAppId("ac1e69b6-cb65-4f2d-9343-2c626630cc61")
        NotificationCenter.default.addObserver(self, selector: #selector(self.registerNotifications),
                                               name: NSNotification.Name(rawValue: "registerNotifications"),
                                               object: nil)
        
        return true
    }
    
    // MARK: - Notifications
    @objc func registerNotifications() {
        OneSignal.promptForPushNotifications(userResponse: { accepted in
            CardHelper.setHasSeenNotificationPrompt()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dismissInfoView"),
                                            object: nil,
                                            userInfo: nil)
            if accepted {
                UIApplication.shared.registerForRemoteNotifications()
            }
        })
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "CodedCard")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

