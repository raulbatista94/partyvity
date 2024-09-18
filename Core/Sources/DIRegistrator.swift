//
//  DIRegistrator.swift
//
//
//  Created by Raul Batista on 25.02.2024.
//

import Foundation
import Swinject

public typealias CoreDataTeamStorage = TeamFetching
& TeamCreating

public typealias CoreDataGameStorage = GameFetching
& GameCreating

public extension DIRegistrator {
    typealias CoreDataRegistrationTypes = CoreDataTeamStorage & CoreDataGameStorage
}

public enum DIRegistrator {
    static let coreDataStorage: CoreDataRegistrationTypes = {
        do {
            let appGroup = "group.com.partyvity.app"
            let storeURL = URL.storeURL(for: appGroup, databaseName: "PartyvityDataModel")
            return try CoreDataStorage(storeURL: storeURL)
        } catch {
            assertionFailure("Failed to instantiate CoreData store with error: \(error.localizedDescription)")
            return NullStorage()
        }
    }()

    public static func registerStorage(container: Container) {
        container.register(TeamFetching.self) { [coreDataStorage] _ in
            coreDataStorage
        }
        .inObjectScope(.container)

        container.register(TeamCreating.self) { [coreDataStorage] _ in
            coreDataStorage
        }
        .inObjectScope(.container)

        container.register(GameCreating.self) { [coreDataStorage] _ in
            coreDataStorage
        }
        .inObjectScope(.container)

        container.register(GameFetching.self) { [coreDataStorage] _ in
            coreDataStorage
        }
        .inObjectScope(.container)
    }

    public static func registerServices(container: Container) {
        container.register(GameServicing.self) { [coreDataStorage] _ in
            GameService(storage: coreDataStorage)
        }
        .inObjectScope(.container)

        container.register(TeamService.self) { resolver in
            TeamService(storage: resolver.resolve(TeamService.Storage.self)!)
        }
        .inObjectScope(.container)

        container.register(WordProviding.self) { _ in
            WordService()
        }
        .inObjectScope(.container)
    }
}
