//
//  AppCoordinating.swift
//  Partyvity
//
//  Created by Raul Batista on 02.12.2023.
//

import Foundation
import UIKit

protocol AppCoordinating: Coordinator {
    func didLaunchScene<Coordinator: SceneCoordinating>(
        _ scene: UIScene,
        window: UIWindow
    ) -> Coordinator

    func didDisconnectScene(_ scene: UIScene)
}
