//
//  AddJob3VC.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 8/6/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import UIKit
import Alamofire

class AddJob3VC: MainViewController {

    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var countryBtn: UIButton!
    @IBOutlet weak var cityBtn: UIButton!
    @IBOutlet weak var AreaBtn: UIButton!
    @IBOutlet weak var postalcodeText: UITextField!
    @IBOutlet weak var streetNumText: UITextField!
    @IBOutlet weak var moredetailsText: UITextView!
    @IBOutlet weak var NewxtView: UIView!
    @IBOutlet weak var nextBtn: LoadingButton!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var addressBtn: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backBTN: UIButton!
    var selectedIndex = Int ()
    var itemOfSelected = 0
    let constant = Constants.shared
    let regularFont = UIFont.systemFont(ofSize: 16)
    let boldFont = UIFont.boldSystemFont(ofSize: 16)
    
    var listCity: [DataCityCodable]?
    var listArea: [DataAreaCodable]?

    var City_String = [String]()
    var Area_String = [String]()
    
    var City_Id = 0
    var Area_Id = 0
    var JopModel:GetEditJopPageDataCodable!
    override func viewDidLoad() {
        super.viewDidLoad()
        GetCity(id: Share.CountriesList?.first?.id ?? 0)
        setupText()
        Share.Job_AddressName = ["Address"]
//        addingGradientLayerToNavigationBar([#colorLiteral(red: 0.1607843137, green: 0.6705882353, blue: 0.8862745098, alpha: 1).cgColor, #colorLiteral(red: 0, green: 1, blue: 1, alpha: 1).cgColor])
        setup()
        if constant.isArabic(){
            backBTN.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
        self.addingGradientLayerToView([#colorLiteral(red: 0.1607843137, green: 0.6705882353, blue: 0.8862745098, alpha: 1).cgColor, #colorLiteral(red: 0, green: 1, blue: 1, alpha: 1).cgColor], view: topView)
        getJopData()
    }
    
    @IBAction func BackPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func countryPressed(_ sender: Any) {
         let theme = YBTextPickerAppearanceManager.init(
             pickerTitle         : "Country",
             titleFont           : boldFont,
             titleTextColor      : .white,
             titleBackground     : #colorLiteral(red: 0.7240439057, green: 0.6962934732, blue: 0.6956846118, alpha: 1),
             searchBarFont       : regularFont,
             searchBarPlaceholder: "Search",
            closeButtonTitle    : "Cancel".localized,
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
             
         let arrTheme = Share.CountriesListString
         let picker = YBTextPicker.init(with: arrTheme, appearance: theme, onCompletion: { (selectedIndexes, selectedValues) in
             if let selectedValue = selectedValues.first{
                self.countryBtn.setTitle(selectedValue, for: .normal)
                let selectitem = Share.CountriesList?.first(where: {$0.name == selectedValue})
                Share.Job_CountryId = selectitem?.id ?? 0
                self.GetCity(id: selectitem?.id ?? 0)
                self.SetupBtn()
                self.setupAddressBtn()
             }else{
                 
             }
         }, onCancel: {
                 
         })
         picker.show(withAnimation: .FromBottom)
    }
    
    
    @IBAction func cityPressed(_ sender: Any) {
         let theme = YBTextPickerAppearanceManager.init(
             pickerTitle         : "City",
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
             
         let arrTheme = City_String
         let picker = YBTextPicker.init(with: arrTheme, appearance: theme, onCompletion: { (selectedIndexes, selectedValues) in
             if let selectedValue = selectedValues.first{
                 self.cityBtn.setTitle(selectedValue, for: .normal)
                let selectitem = self.listCity?.first(where: {$0.name == selectedValue})
                self.City_Id = selectitem?.id ?? 0
                self.GetArea(id: selectitem?.id ?? 0)
                self.SetupBtn()
                self.setupAddressBtn()
             }else{
                 
             }
         }, onCancel: {
                 
         })
         picker.show(withAnimation: .FromBottom)
    }
    
    
    @IBAction func areaPressed(_ sender: Any) {
         let theme = YBTextPickerAppearanceManager.init(
             pickerTitle         : "Area",
             titleFont           : boldFont,
             titleTextColor      : .white,
             titleBackground     : #colorLiteral(red: 0.7240439057, green: 0.6962934732, blue: 0.6956846118, alpha: 1),
             searchBarFont       : regularFont,
             searchBarPlaceholder: "Search",
            closeButtonTitle    : "Cancel".localized,
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
             
         let arrTheme = Area_String
         let picker = YBTextPicker.init(with: arrTheme, appearance: theme, onCompletion: { (selectedIndexes, selectedValues) in
             if let selectedValue = selectedValues.first{
                 self.AreaBtn.setTitle(selectedValue, for: .normal)
                let selectitem = self.listArea?.first(where: {$0.name == selectedValue})
                self.Area_Id = selectitem?.id ?? 0
                 self.SetupBtn()
                 self.setupAddressBtn()
             }else{
                 
             }
         }, onCancel: {
                 
         })
         picker.show(withAnimation: .FromBottom)
    }
    
    @IBAction func RemovedPressed(_ sender: Any) {
        if Share.Job_AddressName.count <= 1{
            
        }else{
            print("Selected: \(itemOfSelected)")
            print("Job_Address: \(Share.Job_Address.count)")
            print("Job_AddressName: \(Share.Job_AddressName.count)")
            
            
            if Share.Job_Address.count == itemOfSelected{
                setData(id: 0, city: 0, Area: 0, Postal: "", Street: "", Details: "", Latitude: 0.0, Longitude: 0.0)
            }else{
                Share.Job_AddressName.remove(at: itemOfSelected)
                Share.Job_Address.remove(at: itemOfSelected)
                collectionview.reloadData()
                setData(id: 0, city: 0, Area: 0, Postal: "", Street: "", Details: "", Latitude: 0.0, Longitude: 0.0)
            }
        }
    }
    
    @IBAction func locationPressed(_ sender: Any) {
        let vc = Share.storyBoard.instantiateViewController(withIdentifier: "MapViewsPage") as! locationVC
        vc.delegate = self
        self.present(vc, animated: false, completion: nil)
        view.endEditing(true)
    }
    
    @IBAction func addAddressPressed(_ sender: Any) {
        let listAddress = AddressCodableJob(CountryId: Share.Job_CountryId, CityId: City_Id, AreaId: Area_Id, PostalCode: postalcodeText.text ?? "", Street: streetNumText.text ?? "", Details: moredetailsText.text ?? "", Latitude: Share.address_lat, Longitude: Share.address_long)
        Share.Job_Address.append(listAddress)
        itemOfSelected = 1 + itemOfSelected
        
        Share.Job_AddressName.append("Address")
        selectedIndex = selectedIndex + 1
        collectionview.reloadData()
        
        setData(id: 0, city: 0, Area: 0, Postal: "", Street: "", Details: "", Latitude: 0.0, Longitude: 0.0)
        cityBtn.isUserInteractionEnabled = true
        AreaBtn.isUserInteractionEnabled = true
        postalcodeText.isUserInteractionEnabled = true
        streetNumText.isUserInteractionEnabled = true
        moredetailsText.isUserInteractionEnabled = true
        countryBtn.isUserInteractionEnabled = true
    }
    
    @IBAction func nextPressed(_ sender: Any) {
        if Share.Job_Address.isEmpty == true{
            checked()
        }else{
            checked()
        }
    }
    
    func checked(){
        if  Share.Job_CountryId == 0{
            
        }else if City_Id == 0{
            
        }else if Area_Id == 0{
            
        }else if postalcodeText.text == ""{
            
        }else if streetNumText.text == ""{
            
        }else{
            let listAddress = AddressCodableJob(CountryId: Share.Job_CountryId, CityId: City_Id, AreaId: Area_Id, PostalCode: postalcodeText.text ?? "", Street: streetNumText.text ?? "", Details: moredetailsText.text ?? "", Latitude: Share.address_lat, Longitude: Share.address_long)
            Share.Job_Address.append(listAddress)
            AddJob(Title: Share.Job_Title, JobType: Share.Job_TypeId, CategoryId: Share.Job_CategoryId, Description: Share.Job_Description, IsJobMultiDays: false, DateTimes: Share.Job_DateTime, IsBreakAvailable: Share.Job_IsAvilable, IsBreakPaid: Share.Job_IsPaid, JobTimeType: 0, Photos: Share.Job_Image_String, ExpectedWorkingHours: Share.Job_ExpectedWork, WorkingHoursDescription: Share.Job_WorkingHoursDescription, PaymentMethod: Share.Job_PaymentMethod, PaymentType: Share.Job_PaymentType, Price: Share.Job_Price, NumberOfEmployees: Share.Job_WorkNumber, Addresses: Share.Job_Address, IsOnline: false)
        }
    }
    
    func setupText(){
        postalcodeText.addTarget(self, action: #selector(AddJob3VC.textFieldDidChange(_:)), for: .editingChanged)
        streetNumText.addTarget(self, action: #selector(AddJob3VC.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        SetupBtn()
        setupAddressBtn()
    }
    
    func setup(){
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.register(UINib(nibName: "AddAddressCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddAddressCell")
    }
    
    func SetupBtn(){
        if Share.Job_Address.isEmpty == true{
            self.NewxtView.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.12)
            self.nextBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.26), for: .normal)
            if  Share.Job_CountryId == 0{
                self.addressView.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.12)
                self.addressBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.26), for: .normal)
            }else if City_Id == 0{
                self.addressView.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.12)
                self.addressBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.26), for: .normal)
            }else if Area_Id == 0{
                self.addressView.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.12)
                self.addressBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.26), for: .normal)
            }else if postalcodeText.text == ""{
                self.addressView.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.12)
                self.addressBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.26), for: .normal)
            }else if streetNumText.text == ""{
                self.addressView.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.12)
                self.addressBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.26), for: .normal)
            }else{
                self.NewxtView.layer.backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.7019607843, blue: 0.8980392157, alpha: 1)
                self.nextBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
                self.addressView.layer.backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.7019607843, blue: 0.8980392157, alpha: 1)
                self.addressBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            }
        }else{
            self.NewxtView.layer.backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.7019607843, blue: 0.8980392157, alpha: 1)
            self.nextBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        }
    }
    func setupAddressBtn(){
        if  Share.Job_CountryId == 0{
            self.addressView.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.12)
            self.addressBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.26), for: .normal)
            }else if City_Id == 0{
            self.addressView.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.12)
            self.addressBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.26), for: .normal)
            }else if Area_Id == 0{
            self.addressView.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.12)
            self.addressBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.26), for: .normal)
        }else if postalcodeText.text == ""{
            self.addressView.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.12)
            self.addressBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.26), for: .normal)
        }else if streetNumText.text == ""{
            self.addressView.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.12)
            self.addressBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.26), for: .normal)
        }else{
            self.addressView.layer.backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.7019607843, blue: 0.8980392157, alpha: 1)
            self.addressBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        }
    }
}
extension AddJob3VC{
    func AddJob(Title: String, JobType: Int, CategoryId: Int, Description: String, IsJobMultiDays: Bool, DateTimes: [DateTimesCodable], IsBreakAvailable: Bool, IsBreakPaid: Bool, JobTimeType: Int, Photos: [String], ExpectedWorkingHours: String, WorkingHoursDescription: String, PaymentMethod: Int, PaymentType: Int, Price: Double, NumberOfEmployees: Int, Addresses: [AddressCodableJob], IsOnline: Bool){
        nextBtn.showLoading()
        AF.request(APIRouter.AddJobClientRouter(Title: Title, JobType: JobType, CategoryId: CategoryId, Description: Description, IsJobMultiDays: IsJobMultiDays, DateTimes: DateTimes, IsBreakAvailable: IsBreakAvailable, IsBreakPaid: IsBreakPaid, JobTimeType: JobTimeType, Photos: Photos, ExpectedWorkingHours: ExpectedWorkingHours, WorkingHoursDescription: WorkingHoursDescription, PaymentMethod: PaymentMethod, PaymentType: PaymentType, Price: Price, NumberOfEmployees: NumberOfEmployees, Addresses: Addresses, IsOnline: IsOnline, Auth: Share.savedToken as! String))
            .responseJSON(completionHandler: { (res) in
                print(res)
            })
            .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<MessageCode, AFError>) in
                switch response.result {
                    case .failure(let err):
                        print(err.localizedDescription)
                    case .success(let model):
                        if model.errorCode == 0 {
                            self.nextBtn.hideLoading()
                            self.ShareViewController(withIdentifier: "HomeSecreen")
                        }else{
                            self.nextBtn.hideLoading()
                            ErrorCode.instance.Code(Code: model.errorCode ?? 0)
                    }
                }
        })
    }
}
extension AddJob3VC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Share.Job_AddressName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AddAddressCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddAddressCell", for: indexPath) as! AddAddressCollectionViewCell
        cell.titlelb.text = Share.Job_AddressName[indexPath.row]
        cell.SelectedView.layer.backgroundColor = selectedIndex == indexPath.row ?   #colorLiteral(red: 0.5141925812, green: 0.5142051578, blue: 0.5141984224, alpha: 1) : #colorLiteral(red: 0.1209653392, green: 0.7701628208, blue: 0.9223280549, alpha: 0)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        collectionView.reloadData()
        itemOfSelected = indexPath.row
        print(itemOfSelected)

        
        print(indexPath.row)
        print(Share.Job_AddressName.count)

        if indexPath.row == Share.Job_AddressName.count - 1{
            setData(id: 0, city: 0, Area: 0, Postal: "", Street: "", Details: "", Latitude: 0.0, Longitude: 0.0)
            cityBtn.isUserInteractionEnabled = true
            AreaBtn.isUserInteractionEnabled = true
            postalcodeText.isUserInteractionEnabled = true
            streetNumText.isUserInteractionEnabled = true
            moredetailsText.isUserInteractionEnabled = true
            countryBtn.isUserInteractionEnabled = true
        }else{
            setData(id: Share.Job_Address[selectedIndex].CountryId ?? 0, city: Share.Job_Address[selectedIndex].CityId ?? 0, Area: Share.Job_Address[selectedIndex].AreaId ?? 0, Postal: Share.Job_Address[selectedIndex].PostalCode ?? "", Street: Share.Job_Address[selectedIndex].Street ?? "", Details: Share.Job_Address[selectedIndex].Details ?? "", Latitude: Share.Job_Address[selectedIndex].Latitude ?? 0.0, Longitude: Share.Job_Address[selectedIndex].Longitude ?? 0.0)
            cityBtn.isUserInteractionEnabled = false
            AreaBtn.isUserInteractionEnabled = false
            postalcodeText.isUserInteractionEnabled = false
            streetNumText.isUserInteractionEnabled = false
            moredetailsText.isUserInteractionEnabled = false
            countryBtn.isUserInteractionEnabled = false
        }
    }
}
extension AddJob3VC: LocationDelegate{
    func RetriveLocation(lat: Double, lng: Double, add: String) {
        Share.address_lat = lat
        Share.address_long = lng
    }
}
extension AddJob3VC{
    
