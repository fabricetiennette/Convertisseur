//
//  ViewController.swift
//  Convertisseur
//
//  Created by Fabrice Etiennette on 23/05/2019.
//  Copyright © 2019 Fabrice Etiennette. All rights reserved.
//

import UIKit

let DEVISE = "Devises"
let TEMPERATURE = "Température"
let DISTANCE = "Distance"

class ViewController: UIViewController {
    
    @IBOutlet weak var deviseView: UIView!
    @IBOutlet weak var distanceView: UIView!
    @IBOutlet weak var temperatureView: UIView!
    
    let segueID = "Convert"
    
    var views: [UIView] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        views = [deviseView,distanceView,temperatureView]
        cornerRadiu()
    }
    
    func cornerRadiu(){
        for v in views {
            v.layer.cornerRadius = 10
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueID {
            if let convertController = segue.destination as? ConvertController {
                convertController.type = sender as? String
            }
        }
    }
    
    
    @IBAction func buttonAction(_ sender: UIButton) {
        switch sender.tag {
        case 0: performSegue(withIdentifier: segueID, sender: DEVISE)
        case 1: performSegue(withIdentifier: segueID, sender: DISTANCE)
        case 2: performSegue(withIdentifier: segueID, sender: TEMPERATURE)
        default: break
        }
    }

}

