//
//  PopUpController.swift
//  DiceeGCSF
//
//  Created by Ta Huy Hung on 4/23/20.
//  Copyright © 2020 ClassiOS. All rights reserved.
//

import Foundation
import UIKit

protocol DiceDelegate {
    func onMoneyReceived(_ money : String)
}

class PopUpController: UIViewController {
    var delegate : DiceDelegate?
    
    @IBOutlet weak var tfMoneyBet: UITextField!
    
    @IBAction func onDone(_ sender: Any) {
        self.delegate?.onMoneyReceived(tfMoneyBet.text!)
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        addDoneButton(to: tfMoneyBet)
    }
    
}
