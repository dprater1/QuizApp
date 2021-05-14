//
//  QuizTakerViewController.swift
//  proj2
//
//  Created by admin on 5/14/21.
//

import UIKit

class QuizTakerViewController: UIViewController {

    @IBOutlet weak var answer1: UILabel!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var answer2: UILabel!
    @IBOutlet weak var answer3: UILabel!
    @IBOutlet weak var answer4: UILabel!
    
    
    
    @IBOutlet weak var Abutt: RadioButton!
    
    @IBOutlet weak var BButt: RadioButton!
    
    @IBOutlet weak var CButt: RadioButton!
    @IBOutlet weak var DButt: RadioButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Abutt.isSelected = false
        BButt.isSelected = false
        CButt.isSelected = false
        DButt.isSelected = false
        Abutt?.alternateButton = [BButt!, CButt!, DButt!]
        BButt?.alternateButton = [Abutt!, CButt!, DButt!]
        CButt?.alternateButton = [BButt!, Abutt!, DButt!]
        DButt?.alternateButton = [BButt!, CButt!, Abutt!]

        // Do any additional setup after loading the view.
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
