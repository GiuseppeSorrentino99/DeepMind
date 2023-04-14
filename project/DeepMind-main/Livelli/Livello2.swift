//
//  Livello2.swift
//  DeepMind
//
//  Created by Simone Salzano on 27/04/21.
//

import UIKit
import SpriteKit

class Livello2: SKScene {
    var alreadySelected = false
    private var label : SKLabelNode?
    weak var viewController: GameViewController?
    private var audio : SKSpriteNode?
    private var chiudiLivello2 : SKSpriteNode?
    private var check : SKSpriteNode?
    private var startTime : Date?
    private var oggetti : [String]?
    private var oggettiSelezionati : [String] = []
    private var cestino : SKSpriteNode?
    private var tutorialButton : SKSpriteNode?
    private var piatto : SKSpriteNode?
    private var node1 : SKSpriteNode?
    private var node2 : SKSpriteNode?
    private var node3 : SKSpriteNode?
    private var node4 : SKSpriteNode?
    private var node5 : SKSpriteNode?
    private var node6 : SKSpriteNode?
    private var node7 : SKSpriteNode?
    private var node8 : SKSpriteNode?
    private var node9 : SKSpriteNode?
    private var node10 : SKSpriteNode?
    private var node11 : SKSpriteNode?
    private var node12 : SKSpriteNode?
    private var piatto1 : SKLabelNode?
    private var piatto2 : SKLabelNode?
    private var cestino1 : SKLabelNode?
    private var cestino2 : SKLabelNode?
    private var cestino3 : SKLabelNode?
    private var initialSize : CGSize?
    private var initialPosition : CGPoint?
    private var tipoPiatto : String!
    private var nessunErrore = true
    private var soloErroriLievi = true
    private var tut_sfondo : SKSpriteNode?
    private var tut_lab1 : SKLabelNode?
    private var tut_lab2 : SKLabelNode?
    private var tut_lab3 : SKLabelNode?
    private var tut_lab4 : SKLabelNode?
    private var tut_lab5 : SKLabelNode?
    private var tut_lab6 : SKLabelNode?
    private var tutorial = false
    var tut_counter = 0 {
        didSet {
            switch(tut_counter) {
            case 1:
                piatto?.zPosition = 1
                piatto1?.zPosition = 1
                piatto2?.zPosition = 1
                cestino?.zPosition = CGFloat(4)
                cestino1?.zPosition = CGFloat(4)
                cestino2?.zPosition = CGFloat(4)
                cestino3?.zPosition = CGFloat(4)
                node1?.zPosition = CGFloat(4)
                node2?.zPosition = CGFloat(4)
                node3?.zPosition = CGFloat(4)
                node4?.zPosition = CGFloat(4)
                node5?.zPosition = CGFloat(4)
                node6?.zPosition = CGFloat(4)
                node7?.zPosition = CGFloat(4)
                node8?.zPosition = CGFloat(4)
                node9?.zPosition = CGFloat(4)
                node10?.zPosition = CGFloat(4)
                node11?.zPosition = CGFloat(4)
                node12?.zPosition = CGFloat(4)
                
                
            case 2:
                cestino?.zPosition = CGFloat(1)
                cestino1?.zPosition = CGFloat(1)
                cestino2?.zPosition = CGFloat(1)
                cestino3?.zPosition = CGFloat(1)
                node1?.zPosition = CGFloat(2)
                node2?.zPosition = CGFloat(2)
                node3?.zPosition = CGFloat(2)
                node4?.zPosition = CGFloat(2)
                node5?.zPosition = CGFloat(2)
                node6?.zPosition = CGFloat(2)
                node7?.zPosition = CGFloat(2)
                node8?.zPosition = CGFloat(2)
                node9?.zPosition = CGFloat(2)
                node10?.zPosition = CGFloat(2)
                node11?.zPosition = CGFloat(2)
                node12?.zPosition = CGFloat(2)
                tut_lab1?.isHidden = false
                tut_lab2?.isHidden = false
                tut_lab1?.zPosition = CGFloat(5)
                tut_lab2?.zPosition = CGFloat(5)
                audio?.zPosition = CGFloat(5)
            case 3:
                tut_lab1?.isHidden = true
                tut_lab2?.isHidden = true
                tut_lab1?.zPosition = 1
                tut_lab2?.zPosition = 1
                audio?.zPosition = 1
                tut_lab3?.isHidden = false
                tut_lab4?.isHidden = false
                tut_lab5?.isHidden = false
                tut_lab3?.zPosition = CGFloat(5)
                tut_lab4?.zPosition = CGFloat(5)
                tut_lab5?.zPosition = CGFloat(5)
                chiudiLivello2?.zPosition = CGFloat(5)
            case 4:
                tut_lab3?.isHidden = true
                tut_lab4?.isHidden = true
                tut_lab5?.isHidden = true
                tut_lab3?.zPosition = CGFloat(1)
                tut_lab4?.zPosition = CGFloat(1)
                tut_lab5?.zPosition = CGFloat(1)
                chiudiLivello2?.zPosition = CGFloat(1)
                tut_lab6?.isHidden = false
                tut_lab6?.zPosition = CGFloat(5)
                check?.zPosition = CGFloat(5)
            case 5:
                tut_sfondo?.isHidden = true
                tut_lab6?.isHidden = true
                tut_lab6?.zPosition = CGFloat(1)
                check?.zPosition = CGFloat(1)
                tutorial = false
                UserDefaults.standard.setValue(true, forKey: "Liv2_TutorialFinito")
            default:
                break
            }
        }
    }
    
    
    override func didMove(to view: SKView) {
        scene?.scaleMode = .resizeFill
        tipoPiatto = tipiLivello2[Int.random(in: 1..<5)]
        oggetti = initializeElementsRandomly(numberOfElements: 12, livello: 2, option: tipoPiatto!)
        self.cestino = self.childNode(withName: "//cestino") as? SKSpriteNode
        self.piatto = self.childNode(withName: "//piatto") as? SKSpriteNode
        self.node1 = self.childNode(withName: "//node1") as? SKSpriteNode
        self.node2 = self.childNode(withName: "//node2") as? SKSpriteNode
        self.node3 = self.childNode(withName: "//node3") as? SKSpriteNode
        self.node4 = self.childNode(withName: "//node4") as? SKSpriteNode
        self.node5 = self.childNode(withName: "//node5") as? SKSpriteNode
        self.node6 = self.childNode(withName: "//node6") as? SKSpriteNode
        self.node7 = self.childNode(withName: "//node7") as? SKSpriteNode
        self.node8 = self.childNode(withName: "//node8") as? SKSpriteNode
        self.node9 = self.childNode(withName: "//node9") as? SKSpriteNode
        self.node10 = self.childNode(withName: "//node10") as? SKSpriteNode
        self.node11 = self.childNode(withName: "//node11") as? SKSpriteNode
        self.node12 = self.childNode(withName: "//node12") as? SKSpriteNode
        self.piatto = self.childNode(withName: "//piatto") as? SKSpriteNode
        self.piatto1 = self.childNode(withName: "//piatto1") as? SKLabelNode
        self.piatto2 = self.childNode(withName: "//piatto2") as? SKLabelNode
        self.cestino = self.childNode(withName: "//cestino") as? SKSpriteNode
        self.cestino1 = self.childNode(withName: "//cestino1") as? SKLabelNode
        self.cestino2 = self.childNode(withName: "//cestino2") as? SKLabelNode
        self.cestino3 = self.childNode(withName: "//cestino3") as? SKLabelNode
        self.audio = self.childNode(withName: "//audio") as? SKSpriteNode
        self.chiudiLivello2 = self.childNode(withName: "//chiudiLivello2") as? SKSpriteNode
        self.check = self.childNode(withName: "//check") as? SKSpriteNode
        self.tut_sfondo = self.childNode(withName: "//tut_sfondo") as? SKSpriteNode
        self.tut_lab1 = self.childNode(withName: "//tut_lab1") as? SKLabelNode
        self.tut_lab2 = self.childNode(withName: "//tut_lab2") as? SKLabelNode
        self.tut_lab3 = self.childNode(withName: "//tut_lab3") as? SKLabelNode
        self.tut_lab4 = self.childNode(withName: "//tut_lab4") as? SKLabelNode
        self.tut_lab5 = self.childNode(withName: "//tut_lab5") as? SKLabelNode
        self.tut_lab6 = self.childNode(withName: "//tut_lab6") as? SKLabelNode
        self.tutorialButton = self.childNode(withName: "//tutorial") as? SKSpriteNode
        initialSize = node1?.size
        //modifichiamo le texture dei nodi presenti nella scena
        self.node1?.texture = SKTexture(imageNamed: oggetti![0])
        self.node1?.aspectFillToSize(fillSize: initialSize!)
        self.node2?.texture = SKTexture(imageNamed: oggetti![1])
        self.node2?.aspectFillToSize(fillSize: initialSize!)
        self.node3?.texture = SKTexture(imageNamed: oggetti![2])
        self.node3?.aspectFillToSize(fillSize: initialSize!)
        self.node4?.texture = SKTexture(imageNamed: oggetti![3])
        self.node4?.aspectFillToSize(fillSize: initialSize!)
        self.node5?.texture = SKTexture(imageNamed: oggetti![4])
        self.node5?.aspectFillToSize(fillSize: initialSize!)
        self.node6?.texture = SKTexture(imageNamed: oggetti![5])
        self.node6?.aspectFillToSize(fillSize: initialSize!)
        self.node7?.texture = SKTexture(imageNamed: oggetti![6])
        self.node7?.aspectFillToSize(fillSize: initialSize!)
        self.node8?.texture = SKTexture(imageNamed: oggetti![7])
        self.node8?.aspectFillToSize(fillSize: initialSize!)
        self.node9?.texture = SKTexture(imageNamed: oggetti![8])
        self.node9?.aspectFillToSize(fillSize: initialSize!)
        self.node10?.texture = SKTexture(imageNamed: oggetti![9])
        self.node10?.aspectFillToSize(fillSize: initialSize!)
        self.node11?.texture = SKTexture(imageNamed: oggetti![10])
        self.node11?.aspectFillToSize(fillSize: initialSize!)
        self.node12?.texture = SKTexture(imageNamed: oggetti![11])
        self.node12?.aspectFillToSize(fillSize: initialSize!)
        if UserDefaults.standard.bool(forKey: "Liv_Audio") {
            audio?.texture = SKTexture(imageNamed: "AudioOn")
        } else {
            audio?.texture = SKTexture(imageNamed: "AudioOff")
        }
        audio?.size = CGSize(width: 125.734, height: 135.337)
        startTime = Date()
        piatto?.texture = SKTexture(imageNamed: tipoPiatto!)
        if !UserDefaults.standard.bool(forKey: "Liv2_TutorialFinito") {
            tut_sfondo?.isHidden = false
            piatto?.zPosition = CGFloat(4)
            piatto1?.zPosition = CGFloat(4)
            piatto2?.zPosition = CGFloat(4)
            
            tutorial = true
            
        } else {
            tut_sfondo?.isHidden = true
            tut_lab6?.isHidden = true
            tut_lab6?.zPosition = CGFloat(1)
            check?.zPosition = CGFloat(1)
        }
    }
    
