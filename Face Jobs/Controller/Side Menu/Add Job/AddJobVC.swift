//
//  AddJobVC.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 7/6/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import MOLH
import UIKit
import Alamofire

class AddJobVC: UIViewController {

    @IBOutlet weak var ScrollView: UIScrollView!

    @IBOutlet weak var TitleTxt: UITextField!
    @IBOutlet weak var DescriptionText: UITextView!

    @IBOutlet weak var TypeBtn: UIButton!
    @IBOutlet weak var CategoryBtn: UIButton!
    @IBOutlet weak var NewxtBtn: UIButton!
    @IBOutlet weak var NewxtView: UIView!

    @IBOutlet weak var collectionview: UICollectionView!

        // Take image
    var imagepicker:UIImagePickerController!
    public var ImageBase64Code = ""
    
    var item = -1
    
    let regularFont = UIFont.systemFont(ofSize: 16)
    let boldFont = UIFont.boldSystemFont(ofSize: 16)
    var JopModel:GetEditJopPageDataCodable!
    override func viewDidLoad() {
        super.viewDidLoad()
        Share.Job_Image.removeAll()
        getRadius()
        addingGradientLayerToNavigationBar([#colorLiteral(red: 0.1607843137, green: 0.6705882353, blue: 0.8862745098, alpha: 1).cgColor, #colorLiteral(red: 0, green: 1, blue: 1, alpha: 1).cgColor])
        GetData()
        GetDataToAddJob()
        TitleTxt.addTarget(self, action: #selector(AddJobVC.textFieldDidChange(_:)), for: .editingChanged)
        if JopModel != nil{
            editJopData()
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        CallSetup()
    }
    func CallSetup(){
        if TitleTxt.text?.isEmpty == true{
            NewxtView.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.12)
            NewxtBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.26), for: .normal)
        }else if Share.Job_TypeId == -1{
            NewxtView.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.12)
            NewxtBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.26), for: .normal)
        }else if Share.Job_CategoryId == -1{
            NewxtView.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.12)
            NewxtBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.26), for: .normal)
        }else{
            NewxtView.layer.backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.7019607843, blue: 0.8980392157, alpha: 1)
            NewxtBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        }
    }
    func GetData(){
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.register(UINib(nibName: "AddJobImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddJobImageCell")
    }
    
    @IBAction func BackPressed(_ sender: Any) {
        Share.Job_TypeId = -1
        Share.Job_CategoryId = -1
        Share.Job_PaymentMethod = -1

        Share.Job_Image.removeAll()
        Share.Job_Image_String.removeAll()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func NextPressed(_ sender: Any) {
        Share.Job_Title = TitleTxt.text ?? ""
        Share.Job_Description = DescriptionText.text ?? ""
        let vc = Share.storyBoard.instantiateViewController(withIdentifier: "AddJobPage2") as! UINavigationController
        let addJopVC = vc.viewControllers.first as! AddJob2VC
        addJopVC.JopModel = JopModel
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func AddImagePressed(_ sender: Any) {
        ImportImage()
    }
}
extension AddJobVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Share.Job_Image.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AddJobImageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddJobImageCell", for: indexPath) as! AddJobImageCollectionViewCell
        cell.imageProJob.image = Share.Job_Image[indexPath.row]
        cell.imageProJob.contentMode = .scaleToFill
        cell.imageProJob.layer.cornerRadius = 5
        cell.imageProJob.clipsToBounds = true
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(width: (collectionView.frame.width)/3, height: (collectionView.frame.height))
        return cellSize
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var alert = UIAlertController(title: "Select", message: nil, preferredStyle: .actionSheet)
        if UIDevice.current.userInterfaceIdiom == .pad {
            alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        }

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            print("cancel")
        }))
        alert.addAction(UIAlertAction(title: "Remove", style: .default, handler: { (action) in
            Share.Job_Image.remove(at: indexPath.row)
            collectionView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: { (action) in
            self.item = indexPath.row
            self.ImportImage()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
extension AddJobVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func ImportImage(){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle:.actionSheet)
        imagepicker = UIImagePickerController()
        imagepicker.delegate = self
        
        let cameraAction = UIAlertAction(title: "Use Camera".localized, style: .default) { (action) in
            self.imagepicker.sourceType = .camera
            self.imagepicker.cameraCaptureMode = .photo
            self.imagepicker.allowsEditing = false
            self.present(self.imagepicker, animated: true, completion: nil)
        }
        let PhotoLibararyAction = UIAlertAction(title: "Photo Library".localized, style: .default) { (action) in
            self.imagepicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            self.imagepicker.sourceType = .photoLibrary
            self.imagepicker.allowsEditing = true
            self.present(self.imagepicker, animated: true, completion: nil)
        }
        let CancelAction = UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil)
        alertController.addAction(PhotoLibararyAction)
        alertController.addAction(cameraAction)
        alertController.addAction(CancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        let Chosseimage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        ImageBase64Code = Chosseimage.ImageToBase64() ?? ""
        if self.item > -1 {
            Share.Job_Image[self.item] = Chosseimage
            Share.Job_Image_String[self.item] = ImageBase64Code
            self.item = -1
        }else{
            Share.Job_Image.append(Chosseimage)
            Share.Job_Image_String.append(ImageBase64Code)
        }
        collectionview.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    func displayErrorMessage(message:String) {
        let alertView = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
        }
        alertView.addAction(OKAction)
        if let presenter = alertView.popoverPresentationController {
            presenter.sourceView = self.view
            presenter.sourceRect = self.view.bounds
        }
        self.present(alertView, animated: true, completion:nil)
    }
}
extension AddJobVC{
    func GetDataToAddJob(){
        Share.CountriesListString.removeAll()
        AF.request(APIRouter.GetDataToAddJobRouter(lang: MOLHLanguage.currentAppleLanguage(), Auth: Share.savedToken as! String))
            .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<GetAddJobDataCodable, AFError>) in
                switch response.result {
                    case .failure(let err):
                        print(err.localizedDescription)
                    case .success(let model):
                        if model.errorCode == 0 {
                            Share.TypeListString.removeAll()
                            Share.CategoriesListString.removeAll()
                            Share.TypeList = model.data?.types
                            Share.CategoriesList = model.data?.categories
                            Share.PaymentMethodsList = model.data?.paymentMethods
                            Share.CountriesList = model.data?.countries
                            Share.PriceTypesList = model.data?.priceTypes
                            
                            self.TypeBtn.setTitle(model.data?.types?.first?.name ?? "", for: .normal)
                            Share.Job_TypeId = model.data?.types?.first?.id ?? 0

                            self.CategoryBtn.setTitle(model.data?.categories?.first?.name ?? "", for: .normal)
                            Share.Job_CategoryId = model.data?.categories?.first?.id ?? 0
                            Share.Job_PaymentMethodJob = model.data?.categories?.first?.paymentMethod ?? 0
                            
//                            Share.Job_CategoryId = model.data?.categories?.first?.id ?? 0
                            if JopModel == nil{
                                self.DescriptionText.text = model.data?.categories?.first?.description ?? ""
                            }
                            
                            model.data?.types?.forEach({ (item) in
                                Share.TypeListString.append(item.name ?? "")
                            })
                            model.data?.categories?.forEach({ (item) in
                                Share.CategoriesListString.append(item.name ?? "")
                            })
                            
                            model.data?.paymentMethods?.forEach({ (item) in
                                Share.PaymentMethodsListString.append(item.name ?? "")
                            })
                            model.data?.priceTypes?.forEach({ (item) in
                                Share.PriceTypesListString.append(item.name ?? "")
                            })
                            
                            model.data?.countries?.forEach({ (item) in
                                Share.CountriesListString.append(item.name ?? "")
                            })
                            
                        }else{
                            ErrorCode.instance.Code(Code: model.errorCode ?? 0)
                    }
                        
                    }
                })
    }
}
extension AddJobVC{
    
