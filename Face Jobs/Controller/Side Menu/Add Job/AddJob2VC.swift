//
//  AddJob2VC.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 7/7/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import UIKit

class AddJob2VC: UIViewController {

    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var AddTimeView: UIView!
    @IBOutlet weak var TimeView: UIView!

    @IBOutlet weak var DateTextField: UITextField!
    @IBOutlet weak var TimeFromTextField: UITextField!
    @IBOutlet weak var TimeToTextField: UITextField!
        
    @IBOutlet weak var heightConstraintView: NSLayoutConstraint!

    @IBOutlet weak var AvilableBtn: UIButton!
    @IBOutlet weak var PaidBtn: UIButton!

    @IBOutlet weak var PaymentBtn: UIButton!
    @IBOutlet weak var JobPriceBtn: UIButton!
    
    @IBOutlet weak var ExpectedWorkText: UITextField!
    @IBOutlet weak var Job_WorkingHoursDescriptionText: UITextView!
    
    @IBOutlet weak var PriceText: UITextField!
    @IBOutlet weak var WorkNumberText: UITextField!

    @IBOutlet weak var NewxtBtn: UIButton!
    @IBOutlet weak var NewxtView: UIView!

    let regularFont = UIFont.systemFont(ofSize: 16)
    let boldFont = UIFont.boldSystemFont(ofSize: 16)
    
    // Data Picker View
    @objc private var dataPicker: UIDatePicker?
    @objc private var Time1Picker: UIDatePicker?
    @objc private var Time2Picker: UIDatePicker?

