//
//  TutorialViewController.swift
//  ChartExample
//
//  Created by Lê Hoàng Sinh on 05/05/2021.
//  Copyright © 2021 Lê Hoàng Sinh. All rights reserved.
//

import UIKit
import KRWalkThrough

class TutorialViewController: UIViewController {
    
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn3: UIButton!
    
    @IBOutlet weak var btn2: UIButton!
    
    @IBOutlet weak var btn1: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tutorialView = TutorialView(frame: UIScreen.main.bounds)
        
        let frame = btn1.convert(btn1.frame, to: view)
        
        tutorialView.makeAvailable(rect: frame, insets: UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0),cornerRadius: btn1.frame.size.width/2)
        tutorialView.backgroundColor = .black
        tutorialView.tintColor = .black
        
        let tutorialItem = TutorialItem(view: tutorialView, identifier: "tutorialView")
        
        TutorialManager.shared.register(item: tutorialItem)
        
        TutorialManager.shared.showTutorial(withIdentifier: "tutorialView")
        
        tutorialView.addSubview(btn1)
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
