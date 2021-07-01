//
//  FirstJobViewController.swift
//  Face Jobs
//
//  Created by Apple on 4/6/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
//

import UIKit

extension jobViewController {
    func setConersToView()
    {
        setCornersToView(lable: titleLBL)
        setCornersToView(lable: descriptionLBL)
        setCornersToView(lable: catioryLBL)
        setCornersToView(lable: typeLBL)
    }
    func setDelegate()
    {
      
    }
    func setUpView()
    {
        
//        scrollerView.flipd
        descriptionTxt.text = "job_description".localized
        descriptionTxt.textColor = UIColor.white
        workingHoursDes.text = "workingDes".localized
        workingHoursDes.textColor = UIColor.white
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        self.addingGradientLayerToView([#colorLiteral(red: 0.1607843137, green: 0.6705882353, blue: 0.8862745098, alpha: 1).cgColor, #colorLiteral(red: 0, green: 1, blue: 1, alpha: 1).cgColor], view: topView)
        if Share.isArabic() {
            self.containerStack.transform = CGAffineTransform(scaleX: -1, y: 1)
            for viwe1 in containerStack.arrangedSubviews
            {
                viwe1.transform = CGAffineTransform(scaleX: -1, y: 1)
            }

            backBTN.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
        
    }
    func setDelegateToviewController()
    {
        paymentMethod.tapDelegate = self
        priceTXT.tapDelegate = self
        typeTxt.tapDelegate = self
        catgoryTXT.tapDelegate = self
        country.tapDelegate = self
        cityTXXT.tapDelegate = self
        valiageTXT.tapDelegate = self
        fromTXT.tapDelegate = self
        toTXT.tapDelegate = self
        addTimeText.tapDelegate = self
        descriptionTxt.delegate = self
        workingHoursDes.delegate = self
    }
    func setCornersToView(lable: UILabel)
    {
        lable.layer.cornerRadius = 5
        lable.layer.masksToBounds = true
    }
    func setUpAdressCollectionView()
    {
        addressCollection.delegate = self
        addressCollection.dataSource = self
        addressCollection.register(UINib(nibName: "AddressCell", bundle: nil), forCellWithReuseIdentifier: "AddressCell")
    }
    func setUpCcollectionView()
    {
        photoCollecction.delegate = self
        photoCollecction.dataSource = self
        photoCollecction.register(UINib(nibName: "AddJobImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
    }
    func setUpTableView()
    {
        timeTable.delegate = self
        timeTable.dataSource = self
        timeTable.register(UINib(nibName: "JobTimeTableViewCell", bundle: nil), forCellReuseIdentifier: timeCellIdentifier)
        timeTable.isHidden = true
        timeTable.tableFooterView = UIView()
        addTimeText.addTarget(self, action: #selector(AddJob2VC.textFieldDidChange(_:)), for: .editingChanged)
        addTimeText.attributedPlaceholder = NSAttributedString(string: "Date".localized, attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)])
        paidStack.isHidden = true
    }
    func setUpDate()
    {
        // set Up Date
        dataPicker = UIDatePicker()
        dataPicker?.datePickerMode = .date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = NSLocale.init(localeIdentifier: "en") as Locale
        dataPicker?.addTarget(self, action: #selector(self.dateChange(dataPicker:)), for: .valueChanged)
        addTimeText.text = dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: 0, to: currentDate)!)
        addTimeText.inputView = dataPicker
        // Set Up from Time
        Time1Picker = UIDatePicker()
        Time1Picker?.datePickerMode = .time
        let dateFormatterTimer1 = DateFormatter()
        dateFormatterTimer1.dateFormat = "HH:mm"
        dateFormatterTimer1.locale = NSLocale.init(localeIdentifier: "en") as Locale
        Time1Picker?.addTarget(self, action: #selector(self.TimeChange(dataPicker:)), for: .valueChanged)
        fromTXT.text = dateFormatterTimer1.string(from: Calendar.current.date(byAdding: .hour, value: 0, to: currentDate)!)
        fromTXT.inputView = Time1Picker
        
        // Set Up To Time
        
        Time2Picker = UIDatePicker()
        Time2Picker?.datePickerMode = .time
        let dateFormatterTimer2 = DateFormatter()
        dateFormatterTimer2.dateFormat = "HH:mm"
        dateFormatterTimer2.locale = NSLocale.init(localeIdentifier: "en") as Locale
        Time2Picker?.addTarget(self, action: #selector(self.Time2Change(dataPicker:)), for: .valueChanged)
        toTXT.text = dateFormatterTimer2.string(from: Calendar.current.date(byAdding: .hour, value: 0, to: currentDate)!)
        toTXT.inputView = Time2Picker
    }
    
    // @obec Fucns
    @objc func Time2Change(dataPicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.locale = NSLocale.init(localeIdentifier: "en") as Locale
        toTXT.text = dateFormatter.string(from: Time2Picker!.date)
    }
    @objc func TimeChange(dataPicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.locale = NSLocale.init(localeIdentifier: "en") as Locale
        print(dateFormatter)
        fromTXT.text = dateFormatter.string(from: Time1Picker!.date)
    }
    
    @objc func dateChange(dataPicker: UIDatePicker){
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = NSLocale.init(localeIdentifier: "en") as Locale
        
        addTimeText.text = dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: 2, to: currentDate)!)
        
        if dataPicker.date > currentDate{
            addTimeText.text = dateFormatter.string(from: dataPicker.date)
        }else{
            addTimeText.text = dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!)
        }
    }
    func checkDataForThirdView() -> Bool
    {
        if postalCode.text!.isEmpty{
            setErrorForView(textFiled: postalCode, titleLabel: titleLBL, textView: nil)
            AlertView.instance.showAlert(message: "postalCodeRequired".localized, alertType: .failure)
            return false
        }
        if streetTxt.text!.isEmpty{
            setErrorForView(textFiled: streetTxt, titleLabel: titleLBL, textView: nil)
            AlertView.instance.showAlert(message: "StreetRequirde".localized, alertType: .failure)
            return false
        }
        if moreDetailsTXT.text!.isEmpty{
            setErrorForView(textFiled: moreDetailsTXT, titleLabel: titleLBL, textView: nil)
            AlertView.instance.showAlert(message: "moreDetailsRequired".localized, alertType: .failure)
            return false
        }
        return true
        
    }
    func checkDataForSeccondView() -> Bool
    {
        if Datas.isEmpty{
            Datas.append(DateTimesCodable(Day: addTimeText.text ?? "", TimeFrom: fromTXT.text ?? "", TimeTo: toTXT.text ?? ""))
        }
        if workingHoursTXT.text!.isEmpty{
            setErrorForView(textFiled: workingHoursTXT, titleLabel: titleLBL, textView: nil)
            AlertView.instance.showAlert(message: "working_hours".localized, alertType: .failure)
            return false
            
        }
        if workingHoursDes!.text.isEmpty || workingHoursDes!.text == "workingDes".localized {
            setErrorForView(textFiled: nil, titleLabel: titleLBL, textView: workingHoursDes)
            AlertView.instance.showAlert(message: "descriptionWorkingRequired".localized, alertType: .failure)
            return false
        }
        if valueTXT.text!.isEmpty {
            setErrorForView(textFiled: valueTXT, titleLabel: titleLBL, textView: nil)
            AlertView.instance.showAlert(message: "jobPrice".localized, alertType: .failure)
            return false
        }
        if numberOfWorkers.text!.isEmpty {
            setErrorForView(textFiled: numberOfWorkers, titleLabel: titleLBL, textView: nil)
            AlertView.instance.showAlert(message: "workerNumber".localized, alertType: .failure)
            return false
        }
        
        return true
    }
    func checkDataForFirstView() -> Bool
    {
        if titelTXT.text!.isEmpty{
            setErrorForView(textFiled: titelTXT, titleLabel: titleLBL, textView: nil)
            AlertView.instance.showAlert(message: "jobTitle".localized, alertType: .failure)
            return false
            
        }
        else if typeTxt.text!.isEmpty{
            setErrorForView(textFiled: typeTxt, titleLabel: typeLBL, textView: nil)
            AlertView.instance.showAlert(message: "jobType".localized, alertType: .failure)
            return false
        }
        else if catgoryTXT.text!.isEmpty{
            setErrorForView(textFiled: catgoryTXT, titleLabel: typeLBL, textView: nil)
            AlertView.instance.showAlert(message: "jobCatigory".localized, alertType: .failure)
            return false
        }
        else if descriptionTxt.text!.isEmpty || descriptionTxt.text == "job_description".localized{
            setErrorForView(textFiled: nil, titleLabel: descriptionLBL, textView: descriptionTxt)
            AlertView.instance.showAlert(message: "jobDescriptionRequired".localized, alertType: .failure)
            return false
        }
        if JobImages.isEmpty{
            AlertView.instance.showAlert(message: "jobPhoto".localized, alertType: .failure)
            return false
        }
        return true
        
    }
    func checkDataforSecondView()-> Bool{
        return false
    }
    func addNewJob()
    {
        if let postalCode = postalCode.text, !postalCode.isEmpty, let street = streetTxt.text, !street.isEmpty {
            guard let longtidueData = longtidue, let LatitudeData = latidute else {
                addLocationBTN.titleLabel?.textColor = .red
                AlertView.instance.showAlert(message: "selectFromMap".localized, alertType: .failure)
                return
            }
            addLocationBTN.titleLabel?.textColor = .white
            let address = AddressCodableJob(CountryId: coutryID, CityId: CityID, AreaId: areaID, PostalCode: postalCode, Street: streetTxt.text ?? "", Details: moreDetailsTXT.text ?? "", Latitude: LatitudeData, Longitude: longtidueData)
            addresses.append(address)
        }
        else {
            print("fill all address data")
        }
        if checkDataForThirdView()
        {
            AddJob(Title: titelTXT.text ?? "", JobType: typeID, CategoryId: catigoryID, Description: descriptionTxt.text ?? "", IsJobMultiDays: false, DateTimes: Datas, IsBreakAvailable: isAvilable, IsBreakPaid: isPaid, JobTimeType: 0, Photos: jobsImagesString, ExpectedWorkingHours: workingHoursTXT.text ?? "", WorkingHoursDescription: workingHoursDes.text ?? "", PaymentMethod: paymentID, PaymentType: priceID, Price: Double(valueTXT.text ?? "") ?? 0.0, NumberOfEmployees: Int(numberOfWorkers.text ?? "") ?? 0 , Addresses: addresses, IsOnline: false)
        }
    }
    
    func edit_Job()
    {
        if checkDataForThirdView(){
            eidtjob(JobId: 55, Title: titelTXT.text ?? "", JobType: typeID, CategoryId: catigoryID, Description: descriptionTxt.text ?? "", IsJobMultiDays: false, DateTimes: arr, IsBreakAvailable: isAvilable, IsBreakPaid: isPaid, JobTimeType: 1, Photos: jobsImagesString, ExpectedWorkingHours: workingHoursTXT.text ?? "", WorkingHoursDescription: workingHoursDes.text ?? "", PaymentMethod: paymentID, PaymentType: priceID, Price: Double(valueTXT.text ?? "") ?? 0.0, NumberOfEmployees: Int(numberOfWorkers.text ?? "") ?? 0, Addresses: addresses, IsOnline: false)
        }
    }
    @objc func connectedRemove(sender: UIButton){
        Datas.remove(at: sender.tag)
        self.timeTableHight.constant = CGFloat((Datas.count) * 40)
        timeTable.reloadData()
        if Datas.count == 0{
            timeTable.isHidden = true
        }else{
            timeTable.isHidden = false
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        //        self.SetupBtn()
    }
    func setErrorForView(textFiled: UITextField?, titleLabel: UILabel, textView: UITextView?)
    {
        //        titleLabel.textColor = .red
        textFiled?.becomeFirstResponder()
        textView?.becomeFirstResponder()
        
    }
    func setJobDataMultiSelect(MultiSelectData: EditJobModelData)
    {
        Share.CountriesListString.removeAll()
        Share.TypeListString.removeAll()
        Share.CategoriesListString.removeAll()
        Share.TypeList = MultiSelectData.types
        Share.CategoriesList = MultiSelectData.categories
        Share.PaymentMethodsList = MultiSelectData.paymentMethods
        Share.CountriesList = MultiSelectData.countries
        Share.PriceTypesList = MultiSelectData.priceTypes
        if let types = MultiSelectData.types {
            typesModel = types
        }
        if let catigories = MultiSelectData.categories {
            catigoryModel = catigories
//            catgoryTXT.text = catigories.first?.name ?? ""
//            catigoryID = catigories.first?.id ?? 0
        }
        if let paymentsMotheds = MultiSelectData.paymentMethods{
            payments = paymentsMotheds
            paymentMethod.text = paymentsMotheds.first?.name ?? ""
            paymentID = paymentsMotheds.first?.id ?? 0
        }
        if let priceTypes = MultiSelectData.priceTypes {
            prices = priceTypes
            priceID = priceTypes.first?.id ?? 0
            priceTXT.text = priceTypes.first?.name ?? ""
        }
        if let countries_Model = MultiSelectData.countries{
            countriesModel = countries_Model
            country.text = countries_Model.first?.name ?? ""
            coutryID = countries_Model.first?.id ?? 0
            GetCity(id: coutryID)
        
    }
        
    else{
//        ErrorCode.instance.Code(Code: model.errorCode ?? 0)
}
        
    }
    func IsEditJob(){
        if isEdit{
            if let job_id = jobID {
                getEditJobData(jobID: job_id)
            }
        }
        else {
            GetDataToAddJob()
        }
    }
    func setUpEditableData(jobData: EditJobModelData)
    {
       
        self.typeID = jobData.jobType ?? 0
        self.catigoryID = jobData.categoryId ?? 0
        if let photos = jobData.currentPhotos {
            for item in photos{
                let imageUrl = "http://face-jobs.com\(item.imageUrl ?? "")"
                guard let url = URL(string: imageUrl) else {return}
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        self.JobImages.append(image)
                    }
                }
            }
        }
        DispatchQueue.global().async {
            let filteredTypes = jobData.types?.filter { (typs) in
                return  typs.id == jobData.jobType ?? 0
        }
            let filteredCatigories = jobData.categories?.filter { (catigory) in
            return  catigory.id == jobData.categoryId ?? 0
        }
            let filteredPaymentMethod = jobData.paymentMethods?.filter { (payments) in
            return  payments.id == jobData.paymentMethod ?? 0
        }
            let filteredPaymentType = jobData.priceTypes?.filter { (prices) in
            return  prices.id == jobData.paymentType ?? 0
        }
        
            if let addressData = jobData.addresses {
                self.addresses.removeAll()
                for address in addressData {
                    self.addresses.append(AddressCodableJob(CountryId: address.countryId ?? 0, CityId: address.cityId ?? 0, AreaId: address.areaId ?? 0, PostalCode: address.postalCode ?? "", Street: address.street ?? "", Details: address.details ?? "", Latitude: address.latitude ?? 0.0, Longitude: address.longitude ?? 0.0))
                }
            }
            if let photos = jobData.currentPhotos {
                self.JobImages.removeAll()
                for item in photos{
                    let imageUrl = "http://face-jobs.com\(item.imageUrl ?? "")"
                    guard let url = URL(string: imageUrl) else {return}
                    if let data = try? Data(contentsOf: url) {
                        if let image = UIImage(data: data) {
                            self.JobImages.append(image)
                        }
                    }
                }
            }
            if let Dates = jobData.dateTimes{
            self.Datas.removeAll()
            for time in Dates{
              let day = time.day ?? ""
                let from = time.timeFrom ?? ""
                let to = time.timeTo ?? ""
                self.Datas.append(DateTimesCodable(Day: day, TimeFrom: from, TimeTo: to))
                let json = DateTimesCodable(Day: day, TimeFrom: from, TimeTo: to).toJson()
                self.arr.append(json)
            }
        }
            
        DispatchQueue.main.async {
           
            if let is_Avilable = jobData.isBreakAvailable
            {
                if is_Avilable{
                    self.avilableBTN.isSelected = false
                    self.avilableBTNTapped(self.avilableBTN)
                }
                else{
                    self.avilableBTN.isSelected = true
                    self.avilableBTNTapped(self.avilableBTN)
                }
                
            }
            if let is_BreakPaid = jobData.isBreakPaid
            {
                if is_BreakPaid{
                    self.paidBTN.isSelected = false
                    self.paidBTN(self.paidBTN)
                }
                else{
                    self.paidBTN.isSelected = true
                    self.paidBTN(self.paidBTN)
                }
            }
            self.catgoryTXT.text = filteredCatigories?.first?.name
            self.typeTxt.text = filteredTypes?.first?.name ?? ""
            self.descriptionTxt.text = jobData.description ?? ""
            self.titelTXT.text = jobData.title ?? ""
            self.timeTableHight.constant = CGFloat((self.Datas.count)*40)
            self.timeTable.isHidden = false
            self.timeTable.reloadData()
            self.workingHoursTXT.text = "0"
            self.workingHoursDes.text = "\(jobData.workingHoursDescription ?? "")"
            self.paymentMethod.text = filteredPaymentMethod?.first?.name ?? ""
            self.priceTXT.text = filteredPaymentType?.first?.name ?? ""
            self.valueTXT.text = "\(jobData.price ?? 0.0)"
            self.numberOfWorkers.text = "\(jobData.numberOfEmployees ?? 0)"
            
            self.addressCollection.reloadData()
            self.photoCollecction.reloadData()

            
        }
        }
    }
}
extension jobViewController: TappedTextFieldDelegate {
    func textFieldDidTap(_ textField: TappedTextField) {
        var arrTheme: [String] = [String]()
        if textField == typeTxt {
            for item in typesModel {
                arrTheme.append(item.name ?? "")
            }
            callTextPickerAppearanceManager(title: "types".localized, items: arrTheme, completion: {
                text in
                self.typeTxt.text = text
                let selectitem = self.typesModel.first(where: {$0.name == text})
                self.typeID = selectitem?.id ?? 0
            }
            )
        }
        else if textField == catgoryTXT {
            for item in catigoryModel {
                arrTheme.append(item.name ?? "")
            }
            callTextPickerAppearanceManager(title: "Catigories".localized, items: arrTheme, completion: {
                text in
                self.catgoryTXT.text = text
                let selectitem = self.catigoryModel.first(where: {$0.name == text})
                self.catigoryID = selectitem?.id ?? 0
            }
            )
        }
        else if textField == paymentMethod {
            for item in payments {
                arrTheme.append(item.name ?? "")
            }
            callTextPickerAppearanceManager(title: "paymentsMotheds".localized, items: arrTheme, completion: {
                text in
                self.paymentMethod.text = text
                let selectitem = self.payments.first(where: {$0.name == text})
                self.paymentID = selectitem?.id ?? 0
            }
            )
            
            
        }
        else if textField == priceTXT {
            for item in prices {
                arrTheme.append(item.name ?? "")
            }
            callTextPickerAppearanceManager(title: "Prices".localized, items: arrTheme, completion: {
                text in
                self.priceTXT.text = text
                let selectitem = self.prices.first(where: {$0.name == text})
                self.priceID = selectitem?.id ?? 0
            }
            )
        }
        else if textField == country {
            for item in countriesModel {
                arrTheme.append(item.name ?? "")
            }
            callTextPickerAppearanceManager(title: "Countries".localized, items: arrTheme, completion: {
                text in
                self.country.text = text
                let selectitem = self.countriesModel.first(where: {$0.name == text})
                self.coutryID = selectitem?.id ?? 0
                self.GetCity(id: self.coutryID )
            }
            )
        }
    else if textField == cityTXXT {
    for item in citiesModel {
    arrTheme.append(item.name ?? "")
    }
        callTextPickerAppearanceManager(title: "Countries".localized, items: arrTheme, completion: {
    text in
    self.cityTXXT.text = text
    let selectitem = self.citiesModel.first(where: {$0.name == text})
    self.CityID = selectitem?.id ?? 0
        self.GetArea(id: self.CityID)
    }
    )
    }
   else if textField == valiageTXT {
    for item in areaModel {
        arrTheme.append(item.name ?? "")
    }
    callTextPickerAppearanceManager(title: "Countries".localized, items: arrTheme, completion: {
        text in
        self.valiageTXT.text = text
        let selectitem = self.areaModel.first(where: {$0.name == text})
        self.areaID = selectitem?.id ?? 0
        
    }
    )
}
   else if textField == fromTXT {
    let vc  = DatePicker.loadFromNib()
    vc.view.frame = self.view.frame
    vc.fromtimeDelegate = self
    self.addChild(vc)
    self.view.addSubview(vc.view)
   }
   else if textField == toTXT {
    let vc  = DatePicker.loadFromNib()
    vc.toTimeDelegate = self
    vc.view.frame = self.view.frame
    self.addChild(vc)
    self.view.addSubview(vc.view)
   }
   else if textField == addTimeText{
    let vc  = DatePicker.loadFromNib()
    vc.delegate = self
    vc.isDate = true
    vc.view.frame = self.view.frame
    self.addChild(vc)
    self.view.addSubview(vc.view)
   }
}
}

extension jobViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == workingHoursDes {
            if workingHoursDes.text == "workingDes".localized {
                workingHoursDes.text = ""
                }
        }
        else {
        if descriptionTxt.text == "job_description".localized {
            descriptionTxt.text = ""
            }
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == workingHoursDes {
            if workingHoursDes.text == "" {
                workingHoursDes.text = "workingDes".localized
                }
        }
        else {
        if descriptionTxt.text == "" {
            descriptionTxt.text = "job_description".localized
           }
    }
    }
}

extension jobViewController: dateSelecProtocol, toTimeSelecProtocol, fromTimeSelecProtocol{
    func getSelectDate(date: Date?) {
        addTimeText.text = DateToString(format: "dd MMM yyyy", date: date)
    }

    func getToTime(date: Date?) {
        toTXT.text = DateToString(format: "hh:mm a", date: date)

    }
    func getFromTime(date: Date?) {
        fromTXT.text = DateToString(format: "hh:mm a", date: date)
    }
    func DateToString(format: String, date: Date?)->String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let dateString = dateFormatter.string(from: date ?? Date())
        return dateString
    }
}
