//
//  Coordinator.swift
//  Partyvity
//
//  Created by Raul Batista on 02.12.2023.
//

import Foundation
import Swinject
import Core

@MainActor
protocol Coordinator: AnyObject {
    var resolver: Resolver { get }
    var childCoordinators: [Coordinator] { get set }

    func start()
}

@MainActor
// MARK: - Dependency Injection
extension Coordinator {
    func resolve<Service>(_ serviceType: Service.Type, synchronize: Bool = false, argument: String? = nil) -> Service {
        guard synchronize else {
            if let argument = argument {
                // swiftlint:disable:next force_unwrapping
                return resolver.resolve(serviceType, argument: argument)!
            } else {
                // swiftlint:disable:next force_unwrapping
                return resolver.resolve(serviceType)!
            }
        }

        let container = resolver as? Container

        if let argument = argument {
            // swiftlint:disable:next force_unwrapping
            return container!.synchronize().resolve(serviceType, argument: argument)!
        } else {
            // swiftlint:disable:next force_unwrapping
            return container!.synchronize().resolve(serviceType)!
        }
    }

    func resolve<Service: ViewModelContaining>(_ serviceType: Service.Type, viewModel: Service.ViewModel, synchronize: Bool = false) -> Service? {
        var instance = resolve(serviceType, synchronize: synchronize)

        instance.viewModel = viewModel

        return instance
    }

    func resolve<Service: ViewModelContaining>(_ serviceType: Service.Type, viewModel: Service.ViewModel, synchronize: Bool = false, argument: String? = nil) -> Service? {
        var instance = resolve(serviceType, synchronize: synchronize, argument: argument)

        instance.viewModel = viewModel

        return instance
    }

    func resolve<Service, Argument>(_ serviceType: Service.Type, argument: Argument? = nil) -> Service {
        if let argument = argument {
            // swiftlint:disable:next force_unwrapping
            return resolver.resolve(serviceType, argument: argument)!
        } else {
            return resolve(serviceType)
        }
    }

    func resolve<Service, Arg1, Arg2>(_ serviceType: Service.Type, arguments arg1: Arg1, _ arg2: Arg2) -> Service {
        // swiftlint:disable:next force_unwrapping
        resolver.resolve(serviceType, arguments: arg1, arg2)!
    }

    func resolve<Service, Arg1, Arg2, Arg3>(_ serviceType: Service.Type, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> Service {
        // swiftlint:disable:next force_unwrapping
        resolver.resolve(serviceType, arguments: arg1, arg2, arg3)!
    }

    func resolve<Service, Arg1, Arg2, Arg3, Arg4>(_ serviceType: Service.Type, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) -> Service {
        // swiftlint:disable:next force_unwrapping
        resolver.resolve(serviceType, arguments: arg1, arg2, arg3, arg4)!
    }
    

    func release(coordinator: Coordinator) {
        childCoordinators.removeAll { $0 === coordinator }
    }

    func startChildCoordinator(_ childCoordinator: Coordinator) {
        childCoordinators.append(childCoordinator)
        childCoordinator.start()
    }

}
