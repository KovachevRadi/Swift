//
//  EraseViewController.swift
//  iOSApplicationNavigationAndLifecycle
//
//  Created by Radi on 8.01.23.
//

import UIKit

class StairsInShipkaViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var eraseSlider: UISlider!
    @IBOutlet weak var sliderValuelabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func eraseSliderSlided(_ sender: UISlider) {
        self.sliderValuelabel.text = "\(Int(eraseSlider.value))" //894 са стълбите
    }
    @IBAction func checkAnswerButtonTapped(_ sender: UIButton) {
        if let answerViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AnswerViewController") as? AnswerViewController {
            if self.sliderValuelabel.text != "\(894)" {
                answerViewController.answerValue = "incorrect"
            } else {
                answerViewController.answerValue = "You got it correct ッ"
            }
            self.navigationController?.pushViewController(answerViewController, animated: true)
        }
    }
}
