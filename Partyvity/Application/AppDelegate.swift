//
//  AppDelegate.swift
//  Partyvity
//
//  Created by Raul Batista on 03.12.2023.
//

import Foundation
import UIKit

@main
class AppDelegate: NSObject, UIApplicationDelegate, AppCoordinatorContaining {
    var coordinator: AppCoordinating!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        coordinator = AppCoordinator()
        coordinator.start()
        
        return true
    }
}
