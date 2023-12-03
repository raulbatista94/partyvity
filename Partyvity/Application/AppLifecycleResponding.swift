//
//  AppLifecycleResponding.swift
//  Partyvity
//
//  Created by Raul Batista on 03.12.2023.
//

import Foundation
import UIKit

protocol AppLifecycleResponding {
    func sceneWillEnterForeground(_ scene: UIScene)
    func sceneDidEnterBackground(_ scene: UIScene)
}

extension AppLifecycleResponding {
    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
