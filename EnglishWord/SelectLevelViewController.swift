//
//  SelectLevelViewController.swift
//  EnglishWord
//
//  Created by Tomo Shimizu on 2023/01/05.
//

import Foundation
import UIKit

class SelectLevelViewController: UIViewController {
    
    @IBOutlet weak var easyBtn: UIButton!
    @IBOutlet weak var normalBtn: UIButton!
    @IBOutlet weak var difficultBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        title = "レベル選択"
        
        easyBtn.layer.cornerRadius = 10
        normalBtn.layer.cornerRadius = 10
        difficultBtn.layer.cornerRadius = 10
    }
    
    @IBAction func showEasyWord(_ sender: Any) {
        transDisplayWordVC(level: 1)
    }
    
    @IBAction func showNormalWord(_ sender: Any) {
        transDisplayWordVC(level: 2)
    }
    
    @IBAction func showDifficultWord(_ sender: Any) {
        transDisplayWordVC(level: 3)
    }
    
    func transDisplayWordVC(level: Int) {
        let displayWordVC = storyboard?.instantiateViewController(withIdentifier: "DisplayWord") as! DisplayWordViewController
        displayWordVC.wordLevel = level
        navigationController?.pushViewController(displayWordVC, animated: true)
    }
}
