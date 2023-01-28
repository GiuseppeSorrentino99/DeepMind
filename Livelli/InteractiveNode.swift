//
//  InteractiveNode.swift
//  DeepMind
//
//  Created by Marco Venere on 05/05/21.
//

import UIKit
import SpriteKit

class InteractiveNode: SKNode {
    var isRight : Bool = false
    var isClicked : Bool = false
    var isBright : Bool = false
    let viewController : GameViewController?
    let finalPosition : CGPoint
    
    init(livello : Int, gameController: GameViewController,finalPosition: CGPoint) {
        self.viewController=gameController
        self.finalPosition=finalPosition
        super.init()
        switch livello {
        case 1:
            self.position=CGPoint(x: Int.random(in:(-896)...(896)), y: Int.random(in: (-414)...(-199) ))
        case 2:
            self.position=CGPoint(x: Int.random(in:(-896)...(896)), y: Int.random(in: (-414)...(-199) ))
        case 3:
            self.position=CGPoint(x: Int.random(in:(-896)...(896)), y: Int.random(in: (-414)...(-199) ))
        default: break;
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    
    func onClick() {
            let alert = UIAlertController(title: "Confermi?", message: "", preferredStyle: .alert)
            let titleFont = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30), NSAttributedString.Key.foregroundColor : UIColor(#colorLiteral(red: 0.772777617, green: 0.1035105959, blue: 0, alpha: 1))]
            let titleAttrString = NSMutableAttributedString(string: "Confermi?", attributes: titleFont)
            alert.setValue(titleAttrString, forKey:"attributedTitle")
            let yesAction = UIAlertAction(title: "Sì", style: .default, handler: {_ in
                self.position = self.finalPosition
                self.isClicked = true
            })
            yesAction.setValue(UIColor(#colorLiteral(red: 0.772777617, green: 0.1035105959, blue: 0, alpha: 1)), forKey: "titleTextColor")
            alert.addAction(yesAction)
            let noAction = UIAlertAction(title: "No", style: .default, handler: {_ in
                alert.dismiss(animated: true, completion: nil)
                self.isClicked = false
            })
            noAction.setValue(UIColor(#colorLiteral(red: 0.772777617, green: 0.1035105959, blue: 0, alpha: 1)), forKey: "titleTextColor")
            alert.addAction(noAction)
            let subview = (alert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
                subview.layer.cornerRadius = 1
                subview.backgroundColor = UIColor(#colorLiteral(red: 1, green: 0.8256729245, blue: 0, alpha: 1))
            viewController!.present(alert, animated: true, completion: nil)
    }
}
