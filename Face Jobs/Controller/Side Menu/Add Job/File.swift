//
//  File.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 8/23/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

//import Foundation
////
////  AddJob3VC.swift
////  Face Jobs
////
////  Created by Eslam Hassan on 8/6/20.
////  Copyright © 2020 Eslam Hassan. All rights reserved.
////
//
//import MOLH
//import UIKit
//import Alamofire
//
//class AddJob3VC: UIViewController {
//
//    @IBOutlet weak var ScrollView: UIScrollView!
//    
//    @IBOutlet weak var collectionview: UICollectionView!
//    @IBOutlet weak var collectionviewList: UICollectionView!
//
//    @IBOutlet weak var countryBtn: UIButton!
//    @IBOutlet weak var cityText: UITextField!
//    @IBOutlet weak var villageText: UITextField!
//    @IBOutlet weak var postalcodeText: UITextField!
//    @IBOutlet weak var streetNumText: UITextField!
//
//    @IBOutlet weak var moredetailsText: UITextView!
//    
//    @IBOutlet weak var NewxtView: UIView!
//    @IBOutlet weak var nextBtn: UIButton!
//    
//    @IBOutlet weak var addressView: UIView!
//    @IBOutlet weak var addressBtn: UIButton!
//
//    var selectedIndex = Int ()
//    var itemOf = 1
//    
//    let regularFont = UIFont.systemFont(ofSize: 16)
//    let boldFont = UIFont.boldSystemFont(ofSize: 16)
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupText()
//        Share.Job_AddressName = ["1 Address"]
//        addingGradientLayerToNavigationBar([#colorLiteral(red: 0.1607843137, green: 0.6705882353, blue: 0.8862745098, alpha: 1).cgColor, #colorLiteral(red: 0, green: 1, blue: 1, alpha: 1).cgColor])
//        setup()
//    }
//    @IBAction func RemoveAddressPressed(_ sender: Any) {
////        let tag:NSInteger = selectedIndex
////        let indexPath = IndexPath(row: tag, section: 0)
////        let cell = self.collectionview.cellForRow(at: indexPath) as! AddAddressCollectionViewCell
//        Share.Job_Address.remove(at: selectedIndex)
//             itemOf = itemOf - 1
//             Share.Job_AddressName.append("\(itemOf) Address")
//             selectedIndex = selectedIndex + 1
//             collectionview.reloadData()
//             setData(id: 0, city: "", Area: "", Postal: "", Street: "", Details: "", Latitude: 0.0, Longitude: 0.0)
//    }
//    
//    @IBAction func BackPressed(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
//    }
//    @IBAction func countryPressed(_ sender: Any) {
//         let theme = YBTextPickerAppearanceManager.init(
//             pickerTitle         : "Categories",
//             titleFont           : boldFont,
//             titleTextColor      : .white,
//             titleBackground     : #colorLiteral(red: 0.7240439057, green: 0.6962934732, blue: 0.6956846118, alpha: 1),
//             searchBarFont       : regularFont,
//             searchBarPlaceholder: "Search",
//             closeButtonTitle    : "Cancel",
//             closeButtonColor    : .darkGray,
//             closeButtonFont     : regularFont,
//             doneButtonTitle     : "Done",
//             doneButtonColor     : #colorLiteral(red: 0.7240439057, green: 0.6962934732, blue: 0.6956846118, alpha: 1),
//             doneButtonFont      : boldFont,
//             checkMarkPosition   : .Right,
//             itemCheckedImage    : nil,
//             itemUncheckedImage  : nil,
//             itemColor           : .black,
//             itemFont            : regularFont
//         )
//             
//         let arrTheme = Share.CountriesListString
//         let picker = YBTextPicker.init(with: arrTheme, appearance: theme, onCompletion: { (selectedIndexes, selectedValues) in
//             if let selectedValue = selectedValues.first{
//                 self.countryBtn.setTitle(selectedValue, for: .normal)
//                 let selectitem = Share.CountriesList?.first(where: {$0.name == selectedValue})
//                 Share.Job_CountryId = selectitem?.id ?? 0
//                 print(selectitem?.id ?? 0)
//                 self.SetupBtn()
//                 self.setupAddressBtn()
//             }else{
//                 
//             }
//         }, onCancel: {
//                 
//         })
//         picker.show(withAnimation: .FromBottom)
//    }
//    
//    @IBAction func locationPressed(_ sender: Any) {
//        let vc = Share.storyBoard.instantiateViewController(withIdentifier: "MapViewsPage") as! locationVC
//        vc.delegate = self
//        self.present(vc, animated: false, completion: nil)
//        view.endEditing(true)
//    }
//    
//    @IBAction func addAddressPressed(_ sender: Any) {
//        let listAddress = AddressCodableJob(CountryId: Share.Job_CountryId, CityId: cityText.text ?? "", AreaId: villageText.text ?? "", PostalCode: postalcodeText.text ?? "", Street: streetNumText.text ?? "", Details: moredetailsText.text ?? "", Latitude: Share.address_lat, Longitude: Share.address_long)
//        Share.Job_Address.append(listAddress)
//        itemOf = 1 + itemOf
//        Share.Job_AddressName.append("\(itemOf) Address")
//        selectedIndex = selectedIndex + 1
//        collectionview.reloadData()
//        setData(id: 0, city: "", Area: "", Postal: "", Street: "", Details: "", Latitude: 0.0, Longitude: 0.0)
//    }
//    
//    @IBAction func nextPressed(_ sender: Any) {
//        if Share.Job_Address.isEmpty == true{
//            checked()
//        }else{
//            checked()
//        }
//    }
//    func checked(){
//        if  Share.Job_CountryId == 0{
//            
//        }else if cityText.text?.isEmpty == true{
//            
//        }else if villageText.text == ""{
//            
//        }else if postalcodeText.text == ""{
//            
//        }else if streetNumText.text == ""{
//            
//        }else{
//            let listAddress = AddressCodableJob(CountryId: Share.Job_CountryId, CityId: cityText.text ?? "", AreaId: villageText.text ?? "", PostalCode: postalcodeText.text ?? "", Street: streetNumText.text ?? "", Details: moredetailsText.text ?? "", Latitude: Share.address_lat, Longitude: Share.address_long)
//            Share.Job_Address.append(listAddress)
//            AddJob(Title: Share.Job_Title, JobType: Share.Job_TypeId, CategoryId: Share.Job_CategoryId, Description: Share.Job_Description, IsJobMultiDays: false, DateTimes: Share.Job_DateTime, IsBreakAvailable: Share.Job_IsAvilable, IsBreakPaid: Share.Job_IsPaid, JobTimeType: 0, Photos: Share.Job_Image_String, ExpectedWorkingHours: Share.Job_ExpectedWork, WorkingHoursDescription: Share.Job_WorkingHoursDescription, PaymentMethod: Share.Job_PaymentMethod, PaymentType: Share.Job_PaymentType, Price: Share.Job_Price, NumberOfEmployees: Share.Job_WorkNumber, Addresses: Share.Job_Address, IsOnline: false)
//        }
//    }
//    
//    func setupText(){
//        cityText.addTarget(self, action: #selector(AddJob3VC.textFieldDidChange(_:)), for: .editingChanged)
//        villageText.addTarget(self, action: #selector(AddJob3VC.textFieldDidChange(_:)), for: .editingChanged)
//        postalcodeText.addTarget(self, action: #selector(AddJob3VC.textFieldDidChange(_:)), for: .editingChanged)
//        streetNumText.addTarget(self, action: #selector(AddJob3VC.textFieldDidChange(_:)), for: .editingChanged)
//    }
//    @objc func textFieldDidChange(_ textField: UITextField) {
//        SetupBtn()
//        setupAddressBtn()
//    }
//    
//    func setup(){
//        collectionview.delegate = self
//        collectionview.dataSource = self
//        
//        collectionviewList.delegate = self
//        collectionviewList.dataSource = self
//    }
//    
//    func SetupBtn(){
//        if Share.Job_Address.isEmpty == true{
//            self.NewxtView.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.12)
//            self.nextBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.26), for: .normal)
//            if  Share.Job_CountryId == 0{
//                self.addressView.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.12)
//                self.addressBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.26), for: .normal)
//            }else if cityText.text?.isEmpty == true{
//                self.addressView.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.12)
//                self.addressBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.26), for: .normal)
//            }else if villageText.text == ""{
//                self.addressView.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.12)
//                self.addressBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.26), for: .normal)
//            }else if postalcodeText.text == ""{
//                self.addressView.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.12)
//                self.addressBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.26), for: .normal)
//            }else if streetNumText.text == ""{
//                self.addressView.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.12)
//                self.addressBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.26), for: .normal)
//            }else{
//                self.NewxtView.layer.backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.7019607843, blue: 0.8980392157, alpha: 1)
//                self.nextBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
//                self.addressView.layer.backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.7019607843, blue: 0.8980392157, alpha: 1)
//                self.addressBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
//            }
//        }else{
//            self.NewxtView.layer.backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.7019607843, blue: 0.8980392157, alpha: 1)
//            self.nextBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
//        }
//    }
//    func setupAddressBtn(){
//        if  Share.Job_CountryId == 0{
//            self.addressView.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.12)
//            self.addressBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.26), for: .normal)
//        }else if cityText.text?.isEmpty == true{
//            self.addressView.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.12)
//            self.addressBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.26), for: .normal)
//        }else if villageText.text == ""{
//            self.addressView.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.12)
//            self.addressBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.26), for: .normal)
//        }else if postalcodeText.text == ""{
//            self.addressView.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.12)
//            self.addressBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.26), for: .normal)
//        }else if streetNumText.text == ""{
//            self.addressView.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.12)
//            self.addressBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.26), for: .normal)
//        }else{
//            self.addressView.layer.backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.7019607843, blue: 0.8980392157, alpha: 1)
//            self.addressBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
//        }
//    }
//}
//extension AddJob3VC{
//    func AddJob(Title: String, JobType: Int, CategoryId: Int, Description: String, IsJobMultiDays: Bool, DateTimes: [DateTimesCodable], IsBreakAvailable: Bool, IsBreakPaid: Bool, JobTimeType: Int, Photos: [String], ExpectedWorkingHours: String, WorkingHoursDescription: String, PaymentMethod: Int, PaymentType: Int, Price: Double, NumberOfEmployees: Int, Addresses: [AddressCodableJob], IsOnline: Bool){
//        AF.request(APIRouter.AddJobClientRouter(Title: Title, JobType: JobType, CategoryId: CategoryId, Description: Description, IsJobMultiDays: IsJobMultiDays, DateTimes: DateTimes, IsBreakAvailable: IsBreakAvailable, IsBreakPaid: IsBreakPaid, JobTimeType: JobTimeType, Photos: Photos, ExpectedWorkingHours: ExpectedWorkingHours, WorkingHoursDescription: WorkingHoursDescription, PaymentMethod: PaymentMethod, PaymentType: PaymentType, Price: Price, NumberOfEmployees: NumberOfEmployees, Addresses: Addresses, IsOnline: IsOnline, Auth: Share.savedToken as! String))
//            .responseJSON(completionHandler: { (res) in
//                print(res)
//            })
//            .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<MessageCode, AFError>) in
//                switch response.result {
//                    case .failure(let err):
//                        print(err.localizedDescription)
//                    case .success(let model):
//                        if model.errorCode == 0 {
//
//                        }else{
//                            ErrorCode.instance.Code(Code: model.errorCode ?? 0)
//                    }
//                }
//        })
//    }
//}
//extension AddJob3VC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if collectionView == collectionview{
//            return Share.Job_AddressName.count
//        }else{
//            return 1
//        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if collectionView == collectionview{
//            collectionview.register(UINib(nibName: "AddAddressCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddAddressCell")
//            let cell: AddAddressCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddAddressCell", for: indexPath) as! AddAddressCollectionViewCell
//            cell.titlelb.text = Share.Job_AddressName[indexPath.row]
//            cell.SelectedView.layer.backgroundColor = selectedIndex == indexPath.row ?   #colorLiteral(red: 0.5141925812, green: 0.5142051578, blue: 0.5141984224, alpha: 1) : #colorLiteral(red: 0.1209653392, green: 0.7701628208, blue: 0.9223280549, alpha: 0)
//            return cell
//        }else{
//            collectionviewList.register(UINib(nibName: "AddressListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddressListCell")
//            let cell: AddressListCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddressListCell", for: indexPath) as! AddressListCollectionViewCell
//            
//            cell.countryBtn.addTarget(self, action: #selector(connectedCountry(sender:)), for: .touchUpInside)
//            cell.countryBtn.tag = indexPath.row
//            
//            cell.addLocationBtn.addTarget(self, action: #selector(connectedAddLocation(sender:)), for: .touchUpInside)
//            cell.addLocationBtn.tag = indexPath.row
//            
//            cell.RemoveBtn.addTarget(self, action: #selector(connectedDeleteItem(sender:)), for: .touchUpInside)
//            cell.RemoveBtn.tag = indexPath.row
//            return cell
//        }
//
//    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if collectionView == collectionview{
//            selectedIndex = indexPath.row
//            collectionView.reloadData()
//            if Share.Job_AddressName.last == Share.Job_AddressName[indexPath.row]{
//                setData(id: 0, city: "", Area: "", Postal: "", Street: "", Details: "", Latitude: 0.0, Longitude: 0.0)
//            }else{
//                setData(id: Share.Job_Address[selectedIndex].CountryId ?? 0, city: Share.Job_Address[selectedIndex].CityId ?? "", Area: Share.Job_Address[selectedIndex].AreaId ?? "", Postal: Share.Job_Address[selectedIndex].PostalCode ?? "", Street: Share.Job_Address[selectedIndex].Street ?? "", Details: Share.Job_Address[selectedIndex].Details ?? "", Latitude: Share.Job_Address[selectedIndex].Latitude ?? 0.0, Longitude: Share.Job_Address[selectedIndex].Longitude ?? 0.0)
//            }
//            print(selectedIndex)
//        }else{
//            
//        }
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if collectionView == collectionview{
//            let cellSize = CGSize(width: (collectionView.frame.width), height: (collectionView.frame.height))
//            return cellSize
//        }else{
//            let cellSize = CGSize(width: (collectionviewList.frame.width), height: (collectionviewList.frame.height))
//            return cellSize
//        }
//    }
//    @objc func connectedDeleteItem(sender: UIButton){
//        let tag:NSInteger = sender.tag
//        let indexPath = IndexPath(row: tag, section: 0)
//        let cell = self.collectionviewList.cellForItem(at: indexPath) as? AddressListCollectionViewCell
//        
////        if
//        
//        
//        
//        
//        Share.Job_Address.remove(at: selectedIndex)
//        itemOf = itemOf - 1
//        Share.Job_AddressName.append("\(itemOf) Address")
//        selectedIndex = selectedIndex + 1
//        collectionview.reloadData()
//        setData(id: 0, city: "", Area: "", Postal: "", Street: "", Details: "", Latitude: 0.0, Longitude: 0.0)
//        collectionviewList.reloadData()
//    }
//    @objc func connectedAddLocation(sender: UIButton){
//        let vc = Share.storyBoard.instantiateViewController(withIdentifier: "MapViewsPage") as! locationVC
//        vc.delegate = self
//        self.present(vc, animated: false, completion: nil)
//        view.endEditing(true)
//    }
//    
//    @objc func connectedCountry(sender: UIButton){
//        let theme = YBTextPickerAppearanceManager.init(
//            pickerTitle         : "Categories",
//            titleFont           : boldFont,
//            titleTextColor      : .white,
//            titleBackground     : #colorLiteral(red: 0.7240439057, green: 0.6962934732, blue: 0.6956846118, alpha: 1),
//            searchBarFont       : regularFont,
//            searchBarPlaceholder: "Search",
//            closeButtonTitle    : "Cancel",
//            closeButtonColor    : .darkGray,
//            closeButtonFont     : regularFont,
//            doneButtonTitle     : "Done",
//            doneButtonColor     : #colorLiteral(red: 0.7240439057, green: 0.6962934732, blue: 0.6956846118, alpha: 1),
//            doneButtonFont      : boldFont,
//            checkMarkPosition   : .Right,
//            itemCheckedImage    : nil,
//            itemUncheckedImage  : nil,
//            itemColor           : .black,
//            itemFont            : regularFont
//        )
//            
//        let arrTheme = Share.CountriesListString
//        let picker = YBTextPicker.init(with: arrTheme, appearance: theme, onCompletion: { (selectedIndexes, selectedValues) in
//            if let selectedValue = selectedValues.first{
//                let tag:NSInteger = sender.tag
//                let indexPath = IndexPath(row: tag, section: 0)
//                let cell = self.collectionviewList.cellForItem(at: indexPath) as? AddressListCollectionViewCell
//                cell?.countryBtn.setTitle(selectedValue, for: .normal)
//                let selectitem = Share.CountriesList?.first(where: {$0.name == selectedValue})
//                Share.Job_CountryId = selectitem?.id ?? 0
//                print(selectitem?.id ?? 0)
//                self.SetupBtn()
//                self.setupAddressBtn()
//            }else{
//                
//            }
//        }, onCancel: {
//                
//        })
//        picker.show(withAnimation: .FromBottom)
//    }
//}
//extension AddJob3VC: LocationDelegate{
//    func RetriveLocation(lat: Double, lng: Double, add: String) {
//        print(lat)
//        print(lng)
//        print(add)
//        Share.address_lat = lat
//        Share.address_long = lng
//    }
//}
//extension AddJob3VC{
//    
//    func setData(id: Int, city: String, Area: String, Postal: String, Street: String, Details: String, Latitude: Double, Longitude: Double){
//        if id == 0{
//            countryBtn.setTitle("Select Country", for: .normal)
//        }else{
//            let selectitem = Share.CountriesList?.first(where: {$0.id == id})
//            countryBtn.setTitle(selectitem?.name ?? "", for: .normal)
//        }
//        cityText.text = city
//        villageText.text = Area
//        postalcodeText.text = Postal
//        streetNumText.text = Street
//        moredetailsText.text = Details
//        Share.address_lat = Latitude
//        Share.address_long = Longitude
//    }
//}



/*
 //
 //  AddJob3VC.swift
 //  Face Jobs
 //
 //  Created by Eslam Hassan on 8/6/20.
 //  Copyright © 2020 Eslam Hassan. All rights reserved.
 //

 import MOLH
 import UIKit
 import Alamofire

 class AddJob3VC: UIViewController {

     @IBOutlet weak var ScrollView: UIScrollView!
     
     @IBOutlet weak var collectionview: UICollectionView!
     @IBOutlet weak var collectionviewList: UICollectionView!
     
     @IBOutlet weak var NewxtView: UIView!
     @IBOutlet weak var nextBtn: UIButton!
     
     @IBOutlet weak var addressView: UIView!
     @IBOutlet weak var addressBtn: UIButton!

     var selectedIndex = Int ()
     var itemOf = 1
     
     let regularFont = UIFont.systemFont(ofSize: 16)
     let boldFont = UIFont.boldSystemFont(ofSize: 16)
     
     override func viewDidLoad() {
         super.viewDidLoad()
         Share.Job_AddressName = ["\(itemOf) Address"]
         addingGradientLayerToNavigationBar([#colorLiteral(red: 0.1607843137, green: 0.6705882353, blue: 0.8862745098, alpha: 1).cgColor, #colorLiteral(red: 0, green: 1, blue: 1, alpha: 1).cgColor])
         setup()
     }
     
     @IBAction func BackPressed(_ sender: Any) {
         dismiss(animated: true, completion: nil)
     }
     
     @IBAction func addAddressPressed(_ sender: Any) {
         let listAddress = AddressCodableJob(CountryId: Share.Job_CountryId, CityId: cityText.text ?? "", AreaId: villageText.text ?? "", PostalCode: postalcodeText.text ?? "", Street: streetNumText.text ?? "", Details: moredetailsText.text ?? "", Latitude: Share.address_lat, Longitude: Share.address_long)
         Share.Job_Address.append(listAddress)
         itemOf = 1 + itemOf
         Share.Job_AddressName.append("\(itemOf) Address")
         selectedIndex = selectedIndex + 1
         collectionview.reloadData()
         setData(index: <#Int#>, id: 0, city: "", Area: "", Postal: "", Street: "", Details: "", Latitude: 0.0, Longitude: 0.0)
     }
     
     @IBAction func nextPressed(_ sender: Any) {
         if Share.Job_Address.isEmpty == true{
             let tag:NSInteger = 0
             let indexPath = IndexPath(row: tag, section: 0)
             let cell = self.collectionviewList.cellForItem(at: indexPath) as? AddressListCollectionViewCell
             
             if Share.Job_CountryId == 0{
                 
             }else if cell?.cityText.text == ""{
                 
             }else if cell?.villageText.text == ""{
                 
             }else if cell?.postalcodeText.text == ""{
                 
             }else if cell?.streetNumText.text == ""{
                 
             }else{
                 checked(CountryId: Share.Job_CountryId, CityId: cell?.cityText.text ?? "", AreaId: cell?.villageText.text ?? "", PostalCode: cell?.postalcodeText.text ?? "", Street: cell?.streetNumText.text ?? "", Details: cell?.moredetailsText.text ?? "", Latitude: Share.address_lat, Longitude: Share.address_long)
             }
         }else{
             AddJob(Title: Share.Job_Title, JobType: Share.Job_TypeId, CategoryId: Share.Job_CategoryId, Description: Share.Job_Description, IsJobMultiDays: false, DateTimes: Share.Job_DateTime, IsBreakAvailable: Share.Job_IsAvilable, IsBreakPaid: Share.Job_IsPaid, JobTimeType: 0, Photos: Share.Job_Image_String, ExpectedWorkingHours: Share.Job_ExpectedWork, WorkingHoursDescription: Share.Job_WorkingHoursDescription, PaymentMethod: Share.Job_PaymentMethod, PaymentType: Share.Job_PaymentType, Price: Share.Job_Price, NumberOfEmployees: Share.Job_WorkNumber, Addresses: Share.Job_Address, IsOnline: false)
         }
     }
     
     func checked(CountryId: Int, CityId: String, AreaId: String, PostalCode: String, Street: String, Details: String, Latitude: Double, Longitude: Double){
         let listAddress = AddressCodableJob(CountryId: CountryId, CityId: CityId, AreaId: AreaId, PostalCode: PostalCode, Street: Street, Details: Details, Latitude: Latitude, Longitude: Longitude)
         Share.Job_Address.append(listAddress)
         AddJob(Title: Share.Job_Title, JobType: Share.Job_TypeId, CategoryId: Share.Job_CategoryId, Description: Share.Job_Description, IsJobMultiDays: false, DateTimes: Share.Job_DateTime, IsBreakAvailable: Share.Job_IsAvilable, IsBreakPaid: Share.Job_IsPaid, JobTimeType: 0, Photos: Share.Job_Image_String, ExpectedWorkingHours: Share.Job_ExpectedWork, WorkingHoursDescription: Share.Job_WorkingHoursDescription, PaymentMethod: Share.Job_PaymentMethod, PaymentType: Share.Job_PaymentType, Price: Share.Job_Price, NumberOfEmployees: Share.Job_WorkNumber, Addresses: Share.Job_Address, IsOnline: false)
     }
     
     func SetupBtn(){
         if Share.Job_Address.isEmpty == true{
             self.NewxtView.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.12)
             self.nextBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.26), for: .normal)
             if  Share.Job_CountryId == 0{
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
         }else{
             self.addressView.layer.backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.7019607843, blue: 0.8980392157, alpha: 1)
             self.addressBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
         }
     }
 }
 extension AddJob3VC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         if collectionView == collectionview{
             return Share.Job_AddressName.count
         }else{
             return 1
         }
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         if collectionView == collectionview{
             collectionview.register(UINib(nibName: "AddAddressCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddAddressCell")
             let cell: AddAddressCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddAddressCell", for: indexPath) as! AddAddressCollectionViewCell
             cell.titlelb.text = Share.Job_AddressName[indexPath.row]
             cell.SelectedView.layer.backgroundColor = selectedIndex == indexPath.row ?   #colorLiteral(red: 0.5141925812, green: 0.5142051578, blue: 0.5141984224, alpha: 1) : #colorLiteral(red: 0.1209653392, green: 0.7701628208, blue: 0.9223280549, alpha: 0)
             return cell
         }else{
             collectionviewList.register(UINib(nibName: "AddressListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddressListCell")
             let cell: AddressListCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddressListCell", for: indexPath) as! AddressListCollectionViewCell
             
             cell.cityText.addTarget(self, action: #selector(AddJob3VC.textFieldDidChange(_:)), for: .editingChanged)
             cell.villageText.addTarget(self, action: #selector(AddJob3VC.textFieldDidChange(_:)), for: .editingChanged)
             cell.postalcodeText.addTarget(self, action: #selector(AddJob3VC.textFieldDidChange(_:)), for: .editingChanged)
             cell.streetNumText.addTarget(self, action: #selector(AddJob3VC.textFieldDidChange(_:)), for: .editingChanged)
             
             cell.countryBtn.addTarget(self, action: #selector(connectedCountry(sender:)), for: .touchUpInside)
             cell.countryBtn.tag = indexPath.row
             
             cell.addLocationBtn.addTarget(self, action: #selector(connectedAddLocation(sender:)), for: .touchUpInside)
             cell.addLocationBtn.tag = indexPath.row
             
             cell.RemoveBtn.addTarget(self, action: #selector(connectedDeleteItem(sender:)), for: .touchUpInside)
             cell.RemoveBtn.tag = indexPath.row
             return cell
         }

     }
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         if collectionView == collectionview{
             selectedIndex = indexPath.row
             collectionView.reloadData()
             if Share.Job_AddressName.last == Share.Job_AddressName[indexPath.row]{
                 setData(index: indexPath.row, id: 0, city: "", Area: "", Postal: "", Street: "", Details: "", Latitude: 0.0, Longitude: 0.0)
             }else{
                 setData(index: indexPath.row, id: Share.Job_Address[selectedIndex].CountryId ?? 0, city: Share.Job_Address[selectedIndex].CityId ?? "", Area: Share.Job_Address[selectedIndex].AreaId ?? "", Postal: Share.Job_Address[selectedIndex].PostalCode ?? "", Street: Share.Job_Address[selectedIndex].Street ?? "", Details: Share.Job_Address[selectedIndex].Details ?? "", Latitude: Share.Job_Address[selectedIndex].Latitude ?? 0.0, Longitude: Share.Job_Address[selectedIndex].Longitude ?? 0.0)
             }
             print(selectedIndex)
         }else{
             
         }
     }
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         if collectionView == collectionview{
             let cellSize = CGSize(width: (collectionView.frame.width), height: (collectionView.frame.height))
             return cellSize
         }else{
             let cellSize = CGSize(width: (collectionviewList.frame.width), height: (collectionviewList.frame.height))
             return cellSize
         }
     }
 }
 extension AddJob3VC{
     
     func setData(index: Int, id: Int, city: String, Area: String, Postal: String, Street: String, Details: String, Latitude: Double, Longitude: Double){
         let tag:NSInteger = index
         let indexPath = IndexPath(row: tag, section: 0)
         let cell = self.collectionviewList.cellForItem(at: indexPath) as? AddressListCollectionViewCell
         if id == 0{
             cell?.countryBtn.setTitle("Select Country", for: .normal)
         }else{
             let selectitem = Share.CountriesList?.first(where: {$0.id == id})
             cell?.countryBtn.setTitle(selectitem?.name ?? "", for: .normal)
         }
         cell?.cityText.text = city
         cell?.villageText.text = Area
         cell?.postalcodeText.text = Postal
         cell?.streetNumText.text = Street
         cell?.moredetailsText.text = Details
         Share.address_lat = Latitude
         Share.address_long = Longitude
     }
 }
 extension AddJob3VC{
     func setup(){
         collectionview.delegate = self
         collectionview.dataSource = self
         collectionviewList.delegate = self
         collectionviewList.dataSource = self
     }
     
     @objc func connectedDeleteItem(sender: UIButton){
         let tag:NSInteger = sender.tag
         let indexPath = IndexPath(row: tag, section: 0)
         let cell = self.collectionviewList.cellForItem(at: indexPath) as? AddressListCollectionViewCell
         
 //        if
 //
 //
 //
 //
 //        Share.Job_Address.remove(at: selectedIndex)
 //        itemOf = itemOf - 1
 //        Share.Job_AddressName.append("\(itemOf) Address")
 //        selectedIndex = selectedIndex + 1
 //        collectionview.reloadData()
 ////        setData(id: 0, city: "", Area: "", Postal: "", Street: "", Details: "", Latitude: 0.0, Longitude: 0.0)
 //        collectionviewList.reloadData()
     }
     
     @objc func connectedAddLocation(sender: UIButton){
         let vc = Share.storyBoard.instantiateViewController(withIdentifier: "MapViewsPage") as! locationVC
         vc.delegate = self
         self.present(vc, animated: false, completion: nil)
         view.endEditing(true)
     }
     
     @objc func connectedCountry(sender: UIButton){
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
             
         let arrTheme = Share.CountriesListString
         let picker = YBTextPicker.init(with: arrTheme, appearance: theme, onCompletion: { (selectedIndexes, selectedValues) in
             if let selectedValue = selectedValues.first{
                 let tag:NSInteger = sender.tag
                 let indexPath = IndexPath(row: tag, section: 0)
                 let cell = self.collectionviewList.cellForItem(at: indexPath) as? AddressListCollectionViewCell
                 cell?.countryBtn.setTitle(selectedValue, for: .normal)
                 let selectitem = Share.CountriesList?.first(where: {$0.name == selectedValue})
                 Share.Job_CountryId = selectitem?.id ?? 0
                 print(selectitem?.id ?? 0)
                 self.SetupBtn()
                 self.setupAddressBtn()
             }else{
                 
             }
         }, onCancel: {
                 
         })
         picker.show(withAnimation: .FromBottom)
     }
     
     @objc func textFieldDidChange(_ textField: UITextField) {
         SetupBtn()
         setupAddressBtn()
     }
 }



 extension AddJob3VC: LocationDelegate{
     func RetriveLocation(lat: Double, lng: Double, add: String) {
         print(lat)
         print(lng)
         print(add)
         Share.address_lat = lat
         Share.address_long = lng
     }
 }
 extension AddJob3VC{
     func AddJob(Title: String, JobType: Int, CategoryId: Int, Description: String, IsJobMultiDays: Bool, DateTimes: [DateTimesCodable], IsBreakAvailable: Bool, IsBreakPaid: Bool, JobTimeType: Int, Photos: [String], ExpectedWorkingHours: String, WorkingHoursDescription: String, PaymentMethod: Int, PaymentType: Int, Price: Double, NumberOfEmployees: Int, Addresses: [AddressCodableJob], IsOnline: Bool){
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

                         }else{
                             ErrorCode.instance.Code(Code: model.errorCode ?? 0)
                     }
                 }
         })
     }
 }

 */
