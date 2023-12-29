//
//  InfrastructureRegistration.swift
//  Partyvity
//
//  Created by Raul Batista on 29.12.2023.
//

import Foundation
import Swinject
import Core

typealias CoreDataTeamStorage = TeamFetching
& TeamCreating

final class InfrastructureRegistration: Assembly {
    let coreDataStorage: CoreDataRegistrationTypes = {
        do {
            let appGroup = "group.com.partyvity.app"
            let storeURL = URL.storeURL(for: appGroup, databaseName: "PartyvityDataModel")
            return try CoreDataStorage(storeURL: storeURL)
        } catch {
            assertionFailure("Failed to instantiate CoreData store with error: \(error.localizedDescription)")
            return NullStorage()
        }
    }()

    func assemble(container: Swinject.Container) {
        registerStorage(container: container)
    }
    
    func registerStorage(container: Swinject.Container) {
        container.register(TeamFetching.self) { [coreDataStorage] _ in
            coreDataStorage
        }
        .inObjectScope(.graph)

        container.register(TeamCreating.self) { [coreDataStorage] _ in
            coreDataStorage
        }
    }
}

extension InfrastructureRegistration {
    typealias CoreDataRegistrationTypes = CoreDataTeamStorage
}
