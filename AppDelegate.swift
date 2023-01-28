//
//  AppDelegate.swift
//  DeepMind
//
//  Created by Giuseppe Sorrentino on 10/04/21.
//

import UIKit
import CoreData
import BackgroundTasks
import MailCore
import MessageUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate, MFMailComposeViewControllerDelegate {

    var window: UIWindow?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let calendar = Calendar.current
        if !UserDefaults.standard.bool(forKey: "App_Init") {
            UserDefaults.standard.setValue(true, forKey: "Liv_Audio")
            UserDefaults.standard.setValue(true, forKey: "App_Init")
        }
        // Replace the hour (time) of both dates with 00:00let date1 = calendar.startOfDay(for: firstDate)
        if UserDefaults.standard.bool(forKey: "Report_InviaReport") {

            if let lastReport = UserDefaults.standard.object(forKey: "Report_LastReport") as? Date {
                switch UserDefaults.standard.integer(forKey: "Report_Freq") {
                case 0:
                    let components = calendar.dateComponents([.day], from: lastReport, to: Date())
                    print("GIORNI PER MAIL: ", components.day!)
                    if components.day! >= 7 {
                        emailWithGoogle()
                        UserDefaults.standard.set(Date(), forKey: "Report_LastReport")
                    }
                case 1:
                    let components = calendar.dateComponents([.month], from: lastReport, to: Date())
                    if components.month! >= 1 {
                        emailWithGoogle()
                        UserDefaults.standard.set(Date(), forKey: "Report_LastReport")
                    }
                case 2:
                    let components = calendar.dateComponents([.month], from: lastReport, to: Date())
                    if components.month! >= 2 {
                        emailWithGoogle()
                        UserDefaults.standard.set(Date(), forKey: "Report_LastReport")
                    }
                default:
                    break
                }
            } else {
                emailWithGoogle()
                UserDefaults.standard.set(Date(), forKey: "Report_LastReport")
            }
        }
        
        BGTaskScheduler.shared.register(
                    forTaskWithIdentifier: "it.Unisa.appleFoundationProgram.DeepMind.apprefresh",
                    using: nil
                ) { task in
                    self.handleAppRefresh(task as! BGAppRefreshTask)
                }
        return true
    }
    

    /// set orientations you want to be allowed in this property by default
    var orientationLock = UIInterfaceOrientationMask.all

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
            return self.orientationLock
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        scheduleAppRefresh()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }


    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "DeepMind")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    //MARK: OPERAZIONI IN BACKGROUND
    
    
    
    private func handleAppRefresh(_ task: BGAppRefreshTask) {
        
        scheduleAppRefresh()
        let queue = OperationQueue()
            queue.maxConcurrentOperationCount = 1
            print("mando la mail")
        let appRefreshOperation = emailWithGoogle
            queue.addOperation(appRefreshOperation)

            task.expirationHandler = {
                queue.cancelAllOperations()
            }

            let lastOperation = queue.operations.last
            lastOperation?.completionBlock = {
                task.setTaskCompleted(success: !(lastOperation?.isCancelled ?? false))
            }

        }
    
    private func scheduleAppRefresh() {
            do {
                let request = BGAppRefreshTaskRequest(identifier: "it.Unisa.appleFoundationProgram.DeepMind.apprefresh")
                request.earliestBeginDate = Date(timeIntervalSinceNow: 120)
                try BGTaskScheduler.shared.submit(request)
            } catch {
                print(error)
            }
        }
    
    var count = 0
    var defaults = UserDefaults.standard
    func emailWithGoogle() {
        print(defaults.string(forKey: "Utente_Email"))
        if defaults.string(forKey: "Utente_Email") == nil {
            return
        }
        var smtpSession = MCOSMTPSession()
        smtpSession.hostname = "smtp.gmail.com"
        smtpSession.username = "tirociniodeepmind@gmail.com"
        smtpSession.password = "deepmind01"
        smtpSession.port = 465
        smtpSession.authType = MCOAuthType.saslPlain
        smtpSession.connectionType = MCOConnectionType.TLS
        //        smtpSession.connectionLogger = {(connectionID, type, data) in
        //            if data != nil {
        //                if let string = NSString(data: data, encoding: NSUTF8StringEncoding){
        //                    NSLog("Connectionlogger: \(string)")
        //                }
        //            }
        //        }
        count = defaults.integer(forKey: "Report_Count")
        
        var builder = MCOMessageBuilder()
        builder.header.to = [MCOAddress(displayName: "Utente Deep Mind", mailbox:   defaults.string(forKey: "Utente_Email")! )]
        builder.header.from = MCOAddress(displayName: "App Deep Mind", mailbox: "tirocinio@deepmind.com")
        builder.header.subject = "Report di riepilogo #" + String(count + 1)
        builder.htmlBody = createEmail()
        let a = MCOAttachment(data: UserDefaults.standard.object(forKey: "Utente_Foto")  as? Data, filename: "FotoUtente")
        a?.contentID = "123456"
        builder.addRelatedAttachment(a)
        defaults.setValue(count + 1, forKey: "Report_Count")
        
        let rfc822Data = builder.data()
        let sendOperation = smtpSession.sendOperation(with: rfc822Data)
        sendOperation?.start { (error) -> Void in
            if (error != nil) {
                print("Errore nell'invio della mail")
                print(error.debugDescription)
                //                NSLog("Error sending email: \(error)")
            } else {
                //                NSLog("Successfully sent email!")
                print("Mail inviata")
            }
        }
    }
    
    
}

