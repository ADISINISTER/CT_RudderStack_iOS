//
//  AppDelegate.swift
//  RudderStack
//
//  Created by Aditya Sinha on 14/04/25.
//

import UIKit
import Rudder
import Rudder_CleverTap
import UserNotifications
import CleverTapSDK
//import RudderCleverTapIntegration


@main
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate{



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Register for push notifications
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }

        
        let builder = RSConfigBuilder()
           .withDataPlaneUrl("https://clevertaplnyyb.dataplane.rudderstack.com")
           .withFactory(RudderCleverTapFactory.instance())
           .withDebug(true)
        RSClient.getInstance("2vhzd8uyRadh6J6GYLgQwCx601B", config: builder.build())
        // Override point for customization after application launch.
        CleverTap.setDebugLevel(CleverTapLogLevel.debug.rawValue)
        return true
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
    
    // Called when the app fails to register for remote (push) notifications
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        NSLog("Failed to register for remote notifications: %@", error.localizedDescription)
    }
    
    // MARK: - Push Token Registration
        func application(_ application: UIApplication,
                             didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
            NSLog("Here in registering push token APNS")
            RudderCleverTapIntegration().registeredForRemoteNotifications(withDeviceToken: deviceToken)
        }

        // MARK: - Remote Notification Received (Background/Foreground)
        func application(_ application: UIApplication,
                         didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                         fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
            RudderCleverTapIntegration().receivedRemoteNotification(userInfo)
            completionHandler(.noData)
        }

        // MARK: - Foreground Notification Presentation
        func userNotificationCenter(_ center: UNUserNotificationCenter,
                                    willPresent notification: UNNotification,
                                    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            completionHandler([.alert, .sound, .badge])
        }

        // MARK: - Notification Tapped
        func userNotificationCenter(_ center: UNUserNotificationCenter,
                                    didReceive response: UNNotificationResponse,
                                    withCompletionHandler completionHandler: @escaping () -> Void) {
            RudderCleverTapIntegration().receivedRemoteNotification(response.notification.request.content.userInfo)
            completionHandler()
        }

}

