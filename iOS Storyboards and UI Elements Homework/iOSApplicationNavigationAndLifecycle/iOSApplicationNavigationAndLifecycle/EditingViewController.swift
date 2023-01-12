//
//  EditingViewController.swift
//  iOSApplicationNavigationAndLifecycle
//
//  Created by Radi on 8.01.23.
//

import UIKit

class EditingViewController: UIViewController {
    
    @IBOutlet weak var textTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func clearTextButtonTapped(_ sender: UIButton) {
        textTextField.text = nil
    }
}
