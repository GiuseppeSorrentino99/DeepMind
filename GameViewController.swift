//
//  GameViewController.swift
//  DeepMind
//
//  Created by Giuseppe Sorrentino on 10/04/21.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var accesso : Accessi?
    var start: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            
            if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
            
                // Present the scene
                scene.viewController = self
                if UserDefaults.standard.bool(forKey: "Liv_Audio") {
                    scene.run(menuSelectionSound)
                }
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = false
            view.showsNodeCount = false
            
        }
        
        accesso = PersistenceManager.registraAccesso()
        start = Date()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       
        
       //Per fare contento Giuseppe, dopo averlo fatto vomitare 2 volte:
       //Per lock semplice
        if UIDevice.current.orientation.isLandscape {
            AppUtility.lockOrientation(.landscape)
        }
       // Or to rotate and lock
        else {
        AppUtility.lockOrientation(.landscape, andRotateTo: .landscapeRight)
        }
       
   }
    
   override func viewDidDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
    let end = Date()
    let durata = String(end.timeIntervalSince(start!))
    PersistenceManager.registraTempoSessione(diAccesso: accesso!, conTempo: durata)
       // Don't forget to reset when view is being removed
    AppUtility.lockOrientation(.all)
   }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
}
    
