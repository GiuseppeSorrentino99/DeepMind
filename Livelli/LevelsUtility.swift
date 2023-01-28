//
//  LevelsUtility.swift
//  DeepMind
//
//  Created by Simone Salzano on 05/05/21.
//

import Foundation
import SpriteKit

var rightDict = [ 1 : true, 2: false, 3: true]

public var oggettiGiustiInLivello1 = ["bacon", "cetrioli", "cheddar", "cipolla", "formaggio", "funghi", "hamburgermaiale", "hamburgerpollo", "insalata","pomodoro","prosciutto"] //solo alcuni devono apparire nella lista effettiva
public var oggettiSbagliatiInLivello1 = ["teiera", "coltello", "forchetta", "bicchiere", "sturalavandino", "libro", "accendino", "telefono"] //potrebbero non comparire tutti, in funzione di numberOfElements

public var oggettiNecessariInLivello2 = [ //gli oggetti giusti dipendono dal piatto richiesto
    "piatto_pasta" : ["spaghetti", "pomodoro"],
    "piatto_carne" : ["carne", "insalata"],
    "piatto_pesce" : ["pesce", "insalata"],
    "piatto_uovo" : ["uova", "toast", "prosciutto"]
]

public var oggettiGiustiInLivello2 = [ //gli oggetti giusti dipendono dal piatto richiesto
    "piatto_pasta" : ["spaghetti", "pomodoro", "olio", "formaggio", "sale", "pepe"],
    "piatto_carne" : ["carne", "limone", "insalata", "olio", "sale", "pepe"],
    "piatto_pesce" : ["pesce", "pepe", "limone", "insalata", "sale", "olio"],
    "piatto_uovo" : ["uova", "pepe", "toast", "prosciutto", "olio", "sale"]
]
public var oggettiSbagliatiLieviLivello2 = [//gli oggetti sbagliati lievi dipendono dal
    //piatto richiesto
    "piatto_pasta" : ["carne", "pesce", "limone", "insalata", "toast", "uova"],
    "piatto_carne" : ["pesce", "spaghetti", "toast", "uova", "pomodoro"],
    "piatto_pesce" : ["carne", "spaghetti", "toast", "formaggio", "pomodoro", "uova"],
    "piatto_uovo" : ["spaghetti", "pomodoro", "formaggio", "carne", "limone", "insalata", "pesce"]
]
public let tipiLivello2 = [
    1 : "piatto_pasta",
    2 : "piatto_carne",
    3 : "piatto_pesce",
    4 : "piatto_uovo"
]
public var oggettiSbagliatiGraviLivello2 = ["coltello", "telefono", "pentola", "pentola1", "teiera", "forchetta", "sturalavandino", "libro", "accendino"] //potrebbero non comparire tutti, in funzione di numberOfElements
public let oggettiGiustiInLivello3 = ["coltello","forchetta","bicchiere", "piatto", "acqua", "cucchiaio"] //garantiti nella lista degli oggetti da comparire
public var oggettiSbagliatiInLivello3 = ["pistola", "pomodoro", "insalata", "telefono", "accendino", "libro", "giravite", "sturalavandino", "latte"] //potrebbero non comparire tutti, in funzione di numberOfElements
public var sbagliatiLievi = ["coltello", "forchetta", "bicchiere", "bicchiere", "pomodoro", "lattuga","latte"]
public var sbagliatiGravi = ["teiera", "sturalavandino", "libro", "accendino", "telefono", "pistola", "telefono", "martello", "giravite"]
//Gli oggetti vengono salvati in un dizionario che indica la loro posizione nella barra di sotto

public var errorSound = SKAction.playSoundFileNamed("Error", waitForCompletion: true)
public var winSound = SKAction.playSoundFileNamed("Ta-Da Orchestra", waitForCompletion: true)
public var menuSelectionSound = SKAction.playSoundFileNamed("click", waitForCompletion: true)
public var itemSelectionSound = SKAction.playSoundFileNamed("Item Selection", waitForCompletion: true)
public var correctItemSound = SKAction.playSoundFileNamed("Magical Point Win", waitForCompletion: true)

