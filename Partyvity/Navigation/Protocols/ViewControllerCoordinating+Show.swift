//
//  ViewControllerCoordinating+Show.swift
//  Partyvity
//
//  Created by Raul Batista on 13.12.2023.
//

import Foundation
import UIKit

@MainActor
extension ViewControllerCoordinator {
    /// Push a new View Controller on the stack using `show` api
    /// - Parameters:
    ///   - viewController: the viewController to be pushed
    ///   - hidesBottomBarWhenPushed: default: true
    ///   - largeTitleDisplayMode: default: .automatic
    func show(
        _ viewController: UIViewController,
        hidesBottomBarWhenPushed: Bool = false,
        largeTitleDisplayMode: UINavigationItem.LargeTitleDisplayMode = .automatic
    ) {
        viewController.navigationItem.largeTitleDisplayMode = largeTitleDisplayMode
        viewController.hidesBottomBarWhenPushed = hidesBottomBarWhenPushed
        rootViewController.show(viewController, sender: rootViewController)
    }

    /// Presents a new View Controller
    /// - Parameters:
    ///   - viewController: the viewController to be presented
    ///   - presentationStyle: default: .pageSheet
    ///   - animated: default: true
    ///   - completion: default: nil
    func present(
        _ viewController: UIViewController,
        fromViewController: UIViewController? = nil,
        presentationStyle: UIModalPresentationStyle = .pageSheet,
        animated: Bool = true,
        completion: (()-> Void)? = nil
    ) {
        viewController.modalPresentationStyle = presentationStyle
        (fromViewController ?? rootViewController)
            .present(viewController, animated: animated, completion: completion)
    }
}
