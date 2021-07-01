//
//  DatePicker.swift
//  Face Jobs
//
//  Created by Apple on 6/1/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
//

import UIKit

class DatePicker: UIViewController {
    
    @IBOutlet weak var DateView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
   weak var delegate: dateSelecProtocol?
    weak var fromtimeDelegate: fromTimeSelecProtocol?
    weak var toTimeDelegate:toTimeSelecProtocol?
    var isDate = false
    override func viewDidLoad() {
        super.viewDidLoad()
        showDatePicker()
            }
    override func viewDidAppear(_ animated: Bool) {
        let dateChooserAlert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        
        
        let attributedString = NSAttributedString(string: "Choose date...", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red,
                                                                                         NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)])
        dateChooserAlert.setValue(attributedString, forKey: "attributedTitle")
        dateChooserAlert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: { action in
            self.removeFromParent()
            self.view.removeFromSuperview()
        }))
        dateChooserAlert.view.addSubview(datePicker)
        datePicker.topAnchor.constraint(equalTo: dateChooserAlert.view.topAnchor, constant: 20).isActive = true
        datePicker.rightAnchor.constraint(equalTo: dateChooserAlert.view.rightAnchor, constant: -10).isActive = true
        datePicker.leftAnchor.constraint(equalTo: dateChooserAlert.view.leftAnchor, constant: 10).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: dateChooserAlert.view.bottomAnchor, constant: -60).isActive = true
        self.present(dateChooserAlert, animated: true, completion: nil)
    }
    func showDatePicker(){
        isDate == true ? (datePicker.datePickerMode = .date) : (datePicker.datePickerMode = .time)
    }
    
    @IBAction func DoneTapped(_ sender: Any) {
        self.removeFromParent()
        self.view.removeFromSuperview()
    }
    
    @IBAction func selectDate(_ sender: UIDatePicker) {
        delegate?.getSelectDate(date: sender.date)
        fromtimeDelegate?.getFromTime(date: sender.date)
        toTimeDelegate?.getToTime(date: sender.date)

    }
}
protocol dateSelecProtocol: AnyObject {
    func getSelectDate(date: Date?)
}
protocol fromTimeSelecProtocol: AnyObject {
    func getFromTime(date: Date?)
}
protocol toTimeSelecProtocol: AnyObject {
    func getToTime(date: Date?)
}
