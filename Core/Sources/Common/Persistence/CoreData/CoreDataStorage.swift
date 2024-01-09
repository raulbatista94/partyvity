//
//  CoreDataStorage.swift
//
//
//  Created by Raul Batista on 03.12.2023.
//

import Foundation
@preconcurrency import CoreData

public final class CoreDataStorage: Sendable {
    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext

    public init(storeURL: URL) throws {
        container = try NSPersistentContainer.load(
            modelName: "PartyvityDataModel",
            url: storeURL,
            in: Bundle.module
        )

        context = container.newBackgroundContext()
    }

    deinit {
        cleanUpReferencesToPersistentStores()
    }

    func perform<T>(_ action: @escaping (NSManagedObjectContext) throws -> T) async throws -> T {
        let context = context
        return try await context.perform { try action(context) }
    }
}

private extension CoreDataStorage {
    func cleanUpReferencesToPersistentStores() {
        context.performAndWait {
            let coordinator = self.container.persistentStoreCoordinator
            try? coordinator.persistentStores.forEach(coordinator.remove)
        }
    }
}
