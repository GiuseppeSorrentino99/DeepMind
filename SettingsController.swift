//
//  SettingsControllerTableViewController.swift
//  DeepMind
//
//  Created by Marco Venere on 13/04/21.
//

import UIKit
import MessageUI
import MailCore

class SettingsController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource, MFMailComposeViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    let imagePicker = UIImagePickerController()
    let defaults = UserDefaults.standard
    let reportFreqList = ["settimanale", "mensile", "bimestrale"]
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let tableView = view as? UITableViewHeaderFooterView else { return }
        tableView.textLabel?.textColor = UIColor(#colorLiteral(red: 0.772777617, green: 0.1035105959, blue: 0, alpha: 1))
        tableView.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        tableView.contentView.backgroundColor = UIColor(#colorLiteral(red: 1, green: 0.5884763598, blue: 0, alpha: 1))
        if section == 0 {
            tableView.textLabel?.text = "Profilo"
        } else {
            tableView.textLabel?.text = "Report"
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return reportFreqList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return reportFreqList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //gestire la selezione della riga
        defaults.set(row, forKey: "Report_Freq")
    }
    
    @IBOutlet weak var reportSwitch: UISwitch!
    @IBOutlet weak var cognome: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var reportFreqPicker: UIPickerView!
    @IBOutlet weak var nome: UITextField!
    @IBOutlet weak var reportFreqLabel: UILabel!
    @IBAction func reportChange(_ sender: UISwitch) {
        reportFreqLabel.isEnabled = sender.isOn
        numErroriLabel.isEnabled = sender.isOn
        numSuccessiLabel.isEnabled = sender.isOn
        numMedioErroriLabel.isEnabled = sender.isOn
        tempoMedioLabel.isEnabled = sender.isOn
        numAccessiSwitch.isEnabled = sender.isOn
        numErroriSwitch.isEnabled = sender.isOn
        numSuccessiSwitch.isEnabled = sender.isOn
        tempoMedioSwitch.isEnabled = sender.isOn
        reportFreqPicker.isUserInteractionEnabled = sender.isOn
        if sender.isOn {
            reportFreqPicker.alpha = 1.0
        } else {
            reportFreqPicker.alpha = 0.6
        }
        defaults.set(sender.isOn, forKey: "Report_InviaReport")
    }
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        defaults.set(sender.date, forKey: "Utente_DataNascita")
    }
    @IBAction func referenteChanged(_ sender: UITextField) {
        defaults.set(sender.text, forKey: "Utente_Referente")
    }
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var referente: UITextField!
    @IBOutlet weak var numSuccessiSwitch: UISwitch!
    @IBOutlet weak var tempoMedioSwitch: UISwitch!
    @IBOutlet weak var numMedioErroriLabel: UILabel!
    @IBOutlet weak var tempoMedioLabel: UILabel!
    @IBOutlet weak var numAccessiSwitch: UISwitch!
    @IBAction func tempoMedioChanged(_ sender: UISwitch) {
        defaults.set(sender.isOn, forKey: "Report_TempoMedio")
    }
    @IBAction func numAccessiChanged(_ sender: UISwitch) {
        defaults.set(sender.isOn, forKey: "Report_NumAccessi")
    }
    @IBOutlet weak var numErroriSwitch: UISwitch!
    @IBAction func numSuccessiChanged(_ sender: UISwitch) {
        defaults.set(sender.isOn, forKey: "Report_NumSuccessi")
    }
    @IBAction func numErroriChanged(_ sender: UISwitch) {
        defaults.set(sender.isOn, forKey: "Report_NumErrori")
    }
    @IBOutlet weak var numSuccessiLabel: UILabel!
    @IBOutlet weak var numErroriLabel: UILabel!
    @IBAction func nomeChanged(_ sender: UITextField) {
        defaults.set(sender.text, forKey: "Utente_Nome")
    }
    @IBAction func cognomeChanged(_ sender: UITextField) {
        defaults.set(sender.text, forKey: "Utente_Cognome")
    }
    @IBAction func emailChanged(_ sender: UITextField) {
        defaults.set(sender.text, forKey: "Utente_Email")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        imageView.image = image
        let imagePNG = image.pngData()
        defaults.set(imagePNG, forKey: "Utente_Foto")
    }
    @IBAction func loadCameraButtonTapped(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .camera
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func loadImageButtonTapped(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
            
            present(imagePicker, animated: true, completion: nil)
        }
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        reportFreqPicker.delegate = self
        reportFreqPicker.dataSource = self
        tableView.tableFooterView = UIView()
        nome.text = defaults.string(forKey: "Utente_Nome")
        cognome.text = defaults.string(forKey: "Utente_Cognome")
        email.text = defaults.string(forKey: "Utente_Email")
        referente.text = defaults.string(forKey: "Utente_Referente")
        reportSwitch.isOn = defaults.bool(forKey: "Report_InviaReport")
        numAccessiSwitch.isOn = defaults.bool(forKey: "Report_NumAccessi")
        numSuccessiSwitch.isOn = defaults.bool(forKey: "Report_NumSuccessi")
        numErroriSwitch.isOn = defaults.bool(forKey: "Report_NumErrori")
        tempoMedioSwitch.isOn = defaults.bool(forKey: "Report_TempoMedio")
        let image = defaults.object(forKey: "Utente_Foto") as? Data
        if image != nil {
            imageView.image = UIImage(data:  image!)
        }
        let date = defaults.object(forKey: "Utente_DataNascita") as? Date
        if date != nil {
            datePicker.date = date!
            
        }
        reportFreqPicker.selectRow(defaults.integer(forKey: "Report_Freq"), inComponent: 0, animated: true)
        reportFreqLabel.isEnabled = reportSwitch.isOn
        numErroriLabel.isEnabled = reportSwitch.isOn
        numSuccessiLabel.isEnabled = reportSwitch.isOn
        numMedioErroriLabel.isEnabled = reportSwitch.isOn
        tempoMedioLabel.isEnabled = reportSwitch.isOn
        numAccessiSwitch.isEnabled = reportSwitch.isOn
        numErroriSwitch.isEnabled = reportSwitch.isOn
        numSuccessiSwitch.isEnabled = reportSwitch.isOn
        tempoMedioSwitch.isEnabled = reportSwitch.isOn
        reportFreqPicker.isUserInteractionEnabled = reportSwitch.isOn
        if reportSwitch.isOn {
            reportFreqPicker.alpha = 1.0
        } else {
            reportFreqPicker.alpha = 0.6
        }
        
        
        //        sendEmail()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    @IBAction func inviaMail(_ sender: Any) {
        //emailWithGoogle()
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["m.venere@studenti.unisa.it", "g.sorrentino85@studenti.unisa.it", "s.salzano9@studenti.unisa.it"])
            mail.setMessageBody("<p>Deep Mind!<br>Mail di prova</p>", isHTML: true)
            present(mail, animated: true)
        } else {
            // show failure alert
            print("Errore nell'invio mail")
        }
    }
}
