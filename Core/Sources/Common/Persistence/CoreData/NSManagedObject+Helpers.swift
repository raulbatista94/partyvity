//
//  NSManagedObject+Helpers.swift
//
//
//  Created by Raul Batista on 29.12.2023.
//

import CoreData

extension NSManagedObject {
    static func find<T: NSManagedObject>(
        in context: NSManagedObjectContext,
        predicate: NSPredicate? = nil
    ) throws -> T? {
        try findObjects(in: context, fetchLimit: 1, predicate: predicate).first
    }

    static func findObjects<T: NSManagedObject>(
        in context: NSManagedObjectContext,
        request: NSFetchRequest<T>? = nil,
        fetchLimit: Int = 0,
        predicate: NSPredicate? = nil
    ) throws -> [T] {
        // swiftlint:disable:next force_unwrapping
        let request = request ?? NSFetchRequest<T>(entityName: entity().name!)
        request.fetchLimit = fetchLimit
        request.returnsObjectsAsFaults = false
        request.predicate = predicate
        return try context.fetch(request)
    }

    static func deleteAll(
        in context: NSManagedObjectContext,
        predicate: NSPredicate? = nil
    ) throws {
        _ = try findObjects(in: context, predicate: predicate)
            .map(context.delete)
            .map(context.save)
    }
}
