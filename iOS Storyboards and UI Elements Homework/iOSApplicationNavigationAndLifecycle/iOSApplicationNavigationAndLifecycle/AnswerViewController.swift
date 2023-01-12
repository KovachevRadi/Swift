//
//  AnswerViewController.swift
//  iOSApplicationNavigationAndLifecycle
//
//  Created by Radi on 8.01.23.
//

import UIKit

class AnswerViewController: UIViewController {

    @IBOutlet weak var answerLabel: UILabel!
    
    var answerValue = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.answerLabel.text = answerValue
    }
}