//Inseriamo in oggettiLivello alcuni elementi giusti e alcuni elementi sbagliati, scelti a caso, in modo da inserire un totale di numberOfElements elementi.
//Se il livello è 2, usare options per indicare la particolare tipologia di compito
func initializeElementsRandomly(numberOfElements: Int,livello: Int, option : String = "piatto_pasta") -> [String] {
    
    var oggettiLivello : [String] = []
    switch livello {
    case 1:
        oggettiLivello += ["panesopra", "panesotto"]
        oggettiGiustiInLivello1.shuffle()
        let count = Int(Double(numberOfElements) * 0.4)
        for element in 0..<count {
            oggettiLivello.append(oggettiGiustiInLivello1[element])
        }
        oggettiSbagliatiInLivello1.shuffle()
        for element in 0 ..< (numberOfElements - count - 2 > 0 ? numberOfElements - count - 2 : 0) {
            oggettiLivello.append(oggettiSbagliatiInLivello1[element])
        }
    case 2:
        oggettiLivello += oggettiGiustiInLivello2[option]!
        oggettiSbagliatiLieviLivello2[option]!.shuffle()
        let count = Int(round(Double(numberOfElements) * 0.333))
        for element in 0..<count {
            oggettiLivello.append(oggettiSbagliatiLieviLivello2[option]![element])
        }
        let remaining = numberOfElements - oggettiGiustiInLivello2[option]!.count - count
        for element in 0 ..< remaining {
            oggettiLivello.append(oggettiSbagliatiGraviLivello2[element])
        }
    case 3:
        oggettiLivello += oggettiGiustiInLivello3
        oggettiSbagliatiInLivello3.shuffle()
        let count = oggettiGiustiInLivello3.count
        for element in 0 ..< (numberOfElements - count) {
            oggettiLivello.append(oggettiSbagliatiInLivello3[element])
        }
    default:
        print("livello non esistente")
    }
    oggettiLivello.shuffle()
    return oggettiLivello
}

func customizeNotificationAlert(alert: UIAlertController){
    let titleFont = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30), NSAttributedString.Key.foregroundColor : UIColor(#colorLiteral(red: 0.772777617, green: 0.1035105959, blue: 0, alpha: 1))]
    let titleAttrString = NSMutableAttributedString(string: alert.title!, attributes: titleFont)
    alert.setValue(titleAttrString, forKey:"attributedTitle")
    let messageFont = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : UIColor(#colorLiteral(red: 0.772777617, green: 0.1035105959, blue: 0, alpha: 1))]
    let messageAttrString = NSMutableAttributedString(string: alert.message!, attributes: messageFont)
    alert.setValue(messageAttrString, forKey:"attributedMessage")
    let okAction = UIAlertAction(title: "Ok", style: .default, handler: {
        _ in
        alert.dismiss(animated: true, completion: nil)
    })
    okAction.setValue(UIColor(#colorLiteral(red: 0.772777617, green: 0.1035105959, blue: 0, alpha: 1)), forKey: "titleTextColor")
    alert.addAction(okAction)
    let subview = (alert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
    subview.layer.cornerRadius = 1
    subview.backgroundColor = UIColor(#colorLiteral(red: 1, green: 0.8256729245, blue: 0, alpha: 1))
}

func customizeSelectionAlert(alert: UIAlertController){
//    This doesn't add any actions since the selection's actions vary from case to case.
    let titleFont = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30), NSAttributedString.Key.foregroundColor : UIColor(#colorLiteral(red: 0.772777617, green: 0.1035105959, blue: 0, alpha: 1))]
    let titleAttrString = NSMutableAttributedString(string: alert.title!, attributes: titleFont)
    alert.setValue(titleAttrString, forKey:"attributedTitle")
    let messageFont = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : UIColor(#colorLiteral(red: 0.772777617, green: 0.1035105959, blue: 0, alpha: 1))]
    let messageAttrString = NSMutableAttributedString(string: alert.message!, attributes: messageFont)
    alert.setValue(messageAttrString, forKey:"attributedMessage")
    
    let subview = (alert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
    subview.layer.cornerRadius = 1
    subview.backgroundColor = UIColor(#colorLiteral(red: 1, green: 0.8256729245, blue: 0, alpha: 1))
}

extension SKSpriteNode {
func aspectFillToSize(fillSize: CGSize) {
    if let texture = self.texture {
        let horizontalRatio = fillSize.width / texture.size().width
        let verticalRatio = fillSize.height / texture.size().height
        let finalRatio = horizontalRatio < verticalRatio ? horizontalRatio : verticalRatio
        size = CGSize(width: texture.size().width * finalRatio, height: texture.size().height * finalRatio)
    }
}

}