    var movableNode : SKNode?

    

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, movableNode != nil {
            movableNode!.position = touch.location(in: self)
        }
    }
    
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !tutorial {
        if let touch = touches.first, movableNode != nil {
            movableNode!.position = touch.location(in: self)
            //controlla se il nodo e' stato inserito nel cestino
            if cestino!.frame.contains(movableNode!.position) {
                //controlla se il nodo e' tra quelli giusti
                let nodo = movableNode!.name!
                let selezione : String
                
                switch nodo {
                case "node1":
                    selezione = oggetti![0]
                case "node2":
                    selezione = oggetti![1]
                case "node3":
                    selezione = oggetti![2]
                case "node4":
                    selezione = oggetti![3]
                case "node5":
                    selezione = oggetti![4]
                case "node6":
                    selezione = oggetti![5]
                case "node7":
                    selezione = oggetti![6]
                case "node8":
                    selezione = oggetti![7]
                case "node9":
                    selezione = oggetti![8]
                case "node10":
                    selezione = oggetti![9]
                case "node11":
                    selezione = oggetti![10]
                case "node12":
                    selezione = oggetti![11]
                default:
                    selezione = "none"
                }
                
                
                if oggettiGiustiInLivello2[tipoPiatto]!.contains(selezione)  {
                    alreadySelected = true
                    if !oggettiSelezionati.contains(selezione){
                        alreadySelected = false
                        oggettiSelezionati.append(selezione)
                    }
                    //controlla la WinCondition
                    if self.oggettiSelezionati.count == oggettiGiustiInLivello2[tipoPiatto]!.count {
                        if (UserDefaults.standard.bool(forKey: "Liv_Audio")) {
                        self.run(winSound)
                        }
                        let alert = UIAlertController(title: "Congratulazioni!", message: "Hai fatto la spesa! \n \n \n \n \n", preferredStyle: .alert)
                        customizeSelectionAlert(alert: alert)
                        let okAction = UIAlertAction(title: "Ok", style: .default, handler: {
                            _ in
                            let endTime = Date()
                            let durata = endTime.timeIntervalSince(self.startTime!)
                            PersistenceManager.inserisciTentativo(livello: 2, tempoTentativo: String(durata), successo: true, accesso:  self.viewController!.accesso!)
                            let tempoSessioneAggiunto = durata + Double(self.viewController!.accesso!.tempoSessione ?? "0.0")!
                            PersistenceManager.registraTempoSessione(diAccesso: self.viewController!.accesso!, conTempo: String(tempoSessioneAggiunto))
                            if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
                                // Set the scale mode to scale to fit the window
                                scene.scaleMode = .aspectFill
                                
                                // Present the scene
                                scene.viewController = self.viewController
                                self.view?.presentScene(scene)
                            }
                        })
                        okAction.setValue(UIColor(#colorLiteral(red: 0.7149195075, green: 0, blue: 0, alpha: 1)), forKey: "titleTextColor")
                        alert.addAction(okAction)
                        let imageView = UIImageView(frame: CGRect(x: 10, y: 50, width: 250, height: 88))
                        var nomeImmagine = ""
                        if self.nessunErrore {
                            nomeImmagine = "Star3"
                        }
                        else if self.soloErroriLievi {
                            nomeImmagine = "Star2"
                        }
                        else {
                            nomeImmagine = "Star1"
                        }
                        imageView.image = UIImage(named: nomeImmagine)
                        alert.view.addSubview(imageView)
                        imageView.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 200).isActive = true
                        imageView.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor, constant: 50).isActive = true
                        let height = NSLayoutConstraint(item: alert.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200)
                        let width = NSLayoutConstraint(item: alert.view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250)
                        alert.view.addConstraint(height)
                        alert.view.addConstraint(width)
                        if (UserDefaults.standard.bool(forKey: "Liv_Audio")) {
                        self.run(winSound)
                        }
                        self.viewController?.present(alert, animated: true, completion: nil)}
                    else if !alreadySelected {
                        if (UserDefaults.standard.bool(forKey: "Liv_Audio")) {
                        self.run(itemSelectionSound)
                        }
                    }
                }
                //lancia un errore se il nodo non e' tra quelli giusti
                else {
                    let alert = UIAlertController(title: "Oggetto sbagliato", message: "Ricordati che devi preparare il piatto mostrato!", preferredStyle: .alert)
                    customizeNotificationAlert(alert: alert)
                    self.viewController?.present(alert, animated: true, completion: nil)
                    if (UserDefaults.standard.bool(forKey: "Liv_Audio")) {
                    self.run(errorSound)
                    }
                    if oggettiSbagliatiLieviLivello2[tipoPiatto]!.contains(selezione) {
                        PersistenceManager.inserisciErrore(codice: 1, livello: 2, accesso: (self.viewController?.accesso)!)
                        self.nessunErrore = false
                    } else {
                        PersistenceManager.inserisciErrore(codice: 2, livello: 2, accesso: (self.viewController?.accesso)!)
                        self.nessunErrore = false
                        self.soloErroriLievi = false
                    }
                    movableNode!.position = initialPosition!
                }
            }
            //Riporta il nodo alla posizione originale se non e' stato messo nel cestino.
            else {
                movableNode!.position = initialPosition!
            }
            movableNode = nil
        }
    }
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            movableNode = nil
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if tutorial {
            tut_counter += 1
        } else {
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)

        if let name = touchedNode.name
            {
            switch name {
            case "tutorial":
                tut_counter = 0
                tut_sfondo?.isHidden = false
                piatto?.zPosition = CGFloat(4)
                piatto1?.zPosition = CGFloat(4)
                piatto2?.zPosition = CGFloat(4)
                tutorial = true
            case "audio":
                let status = UserDefaults.standard.bool(forKey: "Liv_Audio")
                UserDefaults.standard.setValue(!status, forKey: "Liv_Audio")
                if !status {
                    audio?.texture = SKTexture(imageNamed: "AudioOn")
                } else {
                    audio?.texture = SKTexture(imageNamed: "AudioOff")
                }
            case "chiudiLivello2":
                if (UserDefaults.standard.bool(forKey: "Liv_Audio")) {
                self.run(menuSelectionSound)
                }
                let alert = UIAlertController(title: "Vuoi uscire?", message: "", preferredStyle: .alert)
                customizeSelectionAlert(alert: alert)
                let yesAction = UIAlertAction(title: "Sì", style: .default, handler: {_ in
                    //Logga il tentativo fallito in CoreData:
                    let endTime = Date()
                    let durata = endTime.timeIntervalSince(self.startTime!)
                    PersistenceManager.inserisciTentativo(livello: 2, tempoTentativo: String(durata), successo: false, accesso:  self.viewController!.accesso!)
                    let tempoSessioneAggiunto = durata + Double(self.viewController!.accesso!.tempoSessione ?? "0.0")!
                    PersistenceManager.registraTempoSessione(diAccesso: self.viewController!.accesso!, conTempo: String(tempoSessioneAggiunto))
                    if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
                        // Set the scale mode to scale to fit the window
                        scene.scaleMode = .aspectFill
                        
                        // Present the scene
                        scene.viewController = self.viewController
                        self.view?.presentScene(scene)
                    }
                })
                yesAction.setValue(UIColor(#colorLiteral(red: 0.772777617, green: 0.1035105959, blue: 0, alpha: 1)), forKey: "titleTextColor")
                alert.addAction(yesAction)
                let noAction = UIAlertAction(title: "No", style: .default, handler: {_ in
                    alert.dismiss(animated: true, completion: nil)
                })
                noAction.setValue(UIColor(#colorLiteral(red: 0.772777617, green: 0.1035105959, blue: 0, alpha: 1)), forKey: "titleTextColor")
                alert.addAction(noAction)
                self.viewController?.present(alert, animated: true, completion: nil)
                
            case "check":
                if (UserDefaults.standard.bool(forKey: "Liv_Audio")) {
                self.run(menuSelectionSound)
                }
                let alert = UIAlertController(title: "Sei sicuro?", message: "Controlleremo se hai completato il livello", preferredStyle: .alert)
                customizeSelectionAlert(alert: alert)
                let yesAction = UIAlertAction(title: "Si", style: .default, handler: {_ in
                    var winCondition = true
                    for element in oggettiNecessariInLivello2[self.tipoPiatto]! {
                        if !self.oggettiSelezionati.contains(element) {
                            winCondition = false
                        }
                    }
                    if winCondition {
                        if (UserDefaults.standard.bool(forKey: "Liv_Audio")) {
                        self.run(winSound)
                        }
                        let alert = UIAlertController(title: "Congratulazioni!", message: "Hai fatto la spesa! \n \n \n \n \n", preferredStyle: .alert)
                        customizeSelectionAlert(alert: alert)
                        let okAction = UIAlertAction(title: "Ok", style: .default, handler: {
                            _ in
                            let endTime = Date()
                            let durata = endTime.timeIntervalSince(self.startTime!)
                            PersistenceManager.inserisciTentativo(livello: 2, tempoTentativo: String(durata), successo: true, accesso:  self.viewController!.accesso!)
                            let tempoSessioneAggiunto = durata + Double(self.viewController!.accesso!.tempoSessione ?? "0.0")!
                            PersistenceManager.registraTempoSessione(diAccesso: self.viewController!.accesso!, conTempo: String(tempoSessioneAggiunto))
                            if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
                                // Set the scale mode to scale to fit the window
                                scene.scaleMode = .aspectFill
                                
                                // Present the scene
                                scene.viewController = self.viewController
                                self.view?.presentScene(scene)
                            }
                        })
                        okAction.setValue(UIColor(#colorLiteral(red: 0.7149195075, green: 0, blue: 0, alpha: 1)), forKey: "titleTextColor")
                        alert.addAction(okAction)
                        let imageView = UIImageView(frame: CGRect(x: 10, y: 50, width: 250, height: 88))
                        var nomeImmagine = ""
                        if self.nessunErrore {
                            nomeImmagine = "Star3"
                        }
                        else if self.soloErroriLievi {
                            nomeImmagine = "Star2"
                        }
                        else {
                            nomeImmagine = "Star1"
                        }
                        imageView.image = UIImage(named: nomeImmagine)
                        alert.view.addSubview(imageView)
                        imageView.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 200).isActive = true
                        imageView.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor, constant: 50).isActive = true
                        let height = NSLayoutConstraint(item: alert.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200)
                        let width = NSLayoutConstraint(item: alert.view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250)
                        alert.view.addConstraint(height)
                        alert.view.addConstraint(width)
                        if (UserDefaults.standard.bool(forKey: "Liv_Audio")) {
                        self.run(winSound)
                        }
                        self.viewController?.present(alert, animated: true, completion: nil)}
                    else {
                        if (UserDefaults.standard.bool(forKey: "Liv_Audio")) {
                            self.run(errorSound)}
                        let alert = UIAlertController(title: "Oggetti insufficienti", message: "Ricordati che devi fare la spesa!", preferredStyle: .alert)
                        customizeNotificationAlert(alert: alert)
                        self.viewController?.present(alert, animated: true, completion: nil)
                        if (UserDefaults.standard.bool(forKey: "Liv_Audio")) {
                        self.run(errorSound)
                        }
                        PersistenceManager.inserisciErrore(codice: 0, livello: 2, accesso: self.viewController!.accesso!)
                        self.nessunErrore = false
                    }
                })
                yesAction.setValue(UIColor(#colorLiteral(red: 0.772777617, green: 0.1035105959, blue: 0, alpha: 1)), forKey: "titleTextColor")
                alert.addAction(yesAction)
                let noAction = UIAlertAction(title: "No", style: .default, handler: {_ in
                    if (UserDefaults.standard.bool(forKey: "Liv_Audio")) {
                        self.run(menuSelectionSound)}
                    alert.dismiss(animated: true, completion: nil)
                })
                noAction.setValue(UIColor(#colorLiteral(red: 0.772777617, green: 0.1035105959, blue: 0, alpha: 1)), forKey: "titleTextColor")
                alert.addAction(noAction)
                self.viewController?.present(alert, animated: true, completion: nil)
                
            case "node1", "node2", "node3", "node4", "node5", "node6", "node7", "node8", "node9", "node10", "node11", "node12":
                let node = self.childNode(withName: name) as? SKSpriteNode
                movableNode = node
                initialPosition = movableNode!.position
                movableNode!.position = positionInScene
            
            default:
                break
            }
        }
        }
    }
    }

