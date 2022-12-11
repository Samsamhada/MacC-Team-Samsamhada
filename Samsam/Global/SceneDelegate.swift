//
//  SceneDelegate.swift
//  Samsam
//
//  Created by 김민택 on 2022/10/17.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        var navi = UINavigationController(rootViewController: RoomListViewController())
        if (UserDefaults.standard.integer(forKey: "workerID") == 0) || (UserDefaults.standard.string(forKey: "number") == nil) {
            navi = UINavigationController(rootViewController: LoginViewController())
        }
        window?.rootViewController = navi
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}

