//
//  InfrastructureRegistration.swift
//  Partyvity
//
//  Created by Raul Batista on 29.12.2023.
//

import Foundation
import Swinject
import enum Core.DIRegistrator
import enum SharedUI.DIRegistrator

final class InfrastructureRegistration: Assembly {
    func assemble(container: Swinject.Container) {
        Core.DIRegistrator.registerStorage(container: container)
        Core.DIRegistrator.registerServices(container: container)
        SharedUI.DIRegistrator.registerViewModel(container: container)
    }
}
