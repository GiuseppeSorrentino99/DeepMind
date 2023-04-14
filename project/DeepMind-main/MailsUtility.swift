//
//  MailsUtility.swift
//  DeepMind
//
//  Created by Marco Venere on 17/06/21.
//

import Foundation

func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
  return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
}

func stringSecondsToHoursMinutesSeconds (seconds:Int) -> String {
    let (h, m, s) = secondsToHoursMinutesSeconds(seconds: seconds)
    return "\(h) ore, \(m) minuti, \(s) secondi"
}

func sumTime(tentativi : [Tentativi]) -> String {
    var sommaTempi = 0.0
    for tentativo in tentativi {
        sommaTempi += Double(tentativo.tempoTentativo ?? "0") ?? 0.0
    }
    return stringSecondsToHoursMinutesSeconds (seconds: Int(sommaTempi))
}

func averageTime(tentativi : [Tentativi]) -> String {
    var sommaTempi = 0.0
    for tentativo in tentativi {
        sommaTempi += Double(tentativo.tempoTentativo ?? "0") ?? 0.0
    }
    if tentativi.count == 0 {
        return "0"
    }
    return stringSecondsToHoursMinutesSeconds (seconds: Int(sommaTempi/Double(tentativi.count)))
}

func averageTime(accessi : [Accessi]) -> String {
    var sommaTempi = 0.0
    for accesso in accessi {
        sommaTempi += Double(accesso.tempoSessione ?? "0") ?? 0.0
    }
    if accessi.count == 0 {
        return "0"
    }
    return stringSecondsToHoursMinutesSeconds (seconds: Int(sommaTempi/Double(accessi.count)))
}



func createEmail() -> String {
    
    var accessiTot = PersistenceManager.fetchAccessi()
    var defaults = UserDefaults.standard
    var count = defaults.integer(forKey: "Report_Count")
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.hour, .minute, .second]
    formatter.unitsStyle = .full

    var emailContent : String = """
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<HTML>
<HEAD>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<TITLE>pdf-html</TITLE>
<META name="generator" content="BCL easyConverter SDK 5.0.252">
<STYLE type="text/css">

body {margin-top: 0px;margin-left: 0px;}

#page_1 {position:relative; overflow: hidden;margin: 99px 0px 100px 76px;padding: 0px;border: none;width: 718px;}

#page_1 #p1dimg1 {position:absolute;top:132px;left:0px;z-index:-1;width:593px;height:800px;}
#page_1 #p1dimg1 #p1img1 {width: 169px;height: 180px;}




.ft0{font: 32px 'Calibri Light';line-height: 37px;}
.ft1{font: 21px 'Calibri Light';line-height: 25px;}
.ft2{font: 16px 'Calibri';line-height: 19px;}
.ft3{font: italic 12px 'Calibri';color: #44546a;line-height: 14px;}

.p0{text-align: left;padding-left: 199px;margin-top: 0px;margin-bottom: 0px;}
.p1{text-align: left;padding-left: 253px;margin-top: 2px;margin-bottom: 0px;}
.p2{text-align: left;margin-top: 40px;margin-bottom: 0px;}
.p3{text-align: left;margin-top: 1px;margin-bottom: 0px;}
.p4{text-align: left;margin-top: 0px;margin-bottom: 0px;}
.p5{text-align: left;margin-top: 20px;margin-bottom: 0px;}
.p6{text-align: left;margin-top: 27px;margin-bottom: 0px;}
.p7{text-align: left;margin-top: 174px;margin-bottom: 0px;}
.p8{text-align: left;padding-right: 80px;margin-top: 15px;margin-bottom: 0px;}
.p9{text-align: left;padding-right: 81px;margin-top: 1px;margin-bottom: 0px;}




</STYLE>
</HEAD>

<BODY>
<DIV id="page_1">
<DIV id="p1dimg1">

<P class="p0 ft0">Report informativo</P>
<P class="p1 ft0">DeepMind</P>

    <div style="display:inline-block; vertical-align:top">
<IMG src="cid:123456" style="margin-top: 60px; margin-left: 150px" id="p1img1"></DIV>
<DIV style="display:inline-block; float: left">
<P class="p2 ft1">Utente:
"""
    if let nome = defaults.string(forKey: "Utente_Nome") {
        emailContent += " " + nome
    } else {
        emailContent += " Nome sconosciuto"
    }
    if let cognome = defaults.string(forKey: "Utente_Cognome") {
        emailContent += " " + cognome
    } else {
        emailContent += " Cognome sconosciuto"
    }
    
    let dataReport = Date()
    let dataReport1 = Calendar.current.dateComponents([.year, .month, .day], from: dataReport)
    if let dataNascita = defaults.object(forKey: "Utente_DataNascita") as? Date {
        
        let dataNascita1 = Calendar.current.dateComponents([.year, .month, .day], from: dataNascita)
        
        
        emailContent += """
</P>
<P class="p3 ft2">Data di nascita:
""" + " " + String(dataNascita1.day!) + "/" + String(dataNascita1.month!) + "/" + String(dataNascita1.year!);
        emailContent += """
</P>
<P class="p3 ft2">Età:
""" + " " + String(Calendar.current.dateComponents([.year], from: Calendar.current.date(byAdding: .year, value: -Calendar.current.dateComponents([.year], from: dataNascita).year!, to: dataReport)!).year!)
        emailContent += "</p>"
    }
    emailContent += """
        <P class="p5 ft2">Frequenza:
        """
    let freq = defaults.integer(forKey: "Report_Freq")
    switch(freq) {
    case 0:
        emailContent += " settimanale"
    case 1:
        emailContent += " mensile"
    case 2:
        emailContent += " bimestrale"
    default:
        break
    }
    emailContent += """
</P>
<P class="p3 ft2">Referente:
"""
    if let referente = defaults.string(forKey: "Utente_Referente") {
        emailContent += " " + referente
    } else {
        emailContent += " Non specificato"
    }
    emailContent += """
</P>

</DIV>
<P class="p5 ft1">Report #
""" + String(count + 1)
    emailContent +=
        """
</P>
<P class="p3 ft2">Data di generazione report:

""" + " " + String(dataReport1.day!) + "/" + String(dataReport1.month!) + "/"
    emailContent +=
        String(dataReport1.year!);
