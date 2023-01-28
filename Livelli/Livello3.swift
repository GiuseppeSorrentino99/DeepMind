//
//  Livello3.swift
//  DeepMind
//
//  Created by Simone Salzano on 27/04/21.
//

import UIKit
import SpriteKit

class Livello3: SKScene {
    weak var viewController: GameViewController?
    private var startTime : Date?
    private var audio : SKSpriteNode?
    private var node1 : SKSpriteNode?
    private var node2 : SKSpriteNode?
    private var node3 : SKSpriteNode?
    private var node4 : SKSpriteNode?
    private var node5 : SKSpriteNode?
    private var tut_sfondo : SKSpriteNode?
    private var tut_lab1 : SKLabelNode?
    private var tut_lab2: SKLabelNode?
    private var tut_lab3 : SKLabelNode?
    private var tut_lab4: SKLabelNode?
    private var tut_lab5 : SKLabelNode?
    private var tut_lab6: SKLabelNode?
    private var tut_lab7 : SKLabelNode?
    private var tut_lab8: SKLabelNode?
    private var tut_lab9 : SKLabelNode?
    private var tutorialButton : SKSpriteNode?
    private var frecciaDestra : SKSpriteNode?
    private var frecciaSinistra : SKSpriteNode?
    private var check : SKSpriteNode?
    private var chiudiLivello3 : SKSpriteNode?
    private var barra : SKSpriteNode?
    private var oggetti : [String]?
    private var initialSize : CGSize!
    private var oggettiSelezionati = [String]()
    private var positionDict = ["coltello": CGPoint(x:-240,y:0),"forchetta": CGPoint(x:240,y:0),"bicchiere": CGPoint(x:480,y:170), "piatto": CGPoint(x:0,y:0), "acqua": CGPoint(x:-440,y:50), "cucchiaio": CGPoint(x:320,y:0)]
    private var sizeDict = ["coltello": [1.75,1.75],"forchetta": [1.75,1.75],"bicchiere": [1.5,1.5], "piatto": [2.5,2.5], "acqua": [2,2], "cucchiaio": [1.75,1.75]]
    private var numeroOggetti = 12
    private var nessunErrore = true
    private var soloErroriLievi = true
    private var tutorial = false
    private var index : Int! {
        didSet{
            frecciaDestra?.isHidden = index == numeroOggetti-5
            frecciaSinistra?.isHidden = index == 0
            node1?.texture = SKTexture(imageNamed: (oggetti?[index])!)
            node1?.aspectFillToSize(fillSize: initialSize)
            node2?.texture = SKTexture(imageNamed: (oggetti?[index + 1])!)
            node2?.aspectFillToSize(fillSize: initialSize)
            node3?.texture = SKTexture(imageNamed: (oggetti?[index + 2])!)
            node3?.aspectFillToSize(fillSize: initialSize)
            node4?.texture = SKTexture(imageNamed: (oggetti?[index + 3])!)
            node4?.aspectFillToSize(fillSize: initialSize)
            node5?.texture = SKTexture(imageNamed: (oggetti?[index + 4])!)
            node5?.aspectFillToSize(fillSize: initialSize)
        }
    }
    
