//
//  StatController.swift
//  DeepMind
//
//  Created by Giuseppe Sorrentino on 21/04/21.
//

import UIKit
import Charts

class StatController: UIViewController {
    @IBOutlet weak var SelettoreModalitá: UISegmentedControl!
    @IBOutlet weak var SelettoreFrequenza: UISegmentedControl!
    var Errori : Array<String>?
    var Occorrenze:Array<Int>?
    var arrErr0:Array<Errori>?
    var arrErr1:Array<Errori>?
    var arrErr2:Array<Errori>?
    var arrErrLiv1:Array<Errori>?
    var arrErrLiv2:Array<Errori>?
    var arrErrLiv3:Array<Errori>?
    
    @IBAction func ModeAction(_ sender: Any) {
        stampa()
    }
    @IBAction func FrequencyAction(_ sender: Any) {
        stampa()
    }
    
    // var arrayEsempio=Array<Errori>()//array d'esempio
    
    
    
    @IBOutlet weak var PieChartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stampa()
        PieChartView.highlightPerTapEnabled=false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // AppUtility.lockOrientation(.landscape)
        // Or to rotate and lock
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Don't forget to reset when view is being removed
        AppUtility.lockOrientation(.all)
    }
    
    //questa funzione deve essere usata per calcolare il numero occorrenze per ogni tipo di errore per ogni livello. Prima di questa funzione occorre chiamare una funzione che distingua nel tempo l'array(se nell'ultimo mese o nell'ultima settimana)
    func contaCodici(array: Array<DeepMind.Errori>)->Array<Int>{
        var ArrayCodici=Array<Int>()
        ArrayCodici.append(0)
        ArrayCodici.append(0)
        ArrayCodici.append(0)
        ArrayCodici.append(0)
        ArrayCodici.append(0)
        print("numero di elementi: "+"\(array.count)")
        for i in (0..<array.count)
        {
            
            let e = array[i]
            print(e.codice)
            switch e.codice{
            case 1: ArrayCodici[0]=ArrayCodici[0]+1
            case 2: ArrayCodici[1]=ArrayCodici[1]+1
            case 3: ArrayCodici[2]=ArrayCodici[2]+1
            case 4: ArrayCodici[3]=ArrayCodici[3]+1
            default: ArrayCodici[4]=ArrayCodici[4]+1
            }
            
        }
        
        return ArrayCodici
    }
    func stampa()->(){
        switch SelettoreModalitá.selectedSegmentIndex{
        case 0:
            switch SelettoreFrequenza.selectedSegmentIndex{
            //grafico dei livelli settimanali
            case 0:
                arrErrLiv1=PersistenceManager.fetchErroriInSettimana(codice: -1, livello: 1)
                arrErrLiv2=PersistenceManager.fetchErroriInSettimana(codice: -1, livello: 2)
                arrErrLiv3=PersistenceManager.fetchErroriInSettimana(codice: -1, livello: 3)
                var Errori : Array<String>?=[]
                var NumErr : Array<Int>?=[]
                if arrErrLiv1?.count != 0 {
                    NumErr?.append(arrErrLiv1!.count)
                    Errori?.append("Livello 1")
                }
                if arrErrLiv2?.count != 0 {
                    NumErr?.append(arrErrLiv2!.count)
                    Errori?.append("Livello 2")
                }
                if arrErrLiv3?.count != 0 {
                    NumErr?.append(arrErrLiv3!.count)
                    Errori?.append("Livello 3")
                }
                customizeChart(dataPoints: Errori!, values: NumErr!.map{Double($0)})
            

            //grafico dei livelli mensili
            case 1:
                arrErrLiv1=PersistenceManager.fetchErroriInMese(codice: -1, livello: 1)
                arrErrLiv2=PersistenceManager.fetchErroriInMese(codice: -1, livello: 2)
                arrErrLiv3=PersistenceManager.fetchErroriInMese(codice: -1, livello: 3)
                var Errori : Array<String>?=[]
                var NumErr : Array<Int>?=[]
                if arrErrLiv1?.count != 0 {
                    NumErr?.append(arrErrLiv1!.count)
                    Errori?.append("Livello 1")
                }
                if arrErrLiv2?.count != 0 {
                    NumErr?.append(arrErrLiv2!.count)
                    Errori?.append("Livello 2")
                }
                if arrErrLiv3?.count != 0 {
                    NumErr?.append(arrErrLiv3!.count)
                    Errori?.append("Livello 3")
                }
                customizeChart(dataPoints: Errori!, values: NumErr!.map{Double($0)})
                    
            default: break
            }
        case 1:
            switch SelettoreFrequenza.selectedSegmentIndex{
            //grafico codici Livello1 settimanale
            case 0:
                
                let arrErrLiv1Cod0=PersistenceManager.fetchErroriInSettimana(codice: 0, livello: 1)
                let arrErrLiv1Cod1=PersistenceManager.fetchErroriInSettimana(codice: 1, livello: 1)
                let arrErrLiv1Cod2=PersistenceManager.fetchErroriInSettimana(codice: 2, livello: 1)

                var Errori : Array<String>?=[]
                var NumErr:Array<Int>?=[]
                if arrErrLiv1Cod0.count != 0 {
                    Errori?.append(TipiErrore.TipiErrore[0]!)
                    NumErr?.append(arrErrLiv1Cod0.count)
                }
                if arrErrLiv1Cod1.count != 0 {
                    Errori?.append(TipiErrore.TipiErrore[1]!)
                    NumErr?.append(arrErrLiv1Cod1.count)
                }
                if arrErrLiv1Cod2.count != 0 {
                    Errori?.append(TipiErrore.TipiErrore[2]!)
                    NumErr?.append(arrErrLiv1Cod2.count)
                }
              
                
                customizeChart(dataPoints: Errori!, values: NumErr!.map{ Double($0)})

            //grafico codici Livello1 mensile
            case 1:
                let arrErrLiv1Cod0=PersistenceManager.fetchErroriInMese(codice: 0, livello: 1)
                let arrErrLiv1Cod1=PersistenceManager.fetchErroriInMese(codice: 1, livello: 1)
                let arrErrLiv1Cod2=PersistenceManager.fetchErroriInMese(codice: 2, livello: 1)
                var NumErr:Array<Int>?=[]
                var Errori : Array<String>?=[]
                if arrErrLiv1Cod0.count != 0 {
                    Errori?.append(TipiErrore.TipiErrore[0]!)
                    NumErr?.append(arrErrLiv1Cod0.count)
                }
                if arrErrLiv1Cod1.count != 0 {
                    Errori?.append(TipiErrore.TipiErrore[1]!)
                    NumErr?.append(arrErrLiv1Cod1.count)
                }
                if arrErrLiv1Cod2.count != 0 {
                    Errori?.append(TipiErrore.TipiErrore[2]!)
                    NumErr?.append(arrErrLiv1Cod2.count)
                }
              
                customizeChart(dataPoints: Errori!, values: NumErr!.map{ Double($0)})
            default: break
            }
        case 2:
            switch SelettoreFrequenza.selectedSegmentIndex{
            //grafico codici Livello2 settimanale
            case 0:
                
                let arrErrLiv2Cod0=PersistenceManager.fetchErroriInSettimana(codice: 0, livello: 2)
                let arrErrLiv2Cod1=PersistenceManager.fetchErroriInSettimana(codice: 1, livello: 2)
                let arrErrLiv2Cod2=PersistenceManager.fetchErroriInSettimana(codice: 2, livello: 2)
                var NumErr:Array<Int>?=[]
                var Errori : Array<String>?=[]
                if arrErrLiv2Cod0.count != 0 {
                    Errori?.append(TipiErrore.TipiErrore[0]!)
                    NumErr?.append(arrErrLiv2Cod0.count)
                }
                if arrErrLiv2Cod1.count != 0 {
                    Errori?.append(TipiErrore.TipiErrore[1]!)
                    NumErr?.append(arrErrLiv2Cod1.count)
                }
                if arrErrLiv2Cod2.count != 0 {
                    Errori?.append(TipiErrore.TipiErrore[2]!)
                    NumErr?.append(arrErrLiv2Cod2.count)
                }
            
                customizeChart(dataPoints: Errori!, values: NumErr!.map{ Double($0)})
            //grafico codici Livello2 mensile
            case 1:
                
                let arrErrLiv2Cod0=PersistenceManager.fetchErroriInMese(codice: 0, livello: 2)
                let arrErrLiv2Cod1=PersistenceManager.fetchErroriInMese(codice: 1, livello: 2)
                let arrErrLiv2Cod2=PersistenceManager.fetchErroriInMese(codice: 2, livello: 2)
                var NumErr:Array<Int>?=[]
                var Errori : Array<String>?=[]
                if arrErrLiv2Cod0.count != 0 {
                    Errori?.append(TipiErrore.TipiErrore[0]!)
                    NumErr?.append(arrErrLiv2Cod0.count)
                }
                if arrErrLiv2Cod1.count != 0 {
                    Errori?.append(TipiErrore.TipiErrore[1]!)
                    NumErr?.append(arrErrLiv2Cod1.count)
                }
                if arrErrLiv2Cod2.count != 0 {
                    Errori?.append(TipiErrore.TipiErrore[2]!)
                    NumErr?.append(arrErrLiv2Cod2.count)
                }
               
                customizeChart(dataPoints: Errori!, values: NumErr!.map{ Double($0)})
                
            default: break
            }
        case 3:
            switch SelettoreFrequenza.selectedSegmentIndex{
            //grafico codici Livello3 settimanale
            case 0:
                
                let arrErrLiv3Cod0=PersistenceManager.fetchErroriInSettimana(codice: 0, livello: 3)
                let arrErrLiv3Cod1=PersistenceManager.fetchErroriInSettimana(codice: 1, livello: 3)
                let arrErrLiv3Cod2=PersistenceManager.fetchErroriInSettimana(codice: 2, livello: 3)
                var NumErr:Array<Int>?=[]
                var Errori : Array<String>?=[]
                if arrErrLiv3Cod0.count != 0 {
                    Errori?.append(TipiErrore.TipiErrore[0]!)
                    NumErr?.append(arrErrLiv3Cod0.count)
                }
                if arrErrLiv3Cod1.count != 0 {
                    Errori?.append(TipiErrore.TipiErrore[1]!)
                    NumErr?.append(arrErrLiv3Cod1.count)
                }
                if arrErrLiv3Cod2.count != 0 {
                    Errori?.append(TipiErrore.TipiErrore[2]!)
                    NumErr?.append(arrErrLiv3Cod2.count)
                }
               
               
                customizeChart(dataPoints: Errori!, values: NumErr!.map{ Double($0)})
                
            //grafico codici Livello3 mensile
            case 1:
                
                let arrErrLiv3Cod0=PersistenceManager.fetchErroriInMese(codice: 0, livello: 3)
                let arrErrLiv3Cod1=PersistenceManager.fetchErroriInMese(codice: 1, livello: 3)
                let arrErrLiv3Cod2=PersistenceManager.fetchErroriInMese(codice: 2, livello: 3)
                var NumErr:Array<Int>?=[]
                var Errori : Array<String>?=[]
                if arrErrLiv3Cod0.count != 0 {
                    Errori?.append(TipiErrore.TipiErrore[0]!)
                    NumErr?.append(arrErrLiv3Cod0.count)
                }
                if arrErrLiv3Cod1.count != 0 {
                    Errori?.append(TipiErrore.TipiErrore[1]!)
                    NumErr?.append(arrErrLiv3Cod1.count)
                }
                if arrErrLiv3Cod2.count != 0 {
                    Errori?.append(TipiErrore.TipiErrore[2]!)
                    NumErr?.append(arrErrLiv3Cod2.count)
                }
                
                customizeChart(dataPoints: Errori!, values: NumErr!.map{ Double($0)})
            default: break
            }
        default: break
        }
    }
    //queasta funzione calcola il numero di occorrenze di errori nel livello iesimo per il grafico totale.
    func contaLivello(array: Array<DeepMind.Errori>)->Array<Int>{
        var ArrayLivello=Array<Int>()
        var j = 0
        for _ in [0...array.count]
        {
            let e = array[j]
            switch e.livello{
            case 1: ArrayLivello[0]=ArrayLivello[0]+1
            case 2: ArrayLivello[1]=ArrayLivello[1]+1
            case 3: ArrayLivello[2]=ArrayLivello[2]+1
            case 4: ArrayLivello[3]=ArrayLivello[3]+1
            default: ArrayLivello[4]=ArrayLivello[4]+1
            }
            j=j+1
        }
        return ArrayLivello
    }
    
    
    
    func customizeChart(dataPoints: [String], values: [Double]) {
        // 1. Set ChartDataEntry
        var dataEntries: [ChartDataEntry] = [] //setto un array di tipo ChartDataEntry
        for i in 0..<dataPoints.count { //in pratica i numeri da 0 a 5 perche 5 sono i calciatori
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)//carico il valore dataEntry con un elemento ottenuto dalla funzione PieChartDataENtry a cui passo il numero di occorenze, la label che sarebbe il calciatore i-esimo e il data che e ancora una volta il calciatore iesimo
            dataEntries.append(dataEntry)//aggiungo all'array di tipo ChartDataEntry il dato dataEntry ottenuto associando il dato al calciatore iesimo alla riga precedente.
            
            
            //a questo punto abbiamo un array DataEntries contenente i dati numerici riferiti ad ogni calciatore iesimo
        }
        // 2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)//dichiaro una variabile di tipo chartDataSet passandogli la entry calcolata al punto precedente
        pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count) //assegno il colore
        // 3. Set ChartData
        let pieChartData = PieChartData(dataSet: pieChartDataSet)//dichiaro il piechartData
        let format = NumberFormatter()//dichiaro ilformato
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)//dichiaro il formatter
        pieChartData.setValueFormatter(formatter) //do un formato ai pieChartData. Ricordiamo che alla riga 35 il PieChartData e stato costrutio partendo dal PieChartDataSet che a sua volta e stato costruito a partire dalla entries che associa il valore ad un calciatore
        // 4. Assign it to the chart’s data
        if pieChartData.dataSets.count != 0 {
            PieChartView.data = pieChartData //assegno ai data della view il pieChartData
        }
        
        PieChartView.setNeedsDisplay()
        
        PieChartView.noDataText = "Nessun dato disponibile"
        PieChartView.noDataTextColor = UIColor.black
        PieChartView.noDataFont = UIFont.boldSystemFont(ofSize: 20)
        PieChartView.drawHoleEnabled = false
        if dataEntries.isEmpty {
            PieChartView.clear()
        }
        //PieChartView.isHidden = false
        //imageView.image = PieChartView.asImage()
        //imageView.sizeToFit()
        
        //PieChartView.isHidden = true
    }
    
    func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
        var colors: [UIColor] = []
        for _ in 0..<numbersOfColor {
            var red : Double = 255
            var green : Double = 255
            var blue : Double = 255
            while ( red == 255 && green == 255 && blue == 255 ){
             red = Double(arc4random_uniform(230))
             green = Double(arc4random_uniform(230))
             blue = Double(arc4random_uniform(230))
            }
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        return colors
    }
    
}

extension UIView {

    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContext(self.frame.size)
            self.layer.render(in:UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return UIImage(cgImage: image!.cgImage!)
        }
    }
}
