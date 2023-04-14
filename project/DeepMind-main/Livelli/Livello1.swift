//
//  Livello1.swift
//  DeepMind
//
//  Created by Marco Venere on 22/04/21.
//

import SpriteKit
import GameplayKit

class Livello1: SKScene {
    weak var viewController: GameViewController?
    private var startTime : Date?
    private var preparaIlPanino : SKLabelNode?
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
    private var tut_lab10: SKLabelNode?
    private var tut_lab11 : SKLabelNode?
    private var tut_lab12: SKLabelNode?
    private var tut_lab13: SKLabelNode?
    private var tut_lab14: SKLabelNode?
    private var tut_lab15: SKLabelNode?
    private var audio : SKSpriteNode?
    private var chiudiLivello1 : SKSpriteNode?
    private var tutorial = false
    private var node1 : SKSpriteNode?
    private var node2 : SKSpriteNode?
    private var node3 : SKSpriteNode?
    private var node4 : SKSpriteNode?
    private var node5 : SKSpriteNode?
    private var node6 : SKSpriteNode?
    private var node7 : SKSpriteNode?
    private var node8 : SKSpriteNode?
    private var tutorialButton : SKSpriteNode?
    private var frecciaDestra : SKSpriteNode?
    private var frecciaSinistra : SKSpriteNode?
    private var barra : SKSpriteNode?
    private var oggetti : [String]?
    private var initialSize : CGSize!
    private var paneSottoInserito = false
    private var ingredienteInserito = false
    private var myZ = 0
    private var numeroOggetti = 10
    private var stelle = [1:"Star1", 2:"Star2", 3:"Star3"]
    private var nessunErrore = true
    private var soloErroriLievi = true
    private var index : Int! {
        didSet{
            frecciaDestra?.isHidden = index == numeroOggetti - 5
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
                tut_lab1?.isHidden = true
                tut_lab2?.isHidden = true
                tut_lab3?.isHidden = false
                tut_lab4?.isHidden = false
                tut_lab3?.zPosition = CGFloat(myZ + 4)
                tut_lab4?.zPosition = CGFloat(myZ + 4)
                frecciaDestra?.zPosition = CGFloat(myZ + 4)
                node6?.zPosition = 1
                node7?.zPosition = 1
                node8?.zPosition = 1
                node4?.zPosition = 1
                node5?.zPosition = 1
            case 2:
                frecciaDestra?.zPosition = 1
                
                tut_lab3?.isHidden = true
                tut_lab4?.isHidden = true
                tut_lab5?.isHidden = false
                tut_lab5?.zPosition = CGFloat(myZ + 4)
                node6?.zPosition = CGFloat(myZ + 4)
            case 3:
                tut_lab5?.isHidden = true
                tut_lab6?.isHidden = false
                tut_lab7?.isHidden = false
                tut_lab8?.isHidden = false
                tut_lab6?.zPosition = CGFloat(myZ + 4)
                tut_lab7?.zPosition = CGFloat(myZ + 4)
                tut_lab8?.zPosition = CGFloat(myZ + 4)
                tut_lab5?.zPosition = 1
                node6?.zPosition = 1
                node7?.zPosition = CGFloat(myZ + 4)
            case 4:
                tut_lab6?.isHidden = true
                tut_lab7?.isHidden = true
                tut_lab8?.isHidden = true
                tut_lab9?.isHidden = false
                tut_lab10?.isHidden = false
                tut_lab9?.zPosition = CGFloat(myZ + 4)
                tut_lab10?.zPosition = CGFloat(myZ + 4)
                node8?.zPosition = CGFloat(myZ + 4)
                tut_lab6?.zPosition = 1
                tut_lab7?.zPosition = 1
                tut_lab8?.zPosition = 1
                node7?.zPosition = 1
            case 5:
                tut_lab9?.isHidden = true
                tut_lab10?.isHidden = true
                tut_lab9?.zPosition = 1
                tut_lab10?.zPosition = 1
                node8?.zPosition = 1
                tut_lab11?.isHidden = false
                tut_lab12?.isHidden = false
                tut_lab11?.zPosition = CGFloat(myZ + 4)
                tut_lab12?.zPosition = CGFloat(myZ + 4)
                audio?.zPosition = CGFloat(myZ + 4)
            case 6:
                tut_lab11?.isHidden = true
                tut_lab12?.isHidden = true
                tut_lab13?.isHidden = false
                tut_lab14?.isHidden = false
                tut_lab15?.isHidden = false
                tut_lab13?.zPosition = CGFloat(myZ + 4)
                tut_lab14?.zPosition = CGFloat(myZ + 4)
                tut_lab15?.zPosition = CGFloat(myZ + 4)
                chiudiLivello1?.zPosition = CGFloat(myZ + 4)
                tut_lab11?.zPosition = 1
                tut_lab12?.zPosition = 1
                audio?.zPosition = 1
            case 7:
                tut_lab13?.isHidden = true
                tut_lab14?.isHidden = true
                tut_lab15?.isHidden = true
                tut_lab13?.zPosition = 1
                tut_lab14?.zPosition = 1
                tut_lab15?.zPosition = 1
                chiudiLivello1?.zPosition = 1
                tut_sfondo?.isHidden = true
                node1?.isHidden = false
                node2?.isHidden = false
                node3?.isHidden = false
                node6?.isHidden = true
                node7?.isHidden = true
                node8?.isHidden = true
                tutorial = false
                UserDefaults.standard.setValue(true, forKey: "Liv1_TutorialFinito")
            default:
                break
            }
        }
    }
    
    override func didMove(to view: SKView) {
        scene?.scaleMode = .resizeFill
        startTime = Date()
        self.preparaIlPanino = self.childNode(withName: "//PreparaUnPanino") as! SKLabelNode
        self.tut_sfondo = self.childNode(withName: "//tut_sfondo") as? SKSpriteNode
        self.tut_lab1 = self.childNode(withName: "//tut_lab1") as? SKLabelNode
        self.tut_lab2 = self.childNode(withName: "//tut_lab2") as? SKLabelNode
        self.tut_lab3 = self.childNode(withName: "//tut_lab3") as? SKLabelNode
        self.tut_lab4 = self.childNode(withName: "//tut_lab4") as? SKLabelNode
        self.tut_lab5 = self.childNode(withName: "//tut_lab5") as? SKLabelNode
        self.tut_lab6 = self.childNode(withName: "//tut_lab6") as? SKLabelNode
        self.tut_lab7 = self.childNode(withName: "//tut_lab7") as? SKLabelNode
        self.tut_lab8 = self.childNode(withName: "//tut_lab8") as? SKLabelNode
        self.tut_lab9 = self.childNode(withName: "//tut_lab9") as? SKLabelNode
        self.tut_lab10 = self.childNode(withName: "//tut_lab10") as? SKLabelNode
        self.tut_lab11 = self.childNode(withName: "//tut_lab11") as? SKLabelNode
        self.tut_lab12 = self.childNode(withName: "//tut_lab12") as? SKLabelNode
        self.tut_lab13 = self.childNode(withName: "//tut_lab13") as? SKLabelNode
        self.tut_lab14 = self.childNode(withName: "//tut_lab14") as? SKLabelNode
        self.tut_lab15 = self.childNode(withName: "//tut_lab15") as? SKLabelNode
        self.node1 = self.childNode(withName: "//node1") as? SKSpriteNode
        self.node2 = self.childNode(withName: "//node2") as? SKSpriteNode
        self.node3 = self.childNode(withName: "//node3") as? SKSpriteNode
        self.node4 = self.childNode(withName: "//node4") as? SKSpriteNode
        self.node5 = self.childNode(withName: "//node5") as? SKSpriteNode
        self.node6 = self.childNode(withName: "//node6") as? SKSpriteNode
        self.node7 = self.childNode(withName: "//node7") as? SKSpriteNode
        self.node8 = self.childNode(withName: "//node8") as? SKSpriteNode
        self.audio = self.childNode(withName: "//audio") as? SKSpriteNode
        self.tutorialButton = self.childNode(withName: "//tutorial") as? SKSpriteNode
        self.chiudiLivello1 = self.childNode(withName: "//chiudiLivello1") as? SKSpriteNode
        self.frecciaDestra = self.childNode(withName: "//frecciaDestra") as? SKSpriteNode
        self.frecciaSinistra = self.childNode(withName: "//frecciaSinistra") as? SKSpriteNode
        self.barra = self.childNode(withName: "//barra") as? SKSpriteNode
        if UserDefaults.standard.bool(forKey: "Liv_Audio") {
            audio?.texture = SKTexture(imageNamed: "AudioOn")
        } else {
            audio?.texture = SKTexture(imageNamed: "AudioOff")
        }
        audio?.size = CGSize(width: 125.734, height: 135.337)
        barra?.isUserInteractionEnabled = false
        //node1?.drawBorder(color: UIColor.black, width: 100.0)
//        numeroOggetti = selezionaDifficolta(livello:1,difficolta:calcolaDifficoltaInBaseAdErrori())
        oggetti = initializeElementsRandomly(numberOfElements: numeroOggetti, livello: 1)
        
        initialSize = node1?.size
        index = 0
        if !UserDefaults.standard.bool(forKey: "Liv1_TutorialFinito") {
            tut_sfondo?.isHidden = false
            tut_sfondo?.zPosition = CGFloat(myZ + 4)
            tut_lab1?.isHidden = false
            tut_lab2?.isHidden = false
            tut_lab1?.zPosition = CGFloat(myZ + 4)
            tut_lab2?.zPosition = CGFloat(myZ + 4)
            node6?.isHidden = false
            node6?.zPosition = CGFloat(myZ + 4)
            node7?.zPosition = CGFloat(myZ + 4)
            node8?.zPosition = CGFloat(myZ + 4)
            node4?.zPosition = CGFloat(myZ + 4)
            node5?.zPosition = CGFloat(myZ + 4)
            node1?.isHidden = true
            node2?.isHidden = true
            node3?.isHidden = true
            node6?.isHidden = false
            node7?.isHidden = false
            node8?.isHidden = false
            tutorial = true
        } else {
            tut_sfondo?.isHidden = true
            node1?.isHidden = false
            node2?.isHidden = false
            node3?.isHidden = false
            node6?.isHidden = true
            node7?.isHidden = true
            node8?.isHidden = true
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
                tut_sfondo?.zPosition = CGFloat(myZ + 4)
                tut_lab1?.isHidden = false
                tut_lab2?.isHidden = false
                tut_lab1?.zPosition = CGFloat(myZ + 4)
                tut_lab2?.zPosition = CGFloat(myZ + 4)
                node6?.isHidden = false
                node6?.zPosition = CGFloat(myZ + 4)
                node7?.zPosition = CGFloat(myZ + 4)
                node8?.zPosition = CGFloat(myZ + 4)
                node4?.zPosition = CGFloat(myZ + 4)
                node5?.zPosition = CGFloat(myZ + 4)
                node1?.isHidden = true
                node2?.isHidden = true
                node3?.isHidden = true
                node6?.isHidden = false
                node7?.isHidden = false
                node8?.isHidden = false
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
                if (UserDefaults.standard.bool(forKey: "Liv_Audio")) {
                    self.run(itemSelectionSound)
                }
                let alert = UIAlertController(title: "Confermi?", message: "Hai selezionato " + selezione, preferredStyle: .alert)
                customizeSelectionAlert(alert: alert)
                let yesAction = UIAlertAction(title: "Sì", style: .default, handler: {_ in
                    if oggettiSbagliatiInLivello1.contains(selezione) {
                        let alert = UIAlertController(title: "Oggetto sbagliato", message: "Ricordati che devi fare un panino!", preferredStyle: .alert)
                        customizeNotificationAlert(alert: alert)
                        if (UserDefaults.standard.bool(forKey: "Liv_Audio")) {
                        self.run(errorSound)
                        }
                        self.viewController?.present(alert, animated: true, completion: nil)
                        if sbagliatiLievi.contains(selezione) {
                            PersistenceManager.inserisciErrore(codice: 1, livello: 1, accesso: (self.viewController?.accesso)!)
                            self.nessunErrore = false
                        } else {
                            PersistenceManager.inserisciErrore(codice: 2, livello: 1, accesso: (self.viewController?.accesso)!)
                            self.nessunErrore = false
                            self.soloErroriLievi = false
                        }
                    } else if selezione != "panesotto" && !self.paneSottoInserito {
                        let alert = UIAlertController(title: "Oggetto sbagliato", message: "Il primo ingrediente dovrebbe essere una fetta di pane.", preferredStyle: .alert)
                        customizeNotificationAlert(alert: alert)
                        if (UserDefaults.standard.bool(forKey: "Liv_Audio")) {
                        self.run(errorSound)
                        }
                        self.viewController?.present(alert, animated: true, completion: nil)
                        PersistenceManager.inserisciErrore(codice: 0, livello: 1, accesso: (self.viewController?.accesso)!)
                        self.nessunErrore = false
                    }  else if selezione == "panesopra" && !self.ingredienteInserito {
                        let alert = UIAlertController(title: "Oggetto sbagliato", message: "Il panino dovrebbe contenere almeno un ingrediente.", preferredStyle: .alert)
                        customizeNotificationAlert(alert: alert)
                        if (UserDefaults.standard.bool(forKey: "Liv_Audio")) {
                        self.run(errorSound)
                        }
                        self.viewController?.present(alert, animated: true, completion: nil)
                        PersistenceManager.inserisciErrore(codice: 0, livello: 1, accesso: (self.viewController?.accesso)!)
                        self.nessunErrore = false
                    } else {
                        if selezione == "panesotto" {
                            self.paneSottoInserito = true
                        }
                        let node = SKSpriteNode()
                        node.position = CGPoint(x: 0, y: self.myZ*15)
                        self.myZ += 1
                        node.zPosition = CGFloat(self.myZ)
                        node.texture = SKTexture(imageNamed: selezione!)
                        node.aspectFillToSize(fillSize: self.initialSize)
                        node.size = CGSize(width: node.size.width * 2, height: node.size.height * 2)
                        self.addChild(node)
                        if (selezione != "panesopra") {
                            if UserDefaults.standard.bool(forKey: "Liv_Audio") {
                                self.run(correctItemSound)
                            }
                        }
                        if oggettiGiustiInLivello1.contains(selezione) {
                            self.ingredienteInserito = true
                        } else if selezione == "panesopra" && self.ingredienteInserito {
                            let alert = UIAlertController(title: "Congratulazioni!", message: "Il panino è pronto! \n \n \n \n \n", preferredStyle: .alert)
                            customizeSelectionAlert(alert: alert)
                            let okAction = UIAlertAction(title: "Ok", style: .default, handler: {
                                _ in
                                let endTime = Date()
                                let durata = endTime.timeIntervalSince(self.startTime!)
                                PersistenceManager.inserisciTentativo(livello: 1, tempoTentativo: String(durata), successo: true, accesso:  self.viewController!.accesso!)
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
                            self.viewController?.present(alert, animated: true, completion: nil)
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
                index += 1
                if (UserDefaults.standard.bool(forKey: "Liv_Audio")) {
                self.run(menuSelectionSound)
                }
            case "frecciaSinistra":
                index -= 1
                if (UserDefaults.standard.bool(forKey: "Liv_Audio")) {
                self.run(menuSelectionSound)
                }
                
            case "chiudiLivello1":
                if (UserDefaults.standard.bool(forKey: "Liv_Audio")) {
                self.run(menuSelectionSound)
                }
                let alert = UIAlertController(title: "Vuoi uscire?", message: "", preferredStyle: .alert)
                customizeSelectionAlert(alert: alert)
                let yesAction = UIAlertAction(title: "Sì", style: .default, handler: {_ in
                    //Logga il tentativo fallito in CoreData:
                    let endTime = Date()
                    let durata = endTime.timeIntervalSince(self.startTime!)
                    PersistenceManager.inserisciTentativo(livello: 1, tempoTentativo: String(durata), successo: false, accesso:  self.viewController!.accesso!)
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