    var tut_counter = 0 {
        didSet {
            switch(tut_counter) {
            case 1:
                node1?.zPosition = 4
                node2?.zPosition = 4
                node3?.zPosition = 4
                node4?.zPosition = 4
                node5?.zPosition = 4
                tut_lab1?.isHidden = true
                tut_lab2?.isHidden = true
                tut_lab3?.isHidden = false
                tut_lab4?.isHidden = false
                tut_lab3?.zPosition = CGFloat( 4)
                tut_lab4?.zPosition = CGFloat(4)
                frecciaDestra?.zPosition = 1
            case 2:
                node1?.zPosition = 1
                node2?.zPosition = 1
                node3?.zPosition = 1
                node4?.zPosition = 1
                node5?.zPosition = 1
                tut_lab3?.isHidden = true
                tut_lab4?.isHidden = true
                tut_lab5?.isHidden = false
                tut_lab5?.zPosition = CGFloat(4)
                check?.zPosition = CGFloat(4)
            case 3:
                tut_lab5?.isHidden = true
                tut_lab5?.zPosition = 1
                tut_lab6?.isHidden = false
                tut_lab7?.isHidden = false
                tut_lab6?.zPosition = CGFloat(4)
                tut_lab7?.zPosition = CGFloat(4)
                check?.zPosition = 1
                audio?.zPosition = CGFloat(4)
            case 4:
                tut_lab8?.isHidden = false
                tut_lab9?.isHidden = false
                tut_lab8?.zPosition = CGFloat(4)
                tut_lab9?.zPosition = CGFloat(4)
                tut_lab6?.isHidden = true
                tut_lab7?.isHidden = true
                chiudiLivello3?.zPosition = CGFloat(4)
                audio?.zPosition = 1
                tut_lab6?.zPosition = 1
                tut_lab7?.zPosition = 1
            case 5:
                tut_lab8?.isHidden = true
                tut_lab9?.isHidden = true
                tut_lab8?.zPosition = 1
                tut_lab9?.zPosition = 1
                chiudiLivello3?.zPosition = 1
                tut_sfondo?.isHidden = true
                tutorial = false
                UserDefaults.standard.setValue(true, forKey: "Liv3_TutorialFinito")
            default:
                break
            }
        }
    }
    
