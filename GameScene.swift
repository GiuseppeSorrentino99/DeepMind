//
//  GameScene.swift
//  DeepMind
//
//  Created by Giuseppe Sorrentino on 10/04/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    private var giuseppe = true
    private var label : SKLabelNode?
    private var immagine : SKSpriteNode?
    private var nodoImmagine : SKSpriteNode?
    private var tastoAvanti: SKSpriteNode?
    private var tastoIndietro: SKSpriteNode?
    private var gioca: SKLabelNode?
    private var audio : SKSpriteNode?
    weak var viewController: UIViewController?
    
    private var selector: Int = 1 {
        didSet{
            if selector == 1 {
                tastoIndietro?.alpha = 0
            }
            else {
                tastoIndietro?.alpha = 1
            }
            if selector == 3 {
                tastoAvanti?.alpha = 0
            }
            else {
                tastoAvanti?.alpha = 1
            }
        }
    }
    
    func switchToNext(selector: Int) {
       
        if !((nodoImmagine?.hasActions())!) {
            let xpos = CGFloat(0.0)
            let moveLeft = SKAction.moveTo(x: (immagine?.position.x)! - 50, duration: 0.4)
            immagine?.run(moveLeft, completion: {
                self.immagine?.texture = SKTexture(imageNamed: Livelli.immagini[self.selector]!)
                if selector == 3 {
                    self.immagine?.size.height += 10
                    self.immagine?.size.width += 10
                }
                self.immagine?.position = CGPoint(x: xpos + 50, y: (self.immagine?.position.y)!)
                let moveRight = SKAction.moveTo(x: xpos, duration: 0.4)
                self.immagine?.run(moveRight)
            })
            self.label?.run(SKAction.fadeOut(withDuration: 0.4), completion: {
                self.label!.text = Livelli.descrizioni[self.selector]
                self.label?.run(SKAction.fadeIn(withDuration: 0.4))
            })
        }
    }
    
    func switchToPrevious(selector: Int) {
        if !((nodoImmagine?.hasActions())!){
                   let xpos = CGFloat(0.0)
                   let moveRight = SKAction.moveTo(x: (immagine?.position.x)! + 50, duration: 0.4)
                   immagine?.run(moveRight, completion: {
                       self.immagine?.texture = SKTexture(imageNamed: Livelli.immagini[self.selector]!)
                       if selector + 1 == 3 {
                           self.immagine?.size.height -= 10
                           self.immagine?.size.width -= 10
                       }
                       self.immagine?.position = CGPoint(x: xpos - 50, y: (self.immagine?.position.y)!)
                       let moveLeft = SKAction.moveTo(x: xpos, duration: 0.4)
                       self.immagine?.run(moveLeft)
                   })
                   self.label?.run(SKAction.fadeOut(withDuration: 0.4), completion: {
                       self.label!.text = Livelli.descrizioni[self.selector]
                       self.label?.run(SKAction.fadeIn(withDuration: 0.4))
                   })
               }
    }
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//titolo") as? SKLabelNode
        self.immagine = self.childNode(withName: "//immagine") as? SKSpriteNode
        self.nodoImmagine = self.childNode(withName: "//nodoImmagine") as? SKSpriteNode
        self.tastoAvanti = self.childNode(withName: "//tastoAvanti") as? SKSpriteNode
        self.tastoIndietro = self.childNode(withName: "//tastoIndietro") as? SKSpriteNode
        self.gioca = self.childNode(withName: "//gioca") as? SKLabelNode
        self.audio = self.childNode(withName: "//audio") as? SKSpriteNode
        if UserDefaults.standard.bool(forKey: "Liv_Audio") {
            audio?.texture = SKTexture(imageNamed: "AudioOn")
        } else {
            audio?.texture = SKTexture(imageNamed: "AudioOff")
        }
        tastoIndietro?.alpha = 0
        //        if let label = self.label {
        //            label.alpha = 0.0
        //            label.run(SKAction.fadeIn(withDuration: 2.0))
        //        }
        
        // Create shape node to use during mouse interaction
        //        let w = (self.size.width + self.size.height) * 0.05
        //        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        //
        //        if let spinnyNode = self.spinnyNode {
        //            spinnyNode.lineWidth = 2.5
        //
        //            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
        //            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
        //                                              SKAction.fadeOut(withDuration: 0.5),
        //                                              SKAction.removeFromParent()]))
        //         }*/
        //
    }
    
    /*
     func touchDown(atPoint pos : CGPoint) {
     if let n = self.spinnyNode?.copy() as! SKShapeNode? {
     n.position = pos
     n.strokeColor = SKColor.green
     self.addChild(n)
     }
     }
     
     func touchMoved(toPoint pos : CGPoint) {
     if let n = self.spinnyNode?.copy() as! SKShapeNode? {
     n.position = pos
     n.strokeColor = SKColor.blue
     self.addChild(n)
     }
     }
     
     func touchUp(atPoint pos : CGPoint) {
     if let n = self.spinnyNode?.copy() as! SKShapeNode? {
     n.position = pos
     n.strokeColor = SKColor.red
     self.addChild(n)
     }
     }
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        if let name = touchedNode.name
        {
            switch name {
            case "label":
                if UserDefaults.standard.bool(forKey: "Liv_Audio") {
                    self.run(menuSelectionSound)
                }
                    if let nextScene = Livello1(fileNamed: "Livello1"){
                        nextScene.scaleMode = self.scaleMode
                        var transition:SKTransition = SKTransition.fade(withDuration: 1)
                        self.view?.presentScene(nextScene, transition: transition)
                    }
            case "chiudi":
                if UserDefaults.standard.bool(forKey: "Liv_Audio") {
                    self.run(menuSelectionSound)
                }
                    viewController?.navigationController?.isNavigationBarHidden = false
                    viewController?.navigationController?.popViewController(animated: true)
            case "audio":
                let status = UserDefaults.standard.bool(forKey: "Liv_Audio")
                UserDefaults.standard.setValue(!status, forKey: "Liv_Audio")
                if !status {
                    audio?.texture = SKTexture(imageNamed: "AudioOn")
                } else {
                    audio?.texture = SKTexture(imageNamed: "AudioOff")
                }
            case "tastoIndietro":
                if UserDefaults.standard.bool(forKey: "Liv_Audio") {
                    self.run(menuSelectionSound)
                }
                if selector>1 {
                    selector -= 1
                    switchToPrevious(selector: selector)
                }
                
            case "tastoAvanti":
                if UserDefaults.standard.bool(forKey: "Liv_Audio") {
                    self.run(menuSelectionSound)
                }
                if selector<3 {
                    selector += 1
                    switchToNext(selector: selector)
                }
                
            case "gioca":
                selectLevel(level: selector)
                
            default:
                break
            }
        }
       
    }
    
    /*
     override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
     for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
     }
     
     override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
     for t in touches { self.touchUp(atPoint: t.location(in: self)) }
     }
     
     override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
     for t in touches { self.touchUp(atPoint: t.location(in: self)) }
     }
     
     
     override func update(_ currentTime: TimeInterval) {
     // Called before each frame is rendered
     }*/
    
    func selectLevel(level: Int){
        
        
        switch level {
        
        case 1:
            if let scene = SKScene(fileNamed: "Livello1") as? Livello1 {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                if UserDefaults.standard.bool(forKey: "Liv_Audio") {
                    scene.run(menuSelectionSound)
                }
                // Present the scene
                scene.viewController = self.viewController as! GameViewController
                
                self.view?.presentScene(scene)
            }
            
        case 2:
            if let scene = SKScene(fileNamed: "Livello2") as? Livello2 {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                if UserDefaults.standard.bool(forKey: "Liv_Audio") {
                    scene.run(menuSelectionSound)
                }
                // Present the scene
                scene.viewController = self.viewController as! GameViewController
            
                self.view?.presentScene(scene)
            }
            
        case 3:
            if let scene = SKScene(fileNamed: "Livello3") as? Livello3 {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                if UserDefaults.standard.bool(forKey: "Liv_Audio") {
                    scene.run(menuSelectionSound)
                }
                // Present the scene
                scene.viewController = self.viewController as! GameViewController
                
                self.view?.presentScene(scene)
            }
            
        default:
            print("This level does not exist.")
            
        }
    }
}


