//
//  changeLanguageVC.swift
//  Face Jobs
//
//  Created by Apple on 2/23/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
//

import UIKit
import MOLH
class changeLanguageVC: UIViewController {

    @IBOutlet weak var arabicBTN: UIButton!
    @IBOutlet weak var englishBTN: UIButton!
    @IBOutlet weak var backBTN: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        getSelectedLanguage()
    }
    private func setUpView()
    {
        self.navigationController?.navigationBar.isHidden = true
        arabicBTN.layer.cornerRadius = 8
        arabicBTN.layer.masksToBounds = true
        englishBTN.layer.cornerRadius = 8
        englishBTN.layer.masksToBounds = true
        if MOLHLanguage.isArabic() {
            backBTN.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
//        self.navigationController?.navigationBar.isHidden = false
    }
    private func getSelectedLanguage()
    {
        if MOLHLanguage.isArabic() {
            arabicBTN.setTitleColor(.white, for: .normal)
            arabicBTN.backgroundColor = UIColor.selectedColor
        }
        else {
            englishBTN.setTitleColor(.white, for: .normal)
            englishBTN.backgroundColor = UIColor.selectedColor
        }
    }
    
    @IBAction func arabic_Tapped(_ sender: Any) {
        MOLH.setLanguageTo("ar")
        MOLH.reset()
    }
    
    @IBAction func english_Tapped(_ sender: Any) {
        MOLH.setLanguageTo("en")
        MOLH.reset()

    }
    
    
    @IBAction func back_Tapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
