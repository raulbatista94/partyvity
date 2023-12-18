//
//  NavigationControllerCoordinating.swift
//  Partyvity
//
//  Created by Raul Batista on 13.12.2023.
//

import Foundation

import UIKit

protocol NavigationControllerCoordinator: ViewControllerCoordinator {
    var navigationController: UINavigationController { get }
}

extension NavigationControllerCoordinator {
    var rootViewController: UIViewController {
        navigationController
    }
}
