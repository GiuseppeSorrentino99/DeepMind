//
//  Tentativi+CoreDataProperties.swift
//  DeepMind
//
//  Created by Simone Salzano on 29/04/21.
//
//

import Foundation
import CoreData


extension Tentativi {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tentativi> {
        return NSFetchRequest<Tentativi>(entityName: "Tentativi")
    }

    @NSManaged public var livello: Int64
    @NSManaged public var successo: Bool
    @NSManaged public var tempoTentativo: String?
    @NSManaged public var sessione: Accessi?

}

extension Tentativi : Identifiable {

}
