//
//  ProfileVC.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 6/28/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import UIKit
import Alamofire

class ProfileVC: UIViewController {

    // Slider
    @IBOutlet weak var Presentslider: UISlider!
    @IBOutlet weak var presentlb: UILabel!

    @IBOutlet weak var collectionview: UICollectionView!
    
    @IBOutlet weak var imageProfile: UIImageView!

    @IBOutlet weak var EmailProfile: UITextField!
    @IBOutlet weak var CompanyNameProfile: UILabel!
    @IBOutlet weak var PhoneProfile: UITextField!
    @IBOutlet weak var landLineProfile: UITextField!
    @IBOutlet weak var numberOfJob: UILabel!
    @IBOutlet weak var RatingView: FloatRatingView!

    @IBOutlet weak var CompanyInfoProfile: UITextView!

    @IBOutlet weak var PhoneBtn: UIButton!
    @IBOutlet weak var landlineBtn: UIButton!
    @IBOutlet weak var CompanyInfoBtn: UIButton!
    @IBOutlet weak var EmailBtn: UIButton!

    @IBOutlet weak var ScrollView: UIScrollView!

    var listOfImage = [String]()
    
        // Take image
    var imagepicker:UIImagePickerController!
    public var ImageBase64Code = ""
        
    var StausPhone = true
    var StausEmail = true
    var StauslandLine = true
    var StausCompany = true
    
