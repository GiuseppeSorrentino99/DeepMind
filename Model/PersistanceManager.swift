//
//  PersistanceManager.swift
//  DeepMind
//
//  Created by Simone Salzano on 13/04/21.
//

import Foundation
import UIKit
import CoreData

class PersistenceManager {
    
    static func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    static func getDate() -> Date {
        let data = Date()
        
        return data
    }
    
    static func saveContext(){
        let context = getContext()
        do {
            try context.save()
        } catch let error as NSError {
            print("Saving error: \(error)")
        }
    }
    
    
    
    //    MARK: Gestione Entita' Accessi
    
    
    
    static func registraAccesso() -> Accessi {
        
        let context = getContext()
        
        
        
        let accesso = Accessi(context: context)
        
        
        
        accesso.data = getDate()
        
        accesso.tempoSessione = String(0)
        
        saveContext()
        
        
        
        return accesso
        
    }
    
    
    
    static func registraTempoSessione(diAccesso a: Accessi,conTempo t: String){
        
        a.tempoSessione = t
        
        saveContext()
        
    }
    
    
    
    
    
    
    
    static func fetchAccessi() -> [Accessi] {
        
        let context = getContext()
        
        
        
        var accessi = [Accessi]()
        
        
        
        let fetchRequest = NSFetchRequest<Accessi>(entityName: "Accessi")
        
        do {
            
            try accessi = context.fetch(fetchRequest)
            
        }
        
        catch let error as NSError {
            
            print("Errore nella fetch di Accessi. Errore: \(error)")
            
        }
        
        
        
        return accessi
        
    }
    
    
    
    static func fetchAccessi(inGiorno d: Date) -> [Accessi] {
        
        let context = getContext()
        
        
        
        var accessi = [Accessi]()
        
        let calendar = NSCalendar.current
        
        let startDate = calendar.startOfDay(for: d)
        
        let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)
        
        
        
        let fetchRequest = NSFetchRequest<Accessi>(entityName: "Accessi")
        
        let predicate = NSPredicate(format: "(data >= %@) AND (data < %@)", startDate as! NSDate, endDate as! NSDate )
        
        fetchRequest.predicate = predicate
        
        do {
            
            try accessi = context.fetch(fetchRequest)
            
        }
        
        catch let error as NSError {
            
            print("Errore nella fetch di Accessi. Errore: \(error)")
            
        }
        
