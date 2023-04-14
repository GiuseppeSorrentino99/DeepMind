//
//  Errori+CoreDataProperties.swift
//  DeepMind
//
//  Created by Simone Salzano on 29/04/21.
//
//

import Foundation
import CoreData


extension Errori {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Errori> {
        return NSFetchRequest<Errori>(entityName: "Errori")
    }

    @NSManaged public var codice: Int64
    @NSManaged public var livello: Int64
    @NSManaged public var sessione: Accessi?

}

extension Errori : Identifiable {

}