    func setData(id: Int, city: Int, Area: Int, Postal: String, Street: String, Details: String, Latitude: Double, Longitude: Double){
        if id == 0{
            countryBtn.setTitle("Select Country", for: .normal)
        }else{
            let selectitem = Share.CountriesList?.first(where: {$0.id == id})
            countryBtn.setTitle(selectitem?.name ?? "", for: .normal)
        }
        let selectitemCity = listCity?.first(where: {$0.id == City_Id})
        cityBtn.setTitle(selectitemCity?.name ?? "", for: .normal)
        
        let selectitemArea = listArea?.first(where: {$0.id == Area_Id})
        AreaBtn.setTitle(selectitemArea?.name ?? "", for: .normal)
        
        postalcodeText.text = Postal
        streetNumText.text = Street
        moredetailsText.text = Details
        Share.address_lat = Latitude
        Share.address_long = Longitude
    }
}
extension AddJob3VC{
    func GetCity(id: Int){
        self.City_String.removeAll()
        self.Area_String.removeAll()
        showProgress()
        AF.request(APIRouter.GetCityRouter(CountryId: id, lang: constant.getCurrentLanguage()))
            .responseJSON(completionHandler: { (res) in
                print(res)
            })
            .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<CityCodable, AFError>) in
                self.dismisProgress()
                switch response.result {
                    case .failure(let err):
                        print(err.localizedDescription)
                    case .success(let model):
                        if model.errorCode == 0 {
                            model.data?.forEach({ (item) in
                                self.City_String.append(item.name ?? "")
                            })
                            self.City_Id = model.data?.first?.id ?? 0
                            self.listCity = model.data
                            self.GetArea(id: self.City_Id)
                        }else{
                            ErrorCode.instance.Code(Code: model.errorCode ?? 0)
                    }
                }
        })
    }
    func GetArea(id: Int){
        self.Area_String.removeAll()
        showProgress()
        AF.request(APIRouter.GetAreaRouter(CityId: id, lang: constant.getCurrentLanguage()))
            .responseJSON(completionHandler: { (res) in
                print(res)
            })
            .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<AreaCodable, AFError>) in
                self.dismisProgress()
                switch response.result {
                    case .failure(let err):
                        print(err.localizedDescription)
                    case .success(let model):
                        if model.errorCode == 0 {
                            model.data?.forEach({ (item) in
                                self.Area_String.append(item.name ?? "")
                            })
                            self.Area_Id = model.data?.first?.id ?? 0
                            self.listArea = model.data
                        }else{
                            ErrorCode.instance.Code(Code: model.errorCode ?? 0)
                    }
                }
        })
    }
}
extension AddJob3VC{
    func getJopData(){
        if JopModel != nil{
        }
    }
}