    override func didMove(to view: SKView) {
        scene?.scaleMode = .resizeFill
        startTime = Date()

        self.audio = self.childNode(withName: "//audio") as? SKSpriteNode
        self.chiudiLivello3 = self.childNode(withName: "//chiudiLivello3") as? SKSpriteNode
        self.check = self.childNode(withName: "//check") as? SKSpriteNode
        self.node1 = self.childNode(withName: "//node1") as? SKSpriteNode
        self.node2 = self.childNode(withName: "//node2") as? SKSpriteNode
        self.node3 = self.childNode(withName: "//node3") as? SKSpriteNode
        self.node4 = self.childNode(withName: "//node4") as? SKSpriteNode
        self.node5 = self.childNode(withName: "//node5") as? SKSpriteNode
        self.tut_sfondo = self.childNode(withName: "//tut_sfondo") as? SKSpriteNode
        self.tutorialButton = self.childNode(withName: "//tutorial") as? SKSpriteNode
        self.tut_lab1 = self.childNode(withName: "//tut_lab1") as? SKLabelNode
        self.tut_lab2 = self.childNode(withName: "//tut_lab2") as? SKLabelNode
        self.tut_lab3 = self.childNode(withName: "//tut_lab3") as? SKLabelNode
        self.tut_lab4 = self.childNode(withName: "//tut_lab4") as? SKLabelNode
        self.tut_lab5 = self.childNode(withName: "//tut_lab5") as? SKLabelNode
        self.tut_lab6 = self.childNode(withName: "//tut_lab6") as? SKLabelNode
        self.tut_lab7 = self.childNode(withName: "//tut_lab7") as? SKLabelNode
        self.tut_lab8 = self.childNode(withName: "//tut_lab8") as? SKLabelNode
        self.tut_lab9 = self.childNode(withName: "//tut_lab9") as? SKLabelNode
        self.frecciaDestra = self.childNode(withName: "//frecciaDestra") as? SKSpriteNode
        self.frecciaSinistra = self.childNode(withName: "//frecciaSinistra") as? SKSpriteNode
        self.barra = self.childNode(withName: "//barra") as? SKSpriteNode
        if UserDefaults.standard.bool(forKey: "Liv_Audio") {
            audio?.texture = SKTexture(imageNamed: "AudioOn")
        } else {
            audio?.texture = SKTexture(imageNamed: "AudioOff")
        }
        barra?.isUserInteractionEnabled = false
        
        //      numeroOggetti = selezionaDifficolta(livello:1,difficolta:calcolaDifficoltaInBaseAdErrori())
        oggetti = initializeElementsRandomly(numberOfElements: numeroOggetti, livello: 3)
        
        initialSize = node1?.size
        index = 0
        if !UserDefaults.standard.bool(forKey: "Liv3_TutorialFinito") {
            tut_sfondo?.isHidden = false
            tut_sfondo?.zPosition = CGFloat(4)
            tut_lab1?.isHidden = false
            tut_lab2?.isHidden = false
            tut_lab1?.zPosition = CGFloat(4)
            tut_lab2?.zPosition = CGFloat(4)
            frecciaDestra?.zPosition = CGFloat(4)
            tutorial = true
            
        } else {
            tut_sfondo?.isHidden = true
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
                tut_sfondo?.zPosition = CGFloat(4)
                tut_lab1?.isHidden = false
                tut_lab2?.isHidden = false
                tut_lab1?.zPosition = CGFloat(4)
                tut_lab2?.zPosition = CGFloat(4)
                frecciaDestra?.zPosition = CGFloat(4)
                tutorial = true
                
            case "audio":
                let status = UserDefaults.standard.bool(forKey: "Liv_Audio")
                UserDefaults.standard.setValue(!status, forKey: "Liv_Audio")
                if !status {
                    audio?.texture = SKTexture(imageNamed: "AudioOn")
                } else {
                    audio?.texture = SKTexture(imageNamed: "AudioOff")
                }
            case "node1", "node2", "node3", "node4", "node5":
                if (UserDefaults.standard.bool(forKey: "Liv_Audio")) {
                self.run(itemSelectionSound)
                }
                var selezione : String!
                switch name {
                case "node1":
                    selezione = oggetti![index]
                    print("selezionato")
                case "node2":
                    selezione = oggetti![index + 1]
                case "node3":
                    selezione = oggetti![index + 2]
                case "node4":
                    selezione = oggetti![index + 3]
                case "node5":
                    selezione = oggetti![index + 4]
                default:
                    break
                }
                let alert = UIAlertController(title: "Confermi?", message: "Hai selezionato " + selezione, preferredStyle: .alert)
                customizeSelectionAlert(alert: alert)
                let yesAction = UIAlertAction(title: "Sì", style: .default, handler: {_ in
                    if oggettiSbagliatiInLivello3.contains(selezione) {
                        let alert = UIAlertController(title: "Oggetto sbagliato", message: "Ricordati che devi apparecchiare la tavola!", preferredStyle: .alert)
                        customizeNotificationAlert(alert: alert)
                        if (UserDefaults.standard.bool(forKey: "Liv_Audio")) {
                        self.run(errorSound)
                        }
                        self.viewController?.present(alert, animated: true, completion: nil)
                        if sbagliatiLievi.contains(selezione) {
                            PersistenceManager.inserisciErrore(codice: 1, livello: 3, accesso: (self.viewController?.accesso)!)
                            self.nessunErrore = false
                        } else {
                            PersistenceManager.inserisciErrore(codice: 2, livello: 3, accesso: (self.viewController?.accesso)!)
                            self.nessunErrore = false
                            self.soloErroriLievi = false
                        }
                    }
                    else {
                        var deveSuonareNormale = true
                        if !self.oggettiSelezionati.contains(selezione) {
                            self.oggettiSelezionati.append(selezione)
                            let node = SKSpriteNode()
                            node.position = self.positionDict[selezione] ?? CGPoint(x:0,y:0)
                            node.zPosition = 1
                            node.texture = SKTexture(imageNamed: selezione!)
                            node.aspectFillToSize(fillSize: self.initialSize)
                            node.size = CGSize(width: Double(node.size.width) * self.sizeDict[selezione]![0], height: Double(node.size.height) * self.sizeDict[selezione]![1])
                            self.addChild(node)
                        }
                        else {
                            var deveSuonareNormale = false
                            if (UserDefaults.standard.bool(forKey: "Liv_Audio")) {
                                self.run(errorSound)}
                            let alert = UIAlertController(title: "Oggetto gia' presente", message: "Devi mettere un solo oggetto per tipo!", preferredStyle: .alert)
                            customizeNotificationAlert(alert: alert)
                            self.viewController?.present(alert, animated: true, completion: nil)
                            PersistenceManager.inserisciErrore(codice: 1, livello: 3, accesso: self.viewController!.accesso!)
                            self.nessunErrore = false
                        }
                        if self.oggettiSelezionati.count == oggettiGiustiInLivello3.count {
                            deveSuonareNormale = false
                            if (UserDefaults.standard.bool(forKey: "Liv_Audio")) {
                            self.run(winSound)
                            }
                            let alert = UIAlertController(title: "Congratulazioni!", message: "Hai apparecchiato la tavola! \n \n \n \n \n", preferredStyle: .alert)
                            customizeSelectionAlert(alert: alert)
                            let okAction = UIAlertAction(title: "Ok", style: .default, handler: {
                                _ in
                                let endTime = Date()
                                let durata = endTime.timeIntervalSince(self.startTime!)
                                PersistenceManager.inserisciTentativo(livello: 3, tempoTentativo: String(durata), successo: true, accesso:  self.viewController!.accesso!)
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
                        if deveSuonareNormale {
                            if (UserDefaults.standard.bool(forKey: "Liv_Audio")) {
                            self.run(correctItemSound)
                            }
                        }
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
                
            case "frecciaDestra":
                if (UserDefaults.standard.bool(forKey: "Liv_Audio")) {
                self.run(menuSelectionSound)
                }
                index += 1
            case "frecciaSinistra":
                if (UserDefaults.standard.bool(forKey: "Liv_Audio")) {
                self.run(menuSelectionSound)
                }
                index -= 1
                
            case "check":
                if (UserDefaults.standard.bool(forKey: "Liv_Audio")) {
                self.run(menuSelectionSound)
                }
                let alert = UIAlertController(title: "Sei sicuro?", message: "Controlleremo se hai completato il livello", preferredStyle: .alert)
                customizeSelectionAlert(alert: alert)
                let yesAction = UIAlertAction(title: "Si", style: .default, handler: {_ in
                    if self.oggettiSelezionati.contains("piatto") && (self.oggettiSelezionati.contains("bicchiere") || self.oggettiSelezionati.contains("acqua")) && (self.oggettiSelezionati.contains("forchetta") || self.oggettiSelezionati.contains("coltello") || self.oggettiSelezionati.contains("cucchiaio")) {
                        if (UserDefaults.standard.bool(forKey: "Liv_Audio")) {
                        self.run(winSound)
                        }
                        let alert = UIAlertController(title: "Congratulazioni!", message: "Hai apparecchiato la tavola! \n \n \n \n \n", preferredStyle: .alert)
                        customizeSelectionAlert(alert: alert)
                        let okAction = UIAlertAction(title: "Ok", style: .default, handler: {
                            _ in
                            let endTime = Date()
                            let durata = endTime.timeIntervalSince(self.startTime!)
                            PersistenceManager.inserisciTentativo(livello: 3, tempoTentativo: String(durata), successo: true, accesso:  self.viewController!.accesso!)
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
                        self.run(errorSound)
                        }
                        let alert = UIAlertController(title: "Oggetti insufficienti", message: "Ricordati che devi apparecchiare la tavola!", preferredStyle: .alert)
                        customizeNotificationAlert(alert: alert)
                        self.viewController?.present(alert, animated: true, completion: nil)
                        PersistenceManager.inserisciErrore(codice: 0, livello: 3, accesso: self.viewController!.accesso!)
                        self.nessunErrore = false
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
                
            case "chiudiLivello3":
                if (UserDefaults.standard.bool(forKey: "Liv_Audio")) {
                self.run(menuSelectionSound)
                }
                let alert = UIAlertController(title: "Vuoi uscire?", message: "", preferredStyle: .alert)
                customizeSelectionAlert(alert: alert)
                let yesAction = UIAlertAction(title: "Sì", style: .default, handler: {_ in
                    //Logga il tentativo fallito in CoreData:
                    let endTime = Date()
                    let durata = endTime.timeIntervalSince(self.startTime!)
                    PersistenceManager.inserisciTentativo(livello: 3, tempoTentativo: String(durata), successo: false, accesso:  self.viewController!.accesso!)
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
                
            default:
                break
            }
        }
    }
    }
}