var dataPresent = false
    switch(defaults.integer(forKey: "Report_Freq")) {
    case 0:
        dataPresent = PersistenceManager.fetchTentativiInSettimana().count != 0
    case 1:
        dataPresent = PersistenceManager.fetchTentativiInMese().count != 0
    case 2:
        dataPresent = PersistenceManager.fetchTentativiIn2Mesi().count != 0
    default:
        break
    }
if dataPresent {
    if defaults.bool(forKey: "Report_NumAccessi") {
        emailContent += """
            </P>
            <P class="p6 ft2">Numero di accessi effettuati:
            """
        switch(freq) {
        case 0:
            emailContent += " " + String(PersistenceManager.fetchAccessiInSettimana().count)
        case 1:
            emailContent += " " + String(PersistenceManager.fetchAccessiInMese().count)
        case 2:
            emailContent += " " + String(PersistenceManager.fetchAccessiIn2Mesi().count)
        default:
            break
        }
    }
    emailContent += """
</P>
"""
    if defaults.bool(forKey: "Report_NumSuccessi") {
        emailContent += """
<P class="p4 ft2">Percentuale di successi:
"""
        
        switch(freq) {
        case 0:
            emailContent += " " + String(format: "%0.2f", Double(PersistenceManager.fetchNumeroSuccessiInSettimana()) / Double(PersistenceManager.fetchTentativiInSettimana().count) * 100)
        case 1:
            emailContent += " " + String(format: "%0.2f",
                                         Double(PersistenceManager.fetchNumeroSuccessiInMese()) / Double(PersistenceManager.fetchTentativiInMese().count) * 100)
        case 2:
            emailContent += " " + String(format: "%0.2f",
                                         Double(PersistenceManager.fetchNumeroSuccessiIn2Mesi()) / Double(PersistenceManager.fetchTentativiIn2Mesi().count) * 100)
        default:
            break
        }
        emailContent += "%"
    }
    emailContent += """
</P>
"""
    if defaults.bool(forKey: "Report_NumErrori") {
        
        emailContent += """
    <P class="p3 ft2">Numero errori generici:
    """
        
        switch(freq) {
        case 0:
            emailContent += " " + String(PersistenceManager.fetchErroriInSettimana(codice: 0, livello: -1).count)
        case 1:
            emailContent += " " + String(PersistenceManager.fetchErroriInMese(codice: 0, livello: -1).count)
        case 2:
            emailContent += " " + String(PersistenceManager.fetchErroriIn2Mesi(codice: 0, livello: -1).count)
        default:
            break
        }
            emailContent += "</P>"
            
            emailContent += """
    <P class="p3 ft2">Numero errori lievi:
    """
            
        switch(freq) {
        case 0:
            emailContent += " " + String(PersistenceManager.fetchErroriInSettimana(codice: 1, livello: -1).count)
        case 1:
            emailContent += " " + String(PersistenceManager.fetchErroriInMese(codice: 1, livello: -1).count)
        case 2:
            emailContent += " " + String(PersistenceManager.fetchErroriIn2Mesi(codice: 1, livello: -1).count)
        default:
            break
        }
            
            emailContent += "</P>"
            
            emailContent += """
    <P class="p3 ft2">Numero errori gravi:
    """
            
        switch(freq) {
        case 0:
            emailContent += " " + String(PersistenceManager.fetchErroriInSettimana(codice: 2, livello: -1).count)
        case 1:
            emailContent += " " + String(PersistenceManager.fetchErroriInMese(codice: 2, livello: -1).count)
        case 2:
            emailContent += " " + String(PersistenceManager.fetchErroriIn2Mesi(codice: 0, livello: -1).count)
        default:
            break
        }
            emailContent += "</P>"
        }
        if defaults.bool(forKey: "Report_TempoMedio") {
            emailContent += """
<P class="p4 ft2">Tempo medio per livello 1:
"""
            switch(freq) {
            case 0:
                var tentativi = PersistenceManager.fetchTentativiInSettimana().filter({$0.livello == 1})
                emailContent += " " + averageTime(tentativi: tentativi)
                    
            case 1:
                var tentativi = PersistenceManager.fetchTentativiInMese().filter({$0.livello == 1})
                emailContent += " " + averageTime(tentativi: tentativi)
            case 2:
                var tentativi = PersistenceManager.fetchTentativiIn2Mesi().filter({$0.livello == 1})
                emailContent += " " + averageTime(tentativi: tentativi)
            default:
                break
            }
            emailContent += "</P>"
emailContent += """
<P class="p4 ft2">Tempo medio per livello 2:
"""
switch(freq) {
case 0:
    var tentativi = PersistenceManager.fetchTentativiInSettimana().filter({$0.livello == 2})
    emailContent += " " + averageTime(tentativi: tentativi)
        
case 1:
    var tentativi = PersistenceManager.fetchTentativiInMese().filter({$0.livello == 2})
    emailContent += " " + averageTime(tentativi: tentativi)
case 2:
    var tentativi = PersistenceManager.fetchTentativiIn2Mesi().filter({$0.livello == 2})
    emailContent += " " + averageTime(tentativi: tentativi)
default:
    break
}
emailContent += "</P>"
emailContent += """
<P class="p4 ft2">Tempo medio per livello 3:
"""
switch(freq) {
case 0:
    var tentativi = PersistenceManager.fetchTentativiInSettimana().filter({$0.livello == 3})
    emailContent += " " + averageTime(tentativi: tentativi)
        
case 1:
    var tentativi = PersistenceManager.fetchTentativiInMese().filter({$0.livello == 3})
    emailContent += " " + averageTime(tentativi: tentativi)
case 2:
    var tentativi = PersistenceManager.fetchTentativiIn2Mesi().filter({$0.livello == 3})
    emailContent += " " + averageTime(tentativi: tentativi)
default:
    break
}
emailContent += """
</P>
<P class="p3 ft2">Tempo medio di utilizzo:
"""
            switch(freq) {
            case 0:
                var accessi = PersistenceManager.fetchAccessiInSettimana()
                emailContent += " " + averageTime(accessi: accessi)
                    
            case 1:
                var accessi = PersistenceManager.fetchAccessiInMese()
                emailContent += " " + averageTime(accessi: accessi)
            case 2:
                var accessi = PersistenceManager.fetchAccessiIn2Mesi()
                emailContent += " " + averageTime(accessi: accessi)
            default:
                break
            }
            emailContent += "</P>"
        }
        emailContent += """
<P class="p4 ft2">Tempo totale trascorso:
"""
            switch(freq) {
            case 0:
                var tentativi = PersistenceManager.fetchTentativiInSettimana()
                emailContent += " " + sumTime(tentativi: tentativi)
                    
            case 1:
                var tentativi = PersistenceManager.fetchTentativiInMese()
                emailContent += " " + sumTime(tentativi: tentativi)
            case 2:
                var tentativi = PersistenceManager.fetchTentativiIn2Mesi()
                emailContent += " " + sumTime(tentativi: tentativi)
            default:
                break
            }
emailContent += "</P>"

} else {
    """
    <P class "ft2">L'applicazione non è stata utilizzata. </P>
    """
}
"""
<!-- <P class="p7 ft3">Figura 1. Questo grafico mostra il numero di errori per livello.</P>
<P class="p8 ft2">L’utente dimostra [di riuscire a raggiungere gli obiettivi preposti | di riscontrare difficoltà in alcune tipologie di errori | di non essere in grado di raggiungere gli obiettivi preposti].</P>
<P class="p9 ft2">Per quanto riguarda il livello [1 | 2 | 3] (oppure senza specificare il livello), il numero di errori individuato è [eccessivamente alto e potrebbe suggerire un peggioramento dello stato clinico del paziente | tendenzialmente costante all’andamento dell’utente e non evidenzia sintomi di aggravamento della patologia | ridotto e suggerisce un miglioramento delle condizioni cliniche del paziente].</P>
-->
</DIV>
</BODY>
</HTML>

"""
        return emailContent
    }
