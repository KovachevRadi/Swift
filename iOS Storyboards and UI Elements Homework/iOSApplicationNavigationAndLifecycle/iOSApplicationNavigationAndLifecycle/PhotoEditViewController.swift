//
//  PhotoEditViewController.swift
//  iOSApplicationNavigationAndLifecycle
//
//  Created by Radi on 8.01.23.
//

import UIKit

class PhotoEditViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var switcher: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sliderSlided(_ sender: UISlider) {
        self.imageView.alpha = CGFloat(sender.value)
    }
    
    @IBAction func switchSwitched(_ sender: UISwitch) {
        self.imageView.isHidden = sender.isOn
    }
}
