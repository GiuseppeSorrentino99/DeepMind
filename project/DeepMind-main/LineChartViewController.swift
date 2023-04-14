//
//  LineChartViewController.swift
//  DeepMind
//
//  Created by Giuseppe Sorrentino on 12/06/21.
//

import UIKit
import Charts


class LineChartViewController: UIViewController {
    var tot=Array<Int>()
    var totAnno=Array<Int>()

    var greenPerfect = Array<String>()
    var greenPerfectAnno = Array<String>()
    
    var MFormat:MonthNameFormatter! = nil
    var DFormat:DayFormatter! = nil
    
    var arrErrFiltrato = Array<Double>()
    var arrErrFiltratoAnno = Array<Double>()
    
    var arrErr = PersistenceManager.fetchErrori()
    var arrErrAnno = PersistenceManager.fetchErrori()
    
    var Day=Array<String>()
    var Month=Array<String>()
    
    var arrayDiDate=Array<Date?>()
    var arrayDiDateAnno=Array<Date?>()
    
    var arrayDiLabels=Array<DateComponents>()
    var arrayDiLabelsAnno=Array<DateComponents>()
    
    @IBOutlet weak var MonthView: LineChartView!
    @IBOutlet weak var YearView: LineChartView!
    @IBOutlet weak var SelettoreFrequenza: UISegmentedControl!
    
    var lineDataEntry:[ChartDataEntry]=[]
    
    let months = ["Gennaio", "Febbraio", "Marzo", "Aprile", "Maggio", "Giugno","Luglio","Agosto","Settembre","Ottobre","Novembre","Dicembre"]
    
