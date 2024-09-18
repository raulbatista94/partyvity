//
//  SceneCoordinating.swift
//  Partyvity
//
//  Created by Raul Batista on 02.12.2023.
//

import Foundation
import UIKit
import Swinject

protocol SceneCoordinating: Coordinator {
    var window: UIWindow { get }
    init(window: UIWindow, resolver: Resolver)
}

@MainActor
extension SceneCoordinating {
    func setRootCoordinator(_ coordinator: ViewControllerCoordinator, animated: Bool = false) {
        childCoordinators = [coordinator]
        coordinator.start()

        window.rootViewController = coordinator.rootViewController
        window.makeKeyAndVisible()

        if animated {
            UIView.transition(
                with: window,
                duration: 0.3,
                options: .transitionCrossDissolve,
                animations: nil,
                completion: nil
            )
        }
    }
}
