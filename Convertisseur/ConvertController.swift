//
//  ConvertController.swift
//  Convertisseur
//
//  Created by Fabrice Etiennette on 23/05/2019.
//  Copyright © 2019 Fabrice Etiennette. All rights reserved.
//

import UIKit

class ConvertController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var entryView: UIView!
    @IBOutlet weak var toDoLabel: UILabel!
    @IBOutlet weak var dataTextField: UITextField!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var resultLabel: UILabel!
    
    var type: String?
    var views: [UIView] = []
    var isReverse = false
    let euros = "euros"
    let dollar = "dollars"
    let km = "kilomètre"
    let mi = "miles"
    let celsius = "celsius"
    let fahrenheit = "fahrenheit"
    let format = "%.2f"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let choix = type {
            views = [resultView, entryView]
            cornerR()
            typeChoisi(choix)
        } else {
            dismiss(animated: true, completion: nil)
        }
        resultLabel.text = "Le Resultat d'afficheras ici :)"
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard) )
        view.addGestureRecognizer(tap)
    }
    
    // FUNCTION
    
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    func typeChoisi(_ choix: String) {
        switch choix {
        case DEVISE: setup(euros, dollar)
        case DISTANCE: setup(km, mi)
        case TEMPERATURE: setup(celsius, fahrenheit)
        default: break
        }
    }
    
    func setup(_ primary: String, _ secondary: String) {
        if !isReverse{
            titleLabel.text = "Convertir " + primary + " en " + secondary
            toDoLabel.text = "Entrez le nombre de " + primary
        } else {
            titleLabel.text = "Convertir " + secondary + " en " + primary
            toDoLabel.text = "Entrez le nombre de " + secondary
        }
    }
    
    func cornerR() {
        for v in views {
            v.layer.cornerRadius = 10
        }
    }
    
    
    
    // lOGIQUE DU CALCUL
    
    func calculate() {
        if let monType = type, let texte = dataTextField.text, let double = Double(texte) {
            switch monType {
            case DEVISE: resultLabel.text = isReverse ? euros(double) : dollars(double)
            case TEMPERATURE: resultLabel.text = isReverse ? celsius(double) : fahrenheit(double)
            case DISTANCE: resultLabel.text = isReverse ? km(double) : mi(double)
            default: break
            }
        }
    }
    
    func dollars(_ euros: Double) -> String {
        return String(format: format, (euros / 0.90)) + " $"
    }
    
    func euros(_ dollars: Double) -> String {
        return String(format: format, (dollars * 0.90)) + " €"
    }
    
    func km(_ mi: Double) -> String {
        return String(format: format, (mi / 0.621)) + " km"
    }
    
    func mi(_ km: Double) -> String {
        return String(format: format, (km * 0.621)) + " Miles"
    }
    
    func celsius(_ fahrenheit: Double) -> String {
        return String(format: format, ((fahrenheit - 33.8) / 1.8)) + " °C"
    }
    
    func fahrenheit(_ celsius: Double) -> String {
        return String(format: format, ((celsius + 33.8) * 1.8)) + " °F"
    }
    
    //ACTION
    
    @IBAction func changeButton(_ sender: Any) {
        guard type != nil else { return }
        isReverse = !isReverse
        typeChoisi(type!)
        calculate()
    }
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func textChanged(_ sender: UITextField) {
        calculate()
    }
    

}