    var lastEmail = ""
    var lastPhone = ""
    var lastLandline = ""
    var lastCompanyInfo = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        GetProfile()
        SetupCollection()
        SetupText()
        getRadius()
    }
    
    func SetupText(){
        EmailProfile.isUserInteractionEnabled = false
        PhoneProfile.isUserInteractionEnabled = false
        landLineProfile.isUserInteractionEnabled = false
        CompanyInfoProfile.isEditable = false
        CompanyInfoProfile.delegate = self
    }
    
    func SetupCollection(){
        collectionview.delegate = self
        collectionview.dataSource = self
//        collectionview.register(UINib(nibName: "GalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GalleryCell")
        collectionview.register(UINib(nibName: "AddJobImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddJobImageCell")

    }
    
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func EmailPressed(_ sender: Any) {
        if StausEmail == true{
            EmailProfile.isUserInteractionEnabled = true
            EmailBtn.setImage(UIImage(named: "Done"), for: .normal)
            StausEmail = false
            DispatchQueue.main.async {
               self.EmailProfile.becomeFirstResponder()
            }
        }else{
            EmailProfile.isUserInteractionEnabled = false
            EmailBtn.setImage(UIImage(named: "Edit Profile"), for: .normal)
            StausEmail = true
            EditEmail(Email: EmailProfile.text ?? "")
        }
    }

    @IBAction func PhonePressed(_ sender: Any) {
        if StausPhone == true{
            PhoneProfile.isUserInteractionEnabled = true
            PhoneBtn.setImage(UIImage(named: "Done"), for: .normal)
            StausPhone = false
            DispatchQueue.main.async {
               self.PhoneProfile.becomeFirstResponder()
            }
        }else{
            PhoneProfile.isUserInteractionEnabled = false
            PhoneBtn.setImage(UIImage(named: "Edit Profile"), for: .normal)
            StausPhone = true
            EditPhone(Phone: PhoneProfile.text ?? "")
        }
    }

    @IBAction func landLinePressed(_ sender: Any) {
        if StauslandLine == true{
            landLineProfile.isUserInteractionEnabled = true
            landlineBtn.setImage(UIImage(named: "Done"), for: .normal)
            StauslandLine = false
            DispatchQueue.main.async {
               self.landLineProfile.becomeFirstResponder()
            }
        }else{
            landLineProfile.isUserInteractionEnabled = false
            landlineBtn.setImage(UIImage(named: "Edit Profile"), for: .normal)
            StauslandLine = true
            EditLandline(Landline: landLineProfile.text ?? "")
        }
    }

    @IBAction func CompanyInfoPressed(_ sender: Any) {
        if StausCompany == true{
            CompanyInfoProfile.isEditable = true
            CompanyInfoBtn.setImage(UIImage(named: "Done"), for: .normal)
            StausCompany = false
            DispatchQueue.main.async {
               self.CompanyInfoProfile.becomeFirstResponder()
            }
        }else{
            CompanyInfoProfile.isEditable = false
            CompanyInfoBtn.setImage(UIImage(named: "Edit Profile"), for: .normal)
            StausCompany = true
            EditCompanyInfo(Description: CompanyInfoProfile.text ?? "")
        }
    }
    
    @IBAction func EditimagePressed(_ sender: Any) {
        SelectImage()
    }
    @objc func clickImportImage(tapGestureRecognizer: UITapGestureRecognizer){
        SelectImage()
    }

    func SelectImage(){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle:.actionSheet)
        imagepicker = UIImagePickerController()
        imagepicker.delegate = self
        
        let cameraAction = UIAlertAction(title: "User Camera", style: .default) { (action) in
            self.imagepicker.sourceType = .camera
            self.imagepicker.cameraCaptureMode = .photo
            self.imagepicker.allowsEditing = false
            self.present(self.imagepicker, animated: true, completion: nil)
        }
        let PhotoLibararyAction = UIAlertAction(title: "Photo Library", style: .default) { (action) in
            self.imagepicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            self.imagepicker.sourceType = .photoLibrary
            self.imagepicker.allowsEditing = true
            self.present(self.imagepicker, animated: true, completion: nil)
        }
        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(PhotoLibararyAction)
        alertController.addAction(cameraAction)
        alertController.addAction(CancelAction)
        self.present(alertController, animated: true, completion: nil)
    }

}
extension ProfileVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AddJobImageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddJobImageCell", for: indexPath) as! AddJobImageCollectionViewCell
        Share.instance.SetimageWithout(Path: listOfImage[indexPath.row], Image: cell.imageProJob)
        cell.imageProJob.layer.cornerRadius = 12
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
     {
        let cellSize = CGSize(width: (collectionView.frame.width)/3, height: (collectionView.frame.height)/2)
        return cellSize
    }
}
extension ProfileVC{
    func GetProfile(){
        AF.request(APIRouter.GetProfile(lang: "en", Auth: Share.savedToken as! String))
            .responseJSON(completionHandler: { (res) in
                print(res)
            })
            .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<ProfileCodable, AFError>) in
                switch response.result {
                    case .failure(let err):
                        print(err.localizedDescription)
                    case .success(let model):
                        self.Presentslider.value =  Float(model.data?.profileCompletenessPercentage ?? 0)
                        self.presentlb.text = "\(model.data?.profileCompletenessPercentage ?? 0) %"
                        self.lastEmail = model.data?.email ?? ""
                        self.lastPhone = model.data?.phone ?? ""
                        self.lastLandline = model.data?.landLine ?? ""
                        self.lastCompanyInfo = model.data?.specializationDetails ?? ""
                        
                        Share.instance.SetimageWithCorner(Path: model.data?.imageUrl ?? "", Image: self.imageProfile)
                        self.EmailProfile.text = model.data?.email ?? ""
                        self.CompanyNameProfile.text = model.data?.companyName ?? ""
                        self.PhoneProfile.text = model.data?.phone ?? ""
                        self.landLineProfile.text = model.data?.landLine ?? ""
                        self.numberOfJob.text = "\(model.data?.numberOfWarnings ?? 0)"
                        self.RatingView.rating = model.data?.rate ?? 0.0
                        
                        model.data?.images?.forEach({ (Item) in
                            self.listOfImage.append(Item)
                        })
                        if model.data?.specializationDetails?.isEmpty == true || model.data?.specializationDetails == nil {
//                            self.setupPlaceholder(Message: self.CompanyInfoProfile, MessageString: "Company info...........")
                            self.CompanyInfoProfile.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                            self.CompanyInfoProfile.text = "Company info..........."
                        }else{
                            self.CompanyInfoProfile.text = model.data?.specializationDetails ?? ""
                        }
                        self.collectionview.reloadData()
                        
                    }
                })
    }
    func EditLogo(ImageBase64: String){
        AF.request(APIRouter.EditImageProfile(ImageBase64: ImageBase64, Auth: Share.savedToken as! String))
            .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<PublicMessageCode, AFError>) in
                switch response.result {
                    case .failure(let err):
                        print(err.localizedDescription)
                    case .success(let model):
                        if model.errorCode == 0 {
                            AlertView.instance.showAlert(message: "Image changed successfully", alertType: .success)
                            self.Presentslider.value =  Float(model.data?.ProfilePercentage ?? 0)
                            self.presentlb.text = "\(model.data?.ProfilePercentage ?? 0) %"
                        }else{
                            ErrorCode.instance.Code(Code: model.errorCode ?? 0)
                    }
                        
                    }
                })
    }
    func EditEmail(Email: String){
        if lastEmail == Email{
            
        }else{
            AF.request(APIRouter.EditEmailProfile(Email: Email, Auth: Share.savedToken as! String))
                .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<PublicMessageCode, AFError>) in
                    switch response.result {
                        case .failure(let err):
                            print(err.localizedDescription)
                        case .success(let model):
                            if model.errorCode == 0 {
                                AlertView.instance.showAlert(message: "Email changed successfully", alertType: .success)
                                self.Presentslider.value =  Float(model.data?.ProfilePercentage ?? 0)
                                self.presentlb.text = "\(model.data?.ProfilePercentage ?? 0) %"
                            }else{
                                ErrorCode.instance.Code(Code: model.errorCode ?? 0)
                        }
                            
                        }
                    })
        }
    }
    func EditPhone(Phone: String){
        if lastPhone == Phone{
            
        }else{
            AF.request(APIRouter.EditPhoneProfile(Phone: Phone, Auth: Share.savedToken as! String))
                .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<PublicMessageCode, AFError>) in
                    switch response.result {
                        case .failure(let err):
                            print(err.localizedDescription)
                        case .success(let model):
                            if model.errorCode == 0 {
                                AlertView.instance.showAlert(message: "Phone changed successfully", alertType: .success)
                                self.Presentslider.value =  Float(model.data?.ProfilePercentage ?? 0)
                                self.presentlb.text = "\(model.data?.ProfilePercentage ?? 0) %"
                            }else{
                                ErrorCode.instance.Code(Code: model.errorCode ?? 0)
                        }
                            
                        }
                    })
        }
    }
    func EditLandline(Landline: String){
        if lastLandline == Landline{
            
        }else{
            AF.request(APIRouter.EditLandlineProfile(Landline: Landline, Auth: Share.savedToken as! String))
                .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<PublicMessageCode, AFError>) in
                    switch response.result {
                        case .failure(let err):
                            print(err.localizedDescription)
                        case .success(let model):
                            if model.errorCode == 0 {
                                AlertView.instance.showAlert(message: "Landline changed successfully", alertType: .success)
                                self.Presentslider.value =  Float(model.data?.ProfilePercentage ?? 0)
                                self.presentlb.text = "\(model.data?.ProfilePercentage ?? 0) %"
                            }else{
                                ErrorCode.instance.Code(Code: model.errorCode ?? 0)
                        }
                            
                        }
                    })
        }
    }
    func EditCompanyInfo(Description: String){
        if lastCompanyInfo == Description{
//            self.setupPlaceholder(Message: self.CompanyInfoProfile, MessageString: "Company info...........")
            self.CompanyInfoProfile.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            self.CompanyInfoProfile.text = "Company info..........."
        }else{
            AF.request(APIRouter.EditCompanyInfoProfile(Description: Description, Auth: Share.savedToken as! String))
                .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<PublicMessageCode, AFError>) in
                    switch response.result {
                        case .failure(let err):
                            print(err.localizedDescription)
                        case .success(let model):
                            if model.errorCode == 0 {
                                AlertView.instance.showAlert(message: "Company info changed successfully", alertType: .success)
                                self.Presentslider.value =  Float(model.data?.ProfilePercentage ?? 0)
                                self.presentlb.text = "\(model.data?.ProfilePercentage ?? 0) %"
                            }else{
                                ErrorCode.instance.Code(Code: model.errorCode ?? 0)
                        }
                            
                        }
                    })
        }
    }

}
extension ProfileVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        let Chosseimage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageProfile?.contentMode = .scaleToFill
        
        imageProfile.image = Chosseimage
        ImageBase64Code = Chosseimage.ImageToBase64() ?? ""
        EditLogo(ImageBase64: ImageBase64Code)
        dismiss(animated: true, completion: nil)
        imageProfile.layer.cornerRadius = imageProfile.frame.height / 2
        imageProfile.clipsToBounds = true
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
extension ProfileVC: UITextFieldDelegate{
    func getRadius() {
     let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didtapview(gesture:)))
        view.addGestureRecognizer(tapGesture)
        EmailProfile.attributedPlaceholder = NSAttributedString(string: "Email address", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)])
        PhoneProfile.attributedPlaceholder = NSAttributedString(string: "Phone number", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)])
        landLineProfile.attributedPlaceholder = NSAttributedString(string: "Landline", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)])
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickImportImage(tapGestureRecognizer:)))
        imageProfile.isUserInteractionEnabled = true
        imageProfile.addGestureRecognizer(tapGestureRecognizer)
        
        UITapGestureRecognizer(target: self, action: #selector(textFieldShouldReturn(_:)))

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        EmailProfile.resignFirstResponder()
        PhoneProfile.resignFirstResponder()
        landLineProfile.resignFirstResponder()
        CompanyInfoProfile.resignFirstResponder()
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
extension ProfileVC:UITextViewDelegate{
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.text == "Company info..........."{
            textView.text = ""
        }
        return true
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if textView.text.isEmpty{
            self.CompanyInfoProfile.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            self.CompanyInfoProfile.text = "Company info..........."
        }
        return true
    }
}