    @IBAction func TypePressed(_ sender: Any) {
        let theme = YBTextPickerAppearanceManager.init(
            pickerTitle         : "Types",
            titleFont           : boldFont,
            titleTextColor      : .white,
            titleBackground     : #colorLiteral(red: 0.7240439057, green: 0.6962934732, blue: 0.6956846118, alpha: 1),
            searchBarFont       : regularFont,
            searchBarPlaceholder: "Search of Types",
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
        
        let arrTheme = Share.TypeListString
        let picker = YBTextPicker.init(with: arrTheme, appearance: theme, onCompletion: { (selectedIndexes, selectedValues) in
            if let selectedValue = selectedValues.first{
                self.TypeBtn.setTitle(selectedValue, for: .normal)
                let selectitem = Share.TypeList?.first(where: {$0.name == selectedValue})
                Share.Job_TypeId = selectitem?.id ?? 0
            }else{
            }
        }, onCancel: {
            
        })
        picker.show(withAnimation: .FromBottom)
        CallSetup()

    }
    @IBAction func CategoryPressed(_ sender: Any) {
        let theme = YBTextPickerAppearanceManager.init(
            pickerTitle         : "Categories",
            titleFont           : boldFont,
            titleTextColor      : .white,
            titleBackground     : #colorLiteral(red: 0.7240439057, green: 0.6962934732, blue: 0.6956846118, alpha: 1),
            searchBarFont       : regularFont,
            searchBarPlaceholder: "Search of Countries",
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
        
        let arrTheme = Share.CategoriesListString
        let picker = YBTextPicker.init(with: arrTheme, appearance: theme, onCompletion: { (selectedIndexes, selectedValues) in
            if let selectedValue = selectedValues.first{
                self.CategoryBtn.setTitle(selectedValue, for: .normal)
                let selectitem = Share.CategoriesList?.first(where: {$0.name == selectedValue})
                self.DescriptionText.text = selectitem?.description ?? ""
                Share.Job_CategoryId = selectitem?.id ?? 0
                Share.Job_PaymentMethodJob = selectitem?.paymentMethod ?? 0
            }else{
//                self.CategoryBtn.setTitle("Categories", for: .normal)
                
            }
        }, onCancel: {
            
        })
        picker.show(withAnimation: .FromBottom)
        CallSetup()


    }
    
    
//    func SetupDropDownType(){
//        TypeDrop.optionArray = Share.TypeListString
//        TypeDrop.didSelect{(selectedText , index , id) in
//        let selectitem = Share.TypeList?.first(where: {$0.name == selectedText})
//            print(selectedText)
//            print(selectitem?.name)
//        }
//    }
//    func SetupDropDownCategory(){
//        CategoryDrop.optionArray = Share.CategoriesListString
//        CategoryDrop.didSelect{(selectedText , index , id) in
//        let selectitem = Share.CategoriesList?.first(where: {$0.name == selectedText})
//            print(selectedText)
//            print(selectitem?.name)
//
//        }
//    }
}
extension AddJobVC: UITextFieldDelegate{
    func getRadius() {
     let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didtapview(gesture:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        TitleTxt.resignFirstResponder()
        DescriptionText.resignFirstResponder()
        return true
    }
    
    @objc func didtapview(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unregisterKeyboardNotifications()
    }
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardDidShow(notification:)),
                                               name: UIResponder.keyboardDidShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    func unregisterKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    @objc func keyboardDidShow(notification: NSNotification) {
        print("keyboard seen")
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        ScrollView.contentInset = contentInsets
        ScrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        print("keyboard hidden")
        ScrollView.contentInset = UIEdgeInsets.zero
        ScrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
}

extension AddJobVC{
    func editJopData() {
        if JopModel != nil{
            self.TitleTxt.text = JopModel.Data?.Title
            self.DescriptionText.text = JopModel.Data?.Description
            for jopType in JopModel.Data!.Types{
                if jopType.Id == JopModel.Data!.JobType{
                    self.TypeBtn.setTitle(jopType.Name, for: .normal)
                }
            }
            for jopCategory in JopModel.Data!.Categories{
                if jopCategory.Id == JopModel.Data!.CategoryId{
                    self.CategoryBtn.setTitle(jopCategory.Name, for: .normal)
                }
            }
            for image in JopModel.Data!.CurrentPhotos{
                let url = APIRouter.baseURL+image.ImageUrl
                let newURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                let Image = UIImageView()
                Image.kf.setImage(with: URL(string: newURL!)!, placeholder: UIImage.init(named: ""), options: [.transition(.fade(1)), .cacheOriginalImage], progressBlock: nil, completionHandler: { (downloadImage, error, cacheType, url) in
                    if (downloadImage != nil) {
                        Share.Job_Image.append(downloadImage!)
                    }
                else
                    {
                        Image.image = UIImage(named: "Logo Backgound")
                        print("Error In load image")
                    }
                })
            }
        }
    }
}