    final class MonthNameFormatter: NSObject, IAxisValueFormatter {
        func stringForValue( _ value: Double, axis _: AxisBase?) -> String {
            
            let mese = Calendar.current.dateComponents([.month], from: Date())
            var cal = Calendar.current
            cal.locale = Locale(identifier: "it_IT")
            return cal.shortMonthSymbols[(Int(value)+mese.month!)%12]
       
        }
    }
    final class DayFormatter: NSObject, IAxisValueFormatter {
        func stringForValue( _ value: Double, axis _: AxisBase?) -> String {
            var z=30
            var Day=Array<String>()
            var arrayDiDate=Array<Date?>()
            var arrayDiLabels=Array<DateComponents>()
            for _ in 0...30{
                arrayDiDate.append(Calendar.current.date(byAdding: .day, value: -z, to: PersistenceManager.getDate()))
                z-=1
            }
            for h in 0...30{
                arrayDiLabels.append(Calendar.current.dateComponents([.day,.month,.year], from: arrayDiDate[h]!))
            }
            for i in 0...30{
                Day.append("\(arrayDiLabels[i].day!)")
            }
            return Day[Int(value) % Day.count]
            
        }
    }
    @IBAction func FreqSelect(_ sender: Any) {
        stampa()
    }
    
    
    @IBOutlet weak var LineChartView: LineChartView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MFormat=MonthNameFormatter()
        DFormat=DayFormatter()
        YearView.xAxis.valueFormatter = MFormat
        YearView.xAxis.labelRotationAngle = 45
        YearView.xAxis.granularity=1
        YearView.xAxis.labelCount=12
        
        
        MonthView.xAxis.valueFormatter = DFormat
        MonthView.xAxis.labelRotationAngle = 0
        MonthView.xAxis.granularity=1
        MonthView.xAxis.labelCount=30
        MonthView.zoomToCenter(scaleX: 4, scaleY: 1)
        stampa()
    }
    
    
    func stampa()->(){
       
        
        switch SelettoreFrequenza.selectedSegmentIndex{
        case 0:
            
            var z=30
            arrayDiDate.removeAll()
            arrayDiLabels.removeAll()
            Day.removeAll()
            arrErr.removeAll()
            arrErr=PersistenceManager.fetchErrori()
            arrErrFiltrato.removeAll()
            arrErrFiltrato = filtroMonth(array: arrErr)
            for _ in 0...30{
                // in posizione 0 ci sta la data di 30 giorni fa ,in posizione 30 la data di oggi
                arrayDiDate.append(Calendar.current.date(byAdding: .day, value: -z, to: PersistenceManager.getDate()))
                z-=1
            }
            for h in 0...30{
                arrayDiLabels.append(Calendar.current.dateComponents([.day,.month,.year], from: arrayDiDate[h]!))
            }
            for i in 0...30{
                Day.append("\(arrayDiLabels[i].day!)")
            }
            setLineChartMonth(dataPoints: Day, values: arrErrFiltrato)
            
        case 1:
            
            var z=11
            arrayDiDateAnno.removeAll()
            arrayDiLabelsAnno.removeAll()
            Month.removeAll()
            arrErrAnno.removeAll()
            arrErrAnno=PersistenceManager.fetchErrori()
            arrErrFiltratoAnno.removeAll()
            arrErrFiltratoAnno = filtroYear(array: arrErrAnno)
            
            
            for _ in 0...11{
                arrayDiDateAnno.append(Calendar.current.date(byAdding: .month, value: -z, to: Date()))
                z-=1
            }
            
            for h in 0...11{
                arrayDiLabelsAnno.append(Calendar.current.dateComponents([.day,.month,.year], from: arrayDiDateAnno[h]!))
            }
            
            for i in 0...11{
                Month.append("\(arrayDiLabelsAnno[i].month!)")
            }
            
            setLineChartYear(dataPoints: Month, values: arrErrFiltratoAnno)
        default: break
        }
    }
    
    
    func setLineChartMonth(dataPoints: [String],values: [Double]){
        YearView.isHidden=true
        MonthView.isHidden=false
        lineDataEntry.removeAll()
        for i in 0..<dataPoints.count {
            let dataPoint = ChartDataEntry(x: Double(i),y: values[i])
            lineDataEntry.append(dataPoint)
        }
        let chartDataSet = LineChartDataSet(entries: lineDataEntry, label: "NumeroErrori/NumeroTentativi")
        let chartData = LineChartData()
        chartData.addDataSet(chartDataSet)
        chartData.setDrawValues(true)
        chartDataSet.circleColors.removeAll()
        for i in 0..<dataPoints.count {
            
            if greenPerfect.contains(dataPoints[i]){
                chartDataSet.circleColors.append(UIColor.green)
            }else{
                chartDataSet.circleColors.append(UIColor.red)
            }
        }

        MonthView.data=chartData
        
    }
    func setLineChartYear(dataPoints: [String],values: [Double]){
        MonthView.isHidden=true
        YearView.isHidden=false
        lineDataEntry.removeAll()
        for i in 0..<dataPoints.count {
            let dataPoint = ChartDataEntry(x: Double(i),y: values[i])
            lineDataEntry.append(dataPoint)
        }
        let chartDataSetAnno = LineChartDataSet(entries: lineDataEntry, label: "NumeroErrori/NumeroTentativi")
    
        let chartDataAnno = LineChartData()
        chartDataAnno.addDataSet(chartDataSetAnno)
        chartDataAnno.setDrawValues(true)
        chartDataSetAnno.circleColors.removeAll()

        for i in 0..<dataPoints.count {
            
            if greenPerfectAnno.contains(dataPoints[i]){
                chartDataSetAnno.circleColors.append(UIColor.green)
            }else{
                chartDataSetAnno.circleColors.append(UIColor.red)
            }
        }
        YearView.data=chartDataAnno
    }

    func filtroMonth(array: Array<DeepMind.Errori>)->(Array<Double>){
        var arrDouble = Array<Double>()
        var green = true
        var atLeastOne = false
        tot.removeAll()
        for _ in 0...30{
            tot.append(0)
        }
        greenPerfect.removeAll()
        
        for _ in 0...30 {
            arrDouble.append(0)
        }
                var z=30
                var arrayDiDate=Array<Date?>()
                var arrayDiLabels=Array<DateComponents>()
                for h in 0...30{
                    // in posizione 0 ci sta la data di 30 giorni fa ,in posizione 30 la data di oggi
                    let data = Calendar.current.date(byAdding: .day, value: -z, to: PersistenceManager.getDate())
                    let dataDaVerificare = Calendar.current.dateComponents([.day,.month,.year], from: data!)
                    let mySucc = PersistenceManager.fetchSuccessi()
                    let mydata=NSCalendar.current.date(from: dataDaVerificare)
                    let arrayAccessi = PersistenceManager.fetchAccessi(inGiorno: mydata!)
                    for y in 0..<arrayAccessi.count{
                        tot[h] += arrayAccessi[y].tentativiInSessione!.count
                    }
                    if arrayAccessi.count != 0 {
                        for i in 0..<arrayAccessi.count{
                            if arrayAccessi[i].erroriInSessione!.count != 0{
                                green = false
                                break
                            }
                            if  arrayAccessi[i].tentativiInSessione!.count != 0{
                                for x in arrayAccessi[i].tentativiInSessione!{
                                    if mySucc.contains(x as! Tentativi){
                                        atLeastOne = true
                                        break
                                    }
                                }
                                
                            }
                        }
                    }
                    else{
                        green = false
                    }
                    arrayDiDate.append(data)
                    z-=1
                    if green == true && atLeastOne == true{
                        greenPerfect.append(String(dataDaVerificare.day!))
                    }
                    atLeastOne = false
                    green = true
                }
                for h in 0...30{
                    arrayDiLabels.append(Calendar.current.dateComponents([.day,.month,.year], from: arrayDiDate[h]!))
                }
                var dataDaConfrontare = Calendar.current.dateComponents([.day,.month,.year], from: Date())
                //questo ciclo controlla ogni elemento del core data, ne prende la data e la confronta con l'array di date
                for i in (0..<array.count)
                {
                    dataDaConfrontare = Calendar.current.dateComponents([.day,.month,.year], from: (array[i].sessione?.data)!)
                    //questo ciclo controlla la jesima label con l'array di label
                    for j in (0..<arrayDiLabels.count){
                        if dataDaConfrontare==arrayDiLabels[j]{
                            arrDouble[j]+=1
                            break
                        }
                    }
                
                }
                //devo calcolare il numero di tentativi
                    for i in 0...30{
                        if tot[i] == 0 {
                            arrDouble[i]=0
                        }else{
                            
                            arrDouble[i]=arrDouble[i]/Double(tot[i])
                        
                    }
                    
                }
        
                return arrDouble
    }
    
    func filtroYear(array: Array<DeepMind.Errori>)->(Array<Double>){
        var arrDoubleAnno = Array<Double>()
        var green = true
        var atLeastOne = false
        totAnno.removeAll()
        for _ in 0...11{
            totAnno.append(0)
        }
        greenPerfectAnno.removeAll()
        for _ in 0...11 {
            arrDoubleAnno.append(0)
        }
                var z=11
                var arrayDiDateAnno=Array<Date?>()
                var arrayDiLabelsAnno=Array<DateComponents>()
        
                for h in 0...11{
                    let data = Calendar.current.date(byAdding: .month, value: -z, to: PersistenceManager.getDate())
                    let dataDaVerificare = Calendar.current.dateComponents([.day,.month,.year], from: data!)
                    let mySucc = PersistenceManager.fetchSuccessi()
                    let mydata=NSCalendar.current.date(from: dataDaVerificare)
                    let arrayAccessi = PersistenceManager.fetchAccessi(inMese: mydata!)
                    for y in 0..<arrayAccessi.count{
                        totAnno[h] += arrayAccessi[y].tentativiInSessione!.count
                    }
                    if arrayAccessi.count != 0 {
                        for i in 0..<arrayAccessi.count{
                            if arrayAccessi[i].erroriInSessione!.count != 0 {
                                green = false
                                break
                            }
                            if  arrayAccessi[i].tentativiInSessione!.count != 0{
                                for x in arrayAccessi[i].tentativiInSessione!{
                                    if mySucc.contains(x as! Tentativi){
                                        atLeastOne = true
                                        break
                                    }
                                }
                                
                            }

                        }
                    }
                    else{
                        green = false
                    }
                    arrayDiDateAnno.append(data)
                    z-=1
                    if green == true && atLeastOne == true{
                        greenPerfect.append(String(dataDaVerificare.day!))
                    }
                    atLeastOne = false
                    green = true
                }
        
        
        
        
                for h in 0...11{
                    arrayDiLabelsAnno.append(Calendar.current.dateComponents([.day,.month,.year], from: arrayDiDateAnno[h]!))
                    
                }
                var dataDaConfrontare = Calendar.current.dateComponents([.day,.month,.year], from: Date())
                //questo ciclo controlla ogni elemento del core data, ne prende la data e la confronta con l'array di date
                for i in (0..<array.count)
                {
                    dataDaConfrontare = Calendar.current.dateComponents([.day,.month,.year], from: (array[i].sessione?.data)!)

                    //questo ciclo controlla la jesima label con l'array di label
                    for j in (0..<arrayDiLabelsAnno.count){
                        
                        if  dataDaConfrontare.month == arrayDiLabelsAnno[j].month && dataDaConfrontare.year == arrayDiLabelsAnno[j].year {
                            arrDoubleAnno[j]+=1
                            break
                        }
                    }
                }
        for i in 0...11{
            if totAnno[i] == 0 {
                arrDoubleAnno[i]=0
            }else{
                
                arrDoubleAnno[i]=arrDoubleAnno[i]/Double(totAnno[i])
            
        }
        
    }
                return arrDoubleAnno
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