    let currentDate = Date()
    var JopModel:GetEditJopPageDataCodable!
    override func viewDidLoad() {
        super.viewDidLoad()
        Share.Job_DateTime.removeAll()
        PaidBtn.alpha = 0
        DateTextField.attributedPlaceholder = NSAttributedString(string: "Date".localized,
                                                            attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)])
        TimeFromTextField.attributedPlaceholder = NSAttributedString(string: "Time".localized,
                                                            attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)])
        TimeToTextField.attributedPlaceholder = NSAttributedString(string: "Time".localized,
                                                            attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)])
        SetupData()
        addingGradientLayerToNavigationBar([#colorLiteral(red: 0.1607843137, green: 0.6705882353, blue: 0.8862745098, alpha: 1).cgColor, #colorLiteral(red: 0, green: 1, blue: 1, alpha: 1).cgColor])
        TimeView.isHidden = true
        AddTimeView.isHidden = false
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableFooterView = UIView()
        tableview.register(UINib(nibName: "JobTimeTableViewCell", bundle: nil), forCellReuseIdentifier: "JobTimeCell")
        tableview.isHidden = true
        
        DateTextField.addTarget(self, action: #selector(AddJob2VC.textFieldDidChange(_:)), for: .editingChanged)
        TimeFromTextField.addTarget(self, action: #selector(AddJob2VC.textFieldDidChange(_:)), for: .editingChanged)
        TimeToTextField.addTarget(self, action: #selector(AddJob2VC.textFieldDidChange(_:)), for: .editingChanged)
        
        ExpectedWorkText.addTarget(self, action: #selector(AddJob2VC.textFieldDidChange(_:)), for: .editingChanged)
        PriceText.addTarget(self, action: #selector(AddJob2VC.textFieldDidChange(_:)), for: .editingChanged)
        WorkNumberText.addTarget(self, action: #selector(AddJob2VC.textFieldDidChange(_:)), for: .editingChanged)
        editJopData()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.SetupBtn()
    }
    
    @IBAction func BackPressed(_ sender: Any) {
        Share.Job_ExpectedWork = ""
        Share.Job_WorkingHoursDescription = ""
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func AddTimePressed(_ sender: Any) {
        TimeView.isHidden = false
        AddTimeView.isHidden = true
    }
    
    @IBAction func AddDatePressed(_ sender: Any) {
        if DateTextField.text?.isEmpty == true{
            
        }else{
            Share.Job_DateTime.append(DateTimesCodable.init(Day: DateTextField.text ?? "", TimeFrom: TimeFromTextField.text ?? "", TimeTo: TimeToTextField.text ?? ""))
            self.heightConstraintView.constant = CGFloat((Share.Job_DateTime.count)*40)
            tableview.isHidden = false
            tableview.reloadData()
        }
    }
    
    @IBAction func RemoveDatePressed(_ sender: Any) {
        DateTextField.text = ""
        TimeFromTextField.text = ""
        TimeToTextField.text = ""
    }
    
    @IBAction func AvilabelPressed(_ sender: UIButton) {
        if sender.isSelected == true {
            sender.isSelected = false
            print("not Selected")
            AvilableBtn.setImage(UIImage(named: "Checkbox empty"), for: .normal)
            PaidBtn.setImage(UIImage(named: "Checkbox empty"), for: .normal)
            Share.Job_IsAvilable = false
            PaidBtn.alpha = 0
            PaidBtn.isSelected = false
        }else {
            sender.isSelected = true
            print("Selected")
            AvilableBtn.setImage(UIImage(named: "Checkbox fill"), for: .normal)
            PaidBtn.setImage(UIImage(named: "Checkbox empty"), for: .normal)
            Share.Job_IsAvilable = true
            PaidBtn.alpha = 1
            PaidBtn.isSelected = false
        }
        print(Share.Job_IsAvilable)
    }
    
    @IBAction func PaidPressed(_ sender: UIButton) {
        if sender.isSelected == true {
            sender.isSelected = false
            print("not Selected")
            PaidBtn.setImage(UIImage(named: "Checkbox empty"), for: .normal)
            Share.Job_IsPaid = false
        }else {
            sender.isSelected = true
            print("Selected")
            PaidBtn.setImage(UIImage(named: "Checkbox fill"), for: .normal)
            Share.Job_IsPaid = true
        }
        print(Share.Job_IsPaid)
    }
    @IBAction func PricePressed(_ sender: Any) {
        let theme = YBTextPickerAppearanceManager.init(
            pickerTitle         : "Price Type",
            titleFont           : boldFont,
            titleTextColor      : .white,
            titleBackground     : #colorLiteral(red: 0.7240439057, green: 0.6962934732, blue: 0.6956846118, alpha: 1),
            searchBarFont       : regularFont,
            searchBarPlaceholder: "Search of Price",
            closeButtonTitle    : "Cancel",
            closeButtonColor    : .darkGray,
            closeButtonFont     : regularFont,
            doneButtonTitle     : "Done",
            doneButtonColor     : #colorLiteral(red: 0.7240439057, green: 0.6962934732, blue: 0.6956846118, alpha: 1),
            doneButtonFont      : boldFont,
            checkMarkPosition   : .Right,
            itemCheckedImage    : nil,
            itemUncheckedImage  : nil,
            itemColor           : .black,
            itemFont            : regularFont
        )
            
        let arrTheme = Share.PriceTypesListString
        let picker = YBTextPicker.init(with: arrTheme, appearance: theme, onCompletion: { (selectedIndexes, selectedValues) in
            if let selectedValue = selectedValues.first{
                self.JobPriceBtn.setTitle(selectedValue, for: .normal)
                let selectitem = Share.PriceTypesList?.first(where: {$0.name == selectedValue})
                Share.Job_PaymentType = selectitem?.id ?? 0
                print(selectitem?.id ?? 0)
                
                self.SetupBtn()
            }else{
                
            }
        }, onCancel: {
                
        })
        picker.show(withAnimation: .FromBottom)

    }
    @IBAction func PaymentPressed(_ sender: Any) {
        let theme = YBTextPickerAppearanceManager.init(
            pickerTitle         : "Categories",
            titleFont           : boldFont,
            titleTextColor      : .white,
            titleBackground     : #colorLiteral(red: 0.7240439057, green: 0.6962934732, blue: 0.6956846118, alpha: 1),
            searchBarFont       : regularFont,
            searchBarPlaceholder: "Search",
            closeButtonTitle    : "Cancel",
            closeButtonColor    : .darkGray,
            closeButtonFont     : regularFont,
            doneButtonTitle     : "Done",
            doneButtonColor     : #colorLiteral(red: 0.7240439057, green: 0.6962934732, blue: 0.6956846118, alpha: 1),
            doneButtonFont      : boldFont,
            checkMarkPosition   : .Right,
            itemCheckedImage    : nil,
            itemUncheckedImage  : nil,
            itemColor           : .black,
            itemFont            : regularFont
        )
        Share.PaymentMethodsListString.removeAll()

        let selectitemCategory = Share.PaymentMethodsList?.first(where: {$0.id == Share.Job_PaymentMethodJob})
        Share.PaymentMethodsListString.append(selectitemCategory?.name ?? "")
        
        print(Share.PaymentMethodsListString)
        let arrTheme = Share.PaymentMethodsListString
        let picker = YBTextPicker.init(with: arrTheme, appearance: theme, onCompletion: { (selectedIndexes, selectedValues) in
            if let selectedValue = selectedValues.first{
                self.PaymentBtn.setTitle(selectedValue, for: .normal)
                let selectitem = Share.PaymentMethodsList?.first(where: {$0.name == selectedValue})
                Share.Job_PaymentMethod = selectitem?.id ?? 0
                print(selectitem?.id ?? 0)
                
                self.SetupBtn()
            }else{
                
            }
        }, onCancel: {
                
        })
        picker.show(withAnimation: .FromBottom)
    }
    @IBAction func NextPressed(_ sender: UIButton) {
        print(Share.Job_DateTime)
        print(DateTextField.text)
        print(TimeFromTextField.text)
        print(TimeToTextField.text)
        print(ExpectedWorkText.text)
        print(Share.Job_PaymentMethod )
        print(Share.Job_PaymentType)
        print(PriceText.text)
        print(WorkNumberText.text)

        if Share.Job_DateTime.isEmpty == true{
            Share.Job_DateTime.append(DateTimesCodable.init(Day: DateTextField.text ?? "", TimeFrom: TimeFromTextField.text ?? "", TimeTo: TimeToTextField.text ?? ""))
        }
        if Share.Job_DateTime.isEmpty == true || ( DateTextField.text?.isEmpty == true && TimeFromTextField.text?.isEmpty == true && TimeToTextField.text?.isEmpty == true){
            
        }else if ExpectedWorkText.text?.isEmpty == true{

        }else if Share.Job_PaymentMethod == -1{

        }else if Share.Job_PaymentType == -1{

        }else if PriceText.text?.isEmpty == true{

        }else if WorkNumberText.text?.isEmpty == true{

        }else{
            Share.Job_ExpectedWork = ExpectedWorkText.text ?? ""
            Share.Job_WorkingHoursDescription = Job_WorkingHoursDescriptionText.text ?? ""
            Share.Job_Price = Double(PriceText.text ?? "") ?? 0.0
            Share.Job_WorkNumber = Int(WorkNumberText.text ?? "") ?? 0
            let vc = Share.storyBoard.instantiateViewController(withIdentifier: "AddJobPage3") as! UINavigationController
            let addJopVC = vc.viewControllers.first as! AddJob2VC
            addJopVC.JopModel = JopModel
            self.present(vc, animated: true, completion: nil)
        }

    }
}

extension AddJob2VC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Share.Job_DateTime.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: JobTimeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "JobTimeCell", for: indexPath) as! JobTimeTableViewCell
        cell.DateJob.text = Share.Job_DateTime[indexPath.row].Day ?? ""
        cell.Time1Job.text = Share.Job_DateTime[indexPath.row].TimeFrom ?? ""
        cell.Time2Job.text = Share.Job_DateTime[indexPath.row].TimeTo ?? ""

        cell.RemoveBtn.addTarget(self, action: #selector(connectedRemove(sender:)), for: .touchUpInside)
        cell.RemoveBtn.tag = indexPath.row
        
        return cell
    }
    @objc func connectedRemove(sender: UIButton){
        Share.Job_DateTime.remove(at: sender.tag)
        self.heightConstraintView.constant = CGFloat((Share.Job_DateTime.count)*40)
        tableview.reloadData()
        if Share.Job_DateTime.count == 0{
            tableview.isHidden = true
        }else{
            tableview.isHidden = false
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
extension AddJob2VC{
    func SetupData(){
        DateTextField.addDoneButtonOnKeyboard()
        TimeFromTextField.addDoneButtonOnKeyboard()
        TimeToTextField.addDoneButtonOnKeyboard()
        
        dataPicker = UIDatePicker()
        dataPicker?.datePickerMode = .date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = NSLocale.init(localeIdentifier: "en") as Locale
        dataPicker?.addTarget(self, action: #selector(AddJob2VC.dateChange(dataPicker:)), for: .valueChanged)
        DateTextField.text = dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: 0, to: currentDate)!)
        DateTextField.inputView = dataPicker
        
        Time1Picker = UIDatePicker()
        Time1Picker?.datePickerMode = .time
        let dateFormatterTimer1 = DateFormatter()
        dateFormatterTimer1.dateFormat = "HH:mm"
        dateFormatterTimer1.locale = NSLocale.init(localeIdentifier: "en") as Locale
        Time1Picker?.addTarget(self, action: #selector(AddJob2VC.TimeChange(dataPicker:)), for: .valueChanged)
        TimeFromTextField.text = dateFormatterTimer1.string(from: Calendar.current.date(byAdding: .hour, value: 0, to: currentDate)!)
        TimeFromTextField.inputView = Time1Picker
        
        Time2Picker = UIDatePicker()
        Time2Picker?.datePickerMode = .time
        let dateFormatterTimer2 = DateFormatter()
        dateFormatterTimer2.dateFormat = "HH:mm"
        dateFormatterTimer2.locale = NSLocale.init(localeIdentifier: "en") as Locale
        Time2Picker?.addTarget(self, action: #selector(AddJob2VC.Time2Change(dataPicker:)), for: .valueChanged)
        TimeToTextField.text = dateFormatterTimer2.string(from: Calendar.current.date(byAdding: .hour, value: 0, to: currentDate)!)
        TimeToTextField.inputView = Time2Picker

    }
    @objc func dateChange(dataPicker: UIDatePicker){
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = NSLocale.init(localeIdentifier: "en") as Locale

        DateTextField.text = dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: 2, to: currentDate)!)
    
        if dataPicker.date > currentDate{
            DateTextField.text = dateFormatter.string(from: dataPicker.date)
        }else{
            DateTextField.text = dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!)
        }
    }
    @objc func TimeChange(dataPicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.locale = NSLocale.init(localeIdentifier: "en") as Locale
        print(dateFormatter)
        TimeFromTextField.text = dateFormatter.string(from: Time1Picker!.date)
    }
    @objc func Time2Change(dataPicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.locale = NSLocale.init(localeIdentifier: "en") as Locale
        print(dateFormatter)
        TimeToTextField.text = dateFormatter.string(from: Time2Picker!.date)
    }
    func SetupBtn(){
        if Share.Job_DateTime.isEmpty == true && self.DateTextField.text?.isEmpty == true{
            self.NewxtView.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.12)
            self.NewxtBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.26), for: .normal)
        }else if self.ExpectedWorkText.text?.isEmpty == true{
            self.NewxtView.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.12)
            self.NewxtBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.26), for: .normal)
        }else if Share.Job_PaymentMethod == -1{
            self.NewxtView.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.12)
            self.NewxtBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.26), for: .normal)
        }else if Share.Job_PaymentType == -1{
            self.NewxtView.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.12)
            self.NewxtBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.26), for: .normal)
        }else if self.PriceText.text?.isEmpty == true{
            self.NewxtView.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.12)
            self.NewxtBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.26), for: .normal)
        }else if self.WorkNumberText.text?.isEmpty == true{
            self.NewxtView.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.12)
            self.NewxtBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.26), for: .normal)
        }else{
            self.NewxtView.layer.backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.7019607843, blue: 0.8980392157, alpha: 1)
            self.NewxtBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        }
    }
}
extension AddJob2VC{
    func editJopData(){
        if JopModel != nil{
            AvilableBtn.isSelected = !JopModel.Data!.IsBreakAvailable
            AvilabelPressed(AvilableBtn)
            if JopModel.Data!.IsBreakAvailable{
                PaidBtn.isSelected = !JopModel.Data!.IsBreakPaid
                PaidPressed(PaidBtn)
            }
            Job_WorkingHoursDescriptionText.text = JopModel.Data?.WorkingHoursDescription
            PriceText.text = String(JopModel.Data!.Price)
            for paymentType in JopModel.Data!.PriceTypes{
                if paymentType.Id == JopModel.Data!.PaymentType{
                    Share.Job_PaymentType = paymentType.Id
                    self.JobPriceBtn.setTitle(paymentType.Name, for: .normal)
                }
            }
            for paymentMethod in JopModel.Data!.PaymentMethods{
                if paymentMethod.Id == JopModel.Data!.PaymentType{
                    Share.Job_PaymentMethod = paymentMethod.Id
                    self.PaymentBtn.setTitle(paymentMethod.Name, for: .normal)
                }
            }
            WorkNumberText.text = String(JopModel.Data!.NumberOfEmployees)
            let dayFormatter = DateFormatter()
            let timeFormatter = DateFormatter()
            dayFormatter.locale = NSLocale.init(localeIdentifier: "en") as Locale
            timeFormatter.locale = NSLocale.init(localeIdentifier: "en") as Locale
            for jopDate in JopModel.Data!.DateTimes{
                dayFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
                timeFormatter.dateFormat = "HH:mm:ss"
                let day = dayFormatter.date(from: jopDate.Day)!
                let time1 = timeFormatter.date(from: jopDate.TimeFrom)!
                let time2 = timeFormatter.date(from: jopDate.TimeTo)!
                dayFormatter.dateFormat = "yyyy-MM-dd"
                timeFormatter.dateFormat = "HH:mm"
                Share.Job_DateTime.append(DateTimesCodable.init(Day: dayFormatter.string(from: day) , TimeFrom: timeFormatter.string(from: time1) ?? "", TimeTo: timeFormatter.string(from: time2) ?? ""))
                self.heightConstraintView.constant = CGFloat((Share.Job_DateTime.count)*40)
                tableview.isHidden = false
                tableview.reloadData()
            }
        }
    }
}
