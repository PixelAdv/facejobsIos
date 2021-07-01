//
//  jobViewController.swift
//  Face Jobs
//
//  Created by Apple on 3/24/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
//

import UIKit

class jobViewController: MainViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backBTN: UIButton!
    @IBOutlet weak var contanierView: UIView!
    @IBOutlet weak var scrollerView: UIScrollView!
    @IBOutlet weak var titleLBL: UILabel!
    @IBOutlet weak var catioryLBL: UILabel!
    @IBOutlet weak var descriptionLBL: UILabel!
    @IBOutlet weak var typeLBL: UILabel!
    @IBOutlet weak var catgoryTXT: TappedTextField!
    @IBOutlet weak var typeTxt: TappedTextField!
    @IBOutlet weak var titelTXT: UITextField!
    @IBOutlet weak var descriptionTxt: UITextView!
    @IBOutlet weak var photoCollecction: UICollectionView!
    @IBOutlet weak var fromTXT: TappedTextField!
    @IBOutlet weak var toTXT: TappedTextField!
    @IBOutlet weak var workingHoursTXT: UITextField!
    @IBOutlet weak var workingHoursDes: UITextView!
    @IBOutlet weak var paymentMethod: TappedTextField!
    @IBOutlet weak var priceTXT: TappedTextField!
    @IBOutlet weak var valueTXT: UITextField!
    @IBOutlet weak var numberOfWorkers: UITextField!
    @IBOutlet weak var country: TappedTextField!
    @IBOutlet weak var cityTXXT: TappedTextField!
    @IBOutlet weak var valiageTXT: TappedTextField!
    @IBOutlet weak var moreDetailsTXT: UITextField!
    @IBOutlet weak var streetTxt: UITextField!
    @IBOutlet weak var postalCode: UITextField!
    @IBOutlet weak var previousBTN: UIButton!
    @IBOutlet weak var nextBTN: UIButton!
    @IBOutlet weak var timeTable: UITableView!
    @IBOutlet weak var timeTableHight: NSLayoutConstraint!
    @IBOutlet weak var addTimeText: TappedTextField!
    @IBOutlet weak var avilableStack: UIStackView!
    @IBOutlet weak var paidStack: UIStackView!
    @IBOutlet weak var avilableBTN: UIButton!
    @IBOutlet weak var paidBTN: UIButton!
    @IBOutlet weak var locationLBL: UILabel!
    @IBOutlet weak var addLocationBTN: UIButton!
    @IBOutlet weak var addressCollection: UICollectionView!
    @IBOutlet weak var containerStack: UIStackView!
    // properties
    var imagePicker: ImagePicker!
    var XPoint = 0
    let cellIdentifier = "AddJobImageCell"
    var JobImages: [UIImage] = [UIImage]()
    var jobsImagesString: [String] = [String]()
    var secondScreenWidth = 0
    var thirdScreenWidth = 0
    let timeCellIdentifier = "JobTimeCell"
    var Datas:[DateTimesCodable] = [DateTimesCodable]()
    var dataPicker: UIDatePicker?
    let currentDate = Date()
    var Time1Picker: UIDatePicker?
    var Time2Picker: UIDatePicker?
    var isAvilable = false
    var isPaid = false
    var typesModel: [Types] = [Types]()
    var typeID = 0
    var catigoryModel: [Categories] = [Categories]()
    var catigoryID = 0
    var payments: [PaymentMethods] = [PaymentMethods]()
    var paymentID = 0
    var prices: [PriceTypes] = [PriceTypes]()
    var priceID = 0
    var countriesModel: [Countries] = [Countries]()
    var coutryID = 0
    var citiesModel:[DataCityCodable] = [DataCityCodable]()
    var CityID = 0
    var areaModel: [DataAreaCodable] = [DataAreaCodable]()
    var areaID = 0
    var addresses: [AddressCodableJob] = [AddressCodableJob]()
    var latidute: Double?
    var longtidue: Double?
    var arr: [[String: String]] = [[String: String]]()
    // edit Job
    var isEdit = false
    var jobData: EditJobModel?
    var jobID: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setConersToView()
        setUpCcollectionView()
        setUpTableView()
        setUpDate()
        setDelegateToviewController()
        setUpAdressCollectionView()
        IsEditJob()
        setDelegate()
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        
    }
    // ACTIONS
    @IBAction func avilableBTNTapped(_ sender: UIButton) {
        if sender.isSelected == true {
            sender.isSelected = false
            avilableBTN.setImage(UIImage(named: "Checkbox empty"), for: .normal)
            paidBTN.setImage(UIImage(named: "Checkbox empty"), for: .normal)
            isAvilable = false
            paidStack.isHidden = true
            paidBTN.isSelected = false
        }else {
            
            sender.isSelected = true
            avilableBTN.setImage(UIImage(named: "Checkbox fill"), for: .normal)
            paidBTN.setImage(UIImage(named: "Checkbox empty"), for: .normal)
            isAvilable = true
            paidStack.isHidden = false
            paidBTN.isSelected = false
        }
    }
    
    @IBAction func paidBTN(_ sender: UIButton) {
        if sender.isSelected == true {
            sender.isSelected = false
            paidBTN.setImage(UIImage(named: "Checkbox empty"), for: .normal)
            isPaid = false
        }else {
            sender.isSelected = true
            paidBTN.setImage(UIImage(named: "Checkbox fill"), for: .normal)
            isPaid = true
        }
    }
    
    @IBAction func applayTapped(_ sender: Any) {
        addLocationBTN.titleLabel?.textColor = .white
        if let postalCode = postalCode.text, !postalCode.isEmpty, let street = streetTxt.text, !street.isEmpty{
            guard let longtidueData = longtidue, let LatitudeData = latidute else {
                addLocationBTN.titleLabel?.textColor = .red
                AlertView.instance.showAlert(message: "selectFromMap".localized, alertType: .failure)
                return
            }
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
    @IBAction func addNewAddress(_ sender: Any) {
        guard let latiduteData = latidute, let longtidueData = longtidue else {
            AlertView.instance.showAlert(message: "selectFromMap".localized, alertType: .failure)
            return
        }
        let address = AddressCodableJob(CountryId: coutryID, CityId: CityID, AreaId: areaID, PostalCode: postalCode.text ?? "", Street: streetTxt.text ?? "", Details: moreDetailsTXT.text ?? "", Latitude: latiduteData, Longitude: longtidueData)
        addresses.append(address)
        latidute = 0.0
        longtidue = 0.0
        streetTxt.text = ""
        postalCode.text = ""
        moreDetailsTXT.text = ""
        locationLBL.text = ""
    }
    @IBAction func removeLocation(_ sender: Any) {
        guard let latiduteData = latidute, let longtidueData = longtidue else {
            AlertView.instance.showAlert(message: "selectFromMap".localized, alertType: .failure)
            return
        }
        let address = AddressCodableJob(CountryId: coutryID, CityId: CityID, AreaId: areaID, PostalCode: postalCode.text ?? "", Street: streetTxt.text ?? "", Details: moreDetailsTXT.text ?? "", Latitude: latiduteData, Longitude: longtidueData)
        addresses.append(address)
        latidute = nil
        longtidue = nil
        streetTxt.text = ""
        postalCode.text = ""
        moreDetailsTXT.text = ""
        locationLBL.text = ""
        DispatchQueue.main.async {
            self.locationLBL.text = ""
        }
    }
    
    @IBAction func addLoctionTapped(_ sender: Any) {
        let vc = Share.storyBoard.instantiateViewController(withIdentifier: "MapViewsPage") as! locationVC
        vc.delegate = self
        self.present(vc, animated: false, completion: nil)
        view.endEditing(true)
    }
    @IBAction func AddTimeTapped(_ sender: Any) {
        Datas.append(DateTimesCodable(Day: addTimeText.text ?? "", TimeFrom: fromTXT.text ?? "", TimeTo: toTXT.text ?? ""))
            self.timeTableHight.constant = CGFloat((Datas.count)*40)
            timeTable.isHidden = false
            timeTable.reloadData()
    }
    @IBAction func removeTimeTapped(_ sender: Any) {
      
    }
    @IBAction func addphotoTapped(_ sender: Any) {
        chooseImage()
    }
    @IBAction func previousBtnTapped(_ sender: Any) {
        secondScreenWidth = Int(self.contanierView.bounds.width)
        thirdScreenWidth = Int(self.contanierView.bounds.width * 2)
        nextBTN.setTitle("next".localized, for: .normal)
        if XPoint == 0 {
            nextBTN.setTitle("next".localized, for: .normal)
            scrollerView.setContentOffset(CGPoint(x: XPoint, y: 0), animated: false)
        }
        else if XPoint == secondScreenWidth
        {
            nextBTN.setTitle("next".localized, for: .normal)
            XPoint = XPoint - Int(self.contanierView.bounds.width)
            scrollerView.setContentOffset(CGPoint(x: XPoint, y: 0), animated: true)

        }
        else if XPoint == thirdScreenWidth {
            XPoint = secondScreenWidth
            scrollerView.setContentOffset(CGPoint(x: XPoint, y: 0), animated:    true)
        }
    }
    
    @IBAction func NextBtnTapped(_ sender: Any) {
        
        secondScreenWidth = Int(self.contanierView.bounds.width)
        thirdScreenWidth = Int(self.contanierView.bounds.width * 2)
        nextBTN.setTitle("next".localized, for: .normal)
        if XPoint == secondScreenWidth {
            if checkDataForSeccondView(){
            XPoint = thirdScreenWidth
            scrollerView.setContentOffset(CGPoint(x: XPoint, y: 0), animated:    true)
                nextBTN.setTitle("applay_job".localized, for: .normal)
            }
        }
        else if XPoint == thirdScreenWidth
        {
            scrollerView.setContentOffset(CGPoint(x: XPoint, y: 0), animated: false)
            if isEdit{
//                /addNewJob()
                edit_Job()
            }
            else {
            addNewJob()
            }
        }
        else {
            if checkDataForFirstView()
            {
            XPoint = secondScreenWidth
            scrollerView.setContentOffset(CGPoint(x: XPoint, y: 0), animated:    true)
            }
        }
       
    }
    
    @IBAction func backBTN_Tapped(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
        
    }
}

extension jobViewController: LocationDelegate {
    func RetriveLocation(lat: Double, lng: Double, add: String) {
        locationLBL.text = add
        longtidue = lng
        latidute = lat
    }
}