        return accessi
        
    }
    
    
    
    static func fetchAccessi(inMese m: Date) -> [Accessi] {
        
        let context = getContext()
        
        
        
        var accessi = [Accessi]()
        
        let calendar = NSCalendar.current
        
        var components = calendar.dateComponents([.year, .month], from: m)
        
        components.day=1
        
        let firstDayOfMonth = calendar.date(from: components)
        
        let startDate = calendar.startOfDay(for: firstDayOfMonth!)
        
        let endDate = calendar.date(byAdding: .month, value: 1, to: startDate)
        
        let fetchRequest = NSFetchRequest<Accessi>(entityName: "Accessi")
        
        let predicate = NSPredicate(format: "(data >= %@) AND (data < %@)", startDate as! NSDate, endDate as! NSDate)
        
        fetchRequest.predicate = predicate
        
        do {
            
            try accessi = context.fetch(fetchRequest)
            
        }
        
        catch let error as NSError {
            
            print("Errore nella fetch di Accessi. Errore: \(error)")
            
        }
        
        return accessi
        
        
        
    }
    
    
    
    static func fetchAccessi(inizio: Date, fine: Date) -> [Accessi] {
        
        let context = getContext()
        
        
        
        var accessi = [Accessi]()
        
        let calendar = NSCalendar.current
        
        let startDate = calendar.startOfDay(for: inizio)
        
        let endDate = calendar.startOfDay(for:calendar.date(byAdding: .day, value: 1, to: fine)!)
        
        
        
        let fetchRequest = NSFetchRequest<Accessi>(entityName: "Accessi")
        
        let predicate = NSPredicate(format: "(data >= %@) AND (data < %@)", startDate as! NSDate, endDate as! NSDate)
        
        fetchRequest.predicate = predicate
        
        do {
            
            try accessi = context.fetch(fetchRequest)
            
        }
        
        catch let error as NSError {
            
            print("Errore nella fetch di Accessi. Errore: \(error)")
            
        }
        
        
        
        return accessi
        
        
        
    }
    
    
    
    static func fetchAccessiInSettimana() -> [Accessi] {
        
        let calendar = NSCalendar.current
        
        let oggi = Date()
        
        return fetchAccessi(inizio: calendar.date(byAdding: .day,value: -7, to: oggi)!, fine: oggi)
        
    }
    
    
    
    static func fetchAccessiInMese() -> [Accessi] {
        
        let calendar = NSCalendar.current
        
        let oggi = Date()
        
        return fetchAccessi(inizio: calendar.date(byAdding: .month,value: -1, to: oggi)!, fine: oggi)
        
    }
    
    
    
    static func fetchAccessiIn2Mesi() -> [Accessi] {
        
        let calendar = NSCalendar.current
        
        let oggi = Date()
        
        return fetchAccessi(inizio: calendar.date(byAdding: .month,value: -2, to: oggi)!, fine: oggi)
        
    }
    
    
    
    //    MARK: Gestione Entita' Tentativi
    
    
    
    static func inserisciTentativo(livello: Int64, tempoTentativo: String, successo: Bool, accesso: Accessi) -> Tentativi {
        
        let context = getContext()
        
        
        
        let tentativo = Tentativi(context: context)
        
        
        
        tentativo.livello = livello
        
        accesso.addToTentativiInSessione(tentativo)
        
        tentativo.successo = successo
        
        tentativo.tempoTentativo = tempoTentativo
        
        
        
        saveContext()
        
        
        
        return tentativo
        
    }
    
    
    
    static func fetchTentativi() -> [Tentativi] {
        
        let context = getContext()
        
        
        
        var tentativi = [Tentativi]()
        
        
        
        let fetchRequest = NSFetchRequest<Tentativi>(entityName: "Tentativi")
        
        do {
            
            try tentativi = context.fetch(fetchRequest)
            
        }
        
        catch let error as NSError {
            
            print("Errore nella fetch di Tentativi. Errore: \(error)")
            
        }
        
        
        
        return tentativi
        
    }
    
    
    
    static func fetchSuccessi() -> [Tentativi] {
        
        let context = getContext()
        
        
        
        var tentativi = [Tentativi]()
        
        
        
        let request = Tentativi.fetchRequest() as NSFetchRequest<Tentativi>
        
        let predicate = NSPredicate(format: "successo == YES")
        
        request.predicate = predicate
        
        
        
        do {
            
            try tentativi = context.fetch(request)
            
        }
        
        catch let error as NSError {
            
            print("Errore nella fetch di Successi. Errore: \(error)")
            
        }
        
        
        
        return tentativi
        
    }
    
    
    
    static func fetchTentativiInSettimana() -> [Tentativi] {
        let context = getContext()
        var tentativi = [Tentativi]()
        
        for accesso in fetchAccessiInSettimana() {
            let request = Tentativi.fetchRequest() as NSFetchRequest<Tentativi>
            let predicate = NSPredicate(format: "sessione == %@", accesso)
            request.predicate = predicate
             do {
                try tentativi += context.fetch(request)
            }
            catch let error as NSError {
                print("Errore nella fetch di Tentativi. Errore: \(error)")
            }
        }
        return tentativi
    }
    
    
    
    static func fetchTentativiInMese() -> [Tentativi] {
        let context = getContext()
        var tentativi = [Tentativi]()
        
        for accesso in fetchAccessiInMese() {
            let request = Tentativi.fetchRequest() as NSFetchRequest<Tentativi>
            let predicate = NSPredicate(format: "sessione == %@", accesso)
            request.predicate = predicate
             do {
                try tentativi += context.fetch(request)
            }
            catch let error as NSError {
                print("Errore nella fetch di Tentativi. Errore: \(error)")
            }
        }
        return tentativi
    }
    
    
    
    static func fetchTentativiIn2Mesi() -> [Tentativi] {
        let context = getContext()
        var tentativi = [Tentativi]()
        
        for accesso in fetchAccessiIn2Mesi() {
            let request = Tentativi.fetchRequest() as NSFetchRequest<Tentativi>
            let predicate = NSPredicate(format: "sessione == %@", accesso)
            request.predicate = predicate
             do {
                try tentativi += context.fetch(request)
            }
            catch let error as NSError {
                print("Errore nella fetch di Tentativi. Errore: \(error)")
            }
        }
        return tentativi
    }
    
    
    
    static func fetchNumeroSuccessiInSettimana() -> Int{
        
        var numeroSuccessi = 0
        
        for accesso in fetchAccessiInSettimana() {
            
            let successi = accesso.tentativiInSessione?.allObjects.filter({
                                                                            
                                                                            ($0 as! Tentativi).successo == true})
            
            numeroSuccessi += successi?.count ?? 0
            
        }
        
        return numeroSuccessi
        
    }
    
    
    
    static func fetchNumeroSuccessiInMese() -> Int{
        
        var numeroSuccessi = 0
        
        for accesso in fetchAccessiInMese() {
            
            let successi = accesso.tentativiInSessione?.allObjects.filter({
                                                                            
                                                                            ($0 as! Tentativi).successo == true})
            
            numeroSuccessi += successi?.count ?? 0
            
        }
        
        return numeroSuccessi
        
    }
    
    
    
    static func fetchNumeroSuccessiIn2Mesi() -> Int {
        
        var numeroSuccessi = 0
        
        for accesso in fetchAccessiIn2Mesi() {
            
            let successi = accesso.tentativiInSessione?.allObjects.filter({
                                                                            
                                                                            ($0 as! Tentativi).successo == true})
            
            numeroSuccessi += successi?.count ?? 0
            
        }
        
        return numeroSuccessi
        
    }
    
    //    MARK: Gestione Entita' Errori
    
    
    
    
    
    
    
    static func inserisciErrore(codice: Int64, livello: Int64, accesso: Accessi) -> Errori {
        
        
        
        let context = getContext()
        
        
        
        
        
        
        
        let errore = Errori(context: context)
        
        
        
        
        
        
        
        errore.codice = codice
        
        
        
        errore.livello = livello
        
        
        
        accesso.addToErroriInSessione(errore)
        
        
        
        
        
        
        
        saveContext()
        
        
        
        
        
        
        
        return errore
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    static func fetchErrori() -> [Errori] {
        
        
        
        let context = getContext()
        
        
        
        
        
        
        
        var errori = [Errori]()
        
        
        
        
        
        
        
        let fetchRequest = NSFetchRequest<Errori>(entityName: "Errori")
        
        
        
        do {
            
            
            
            try errori = context.fetch(fetchRequest)
            
            
            
        }
        
        
        
        catch let error as NSError {
            
            
            
            print("Errore nella fetch di Errori. Ironico. Errore: \(error)")
            
            
            
        }
        
        
        
        
        
        
        
        return errori
        
        
        
    }
    
    
    
    
    
    
    
    static func fetchErrori(conCodice code: Int) -> [Errori] {
        
        
        
        let context = getContext()
        
        
        
        
        
        
        
        var errori = [Errori]()
        
        
        
        
        
        
        
        let request = NSFetchRequest<Errori>(entityName: "Errori")
        
        
        
        let predicate = NSPredicate(format: "codice == %i", code)
        
        
        
        request.predicate = predicate
        
        
        
        
        
        
        
        do {
            
            
            
            try errori = context.fetch(request)
            
            
            
        }
        
        
        
        catch let error as NSError {
            
            
            
            print("Errore nella fetch di Errori. Ironico. Errore: \(error)")
            
            
            
        }
        
        
        
        
        
        
        
        return errori
        
        
        
    }
    
    
    
    
    
    
    
    static func fetchErrori(conLivello l: Int) -> [Errori] {
        
        
        
        let context = getContext()
        
        
        
        
        
        
        
        var errori = [Errori]()
        
        
        
        
        
        
        
        let request = Errori.fetchRequest() as NSFetchRequest<Errori>
        
        
        
        let predicate = NSPredicate(format: "livello == %i", l)
        
        
        
        request.predicate = predicate
        
        
        
        
        
        
        
        do {
            
            
            
            try errori = context.fetch(request)
            
            
            
        }
        
        
        
        catch let error as NSError {
            
            
            
            print("Errore nella fetch di Errori. Ironico. Errore: \(error)")
            
            
            
        }
        
        
        
        
        
        
        
        return errori
        
        
        
    }
    
    
    
    
    
    
    
    static func fetchErrori(conLivello l: Int,conCodice code: Int) -> [Errori] {
        
        
        
        let context = getContext()
        
        
        
        
        
        
        
        var errori = [Errori]()
        
        
        
        
        
        
        
        let request = Errori.fetchRequest() as NSFetchRequest<Errori>
        
        
        
        let predicate = NSPredicate(format: "(livello == %i) AND (codice == %i)", l, code)
        
        
        
        request.predicate = predicate
        
        
        
        
        
        
        
        do {
            
            
            
            try errori = context.fetch(request)
            
            
            
        }
        
        
        
        catch let error as NSError {
            
            
            
            print("Errore nella fetch di Errori. Ironico. Errore: \(error)")
            
            
            
        }
        
        
        
        
        
        
        
        return errori
        
        
        
    }
    
    
    
    
    
    
    
    static func fetchErroriInSettimana(codice: Int = -1, livello: Int = -1) -> [Errori] {
        
        let context = getContext()
        var errori = [Errori]()
        let accessi = fetchAccessiInSettimana()
        let request = Errori.fetchRequest() as NSFetchRequest<Errori>
        
        for accesso in accessi {
            let predicateAll = NSPredicate(format: "(sessione == %@)", accesso)
            let predicateCode = NSPredicate(format: "(sessione == %@ AND codice == %i)", accesso, codice)
            let predicateLevel = NSPredicate(format: "(sessione == %@ AND livello == %i)", accesso, livello)
            let predicateCodeAndLevel = NSPredicate(format: "(sessione == %@ AND codice == %i AND livello == %i)", accesso, codice, livello)
            if codice != -1 || livello != -1{
                if codice != -1 && livello != -1 {
                    request.predicate = predicateCodeAndLevel
                } else {
                    if codice == -1 {
                        request.predicate = predicateLevel
                    } else {
                        request.predicate = predicateCode
                    }
                }
            } else {
                request.predicate = predicateAll
            }
            do {
                try errori += context.fetch(request)
           }
           catch let error as NSError {
               print("Errore nella fetch di Errori. Ironico. Errore: \(error)")
              }
        }
        
        return errori
    }
    
    
    
    
    
    
    
    static func fetchErroriInMese(codice: Int = -1, livello: Int = -1) -> [Errori] {
        
        let context = getContext()
        var errori = [Errori]()
        let accessi = fetchAccessiInMese()
        let request = Errori.fetchRequest() as NSFetchRequest<Errori>
        
        for accesso in accessi {
            let predicateAll = NSPredicate(format: "(sessione == %@)", accesso)
            let predicateCode = NSPredicate(format: "(sessione == %@ AND codice == %i)", accesso, codice)
            let predicateLevel = NSPredicate(format: "(sessione == %@ AND livello == %i)", accesso, livello)
            let predicateCodeAndLevel = NSPredicate(format: "(sessione == %@ AND codice == %i AND livello == %i)", accesso, codice, livello)
            if codice != -1 || livello != -1{
                if codice != -1 && livello != -1 {
                    request.predicate = predicateCodeAndLevel
                } else {
                    if codice == -1 {
                        request.predicate = predicateLevel
                    } else {
                        request.predicate = predicateCode
                    }
                }
            } else {
                request.predicate = predicateAll
            }
            do {
                try errori += context.fetch(request)
           }
           catch let error as NSError {
               print("Errore nella fetch di Errori. Ironico. Errore: \(error)")
              }
        }
        
        return errori
    }
    
    
    
    static func fetchErroriIn2Mesi(codice: Int = -1, livello: Int = -1) -> [Errori] {
        
        let context = getContext()
        var errori = [Errori]()
        let accessi = fetchAccessiIn2Mesi()
        let request = Errori.fetchRequest() as NSFetchRequest<Errori>
        
        for accesso in accessi {
            let predicateAll = NSPredicate(format: "(sessione == %@)", accesso)
            let predicateCode = NSPredicate(format: "(sessione == %@ AND codice == %i)", accesso, codice)
            let predicateLevel = NSPredicate(format: "(sessione == %@ AND livello == %i)", accesso, livello)
            let predicateCodeAndLevel = NSPredicate(format: "(sessione == %@ AND codice == %i AND livello == %i)", accesso, codice, livello)
            if codice != -1 || livello != -1{
                if codice != -1 && livello != -1 {
                    request.predicate = predicateCodeAndLevel
                } else {
                    if codice == -1 {
                        request.predicate = predicateLevel
                    } else {
                        request.predicate = predicateCode
                    }
                }
            } else {
                request.predicate = predicateAll
            }
            do {
                try errori += context.fetch(request)
           }
           catch let error as NSError {
               print("Errore nella fetch di Errori. Ironico. Errore: \(error)")
              }
        }
        
        return errori
    }
}


