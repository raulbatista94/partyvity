//
//  ScreenFactory+Initial.swift
//  Partyvity
//
//  Created by Raul Batista on 15.12.2023.
//

import Foundation
import UIKit
import SharedUI

extension ScreenFactory {
    @MainActor
    enum Initial {
        static func makeInitialScreen() -> UIViewController {
            let initialScreen = HostingController(rootView: InitialView())
            return initialScreen
        }
    }
}
