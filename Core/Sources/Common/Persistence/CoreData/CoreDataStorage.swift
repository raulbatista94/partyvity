//
//  File.swift
//
//
//  Created by Raul Batista on 03.12.2023.
//

import Foundation
@preconcurrency import CoreData

public actor CoreDataStorage: Sendable {
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
}
