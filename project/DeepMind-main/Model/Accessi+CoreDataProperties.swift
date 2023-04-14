//
//  Accessi+CoreDataProperties.swift
//  DeepMind
//
//  Created by Simone Salzano on 29/04/21.
//
//

import Foundation
import CoreData


extension Accessi {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Accessi> {
        return NSFetchRequest<Accessi>(entityName: "Accessi")
    }

    @NSManaged public var data: Date?
    @NSManaged public var tempoSessione: String?
    @NSManaged public var erroriInSessione: NSSet?
    @NSManaged public var tentativiInSessione: NSSet?

}

// MARK: Generated accessors for erroriInSessione
extension Accessi {

    @objc(addErroriInSessioneObject:)
    @NSManaged public func addToErroriInSessione(_ value: Errori)

    @objc(removeErroriInSessioneObject:)
    @NSManaged public func removeFromErroriInSessione(_ value: Errori)

    @objc(addErroriInSessione:)
    @NSManaged public func addToErroriInSessione(_ values: NSSet)

    @objc(removeErroriInSessione:)
    @NSManaged public func removeFromErroriInSessione(_ values: NSSet)

}

// MARK: Generated accessors for tentativiInSessione
extension Accessi {

    @objc(addTentativiInSessioneObject:)
    @NSManaged public func addToTentativiInSessione(_ value: Tentativi)

    @objc(removeTentativiInSessioneObject:)
    @NSManaged public func removeFromTentativiInSessione(_ value: Tentativi)

    @objc(addTentativiInSessione:)
    @NSManaged public func addToTentativiInSessione(_ values: NSSet)

    @objc(removeTentativiInSessione:)
    @NSManaged public func removeFromTentativiInSessione(_ values: NSSet)

}

extension Accessi : Identifiable {

}
