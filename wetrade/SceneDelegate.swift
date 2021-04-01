//
//  SceneDelegate.swift
//  wetrade
//
//  Created by Kazim Walji on 12/21/20.
//

import UIKit
import FirebaseAuth
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = SignUpViewController()
        window.makeKeyAndVisible()
        self.window = window
    }
    
}

