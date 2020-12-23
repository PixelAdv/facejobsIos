//
//  GalleryVC.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 6/28/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import UIKit
import Alamofire

class GalleryVC: UIViewController {

    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var UploadImage: UIImageView!
    
    @IBOutlet weak var PreviousWorkView: UIView!
    @IBOutlet weak var PreviousWorkBtn: UIButton!

    @IBOutlet weak var CompanyPhotosView: UIView!
    @IBOutlet weak var CompanyPhotosBtn: UIButton!
    
    @IBOutlet weak var Statuslb: UILabel!

        // Take image
    var imagepicker:UIImagePickerController!
    public var ImageBase64Code = ""
    
    var listOfGallery: [DataGalleryCodable]?
    
    var listWorkGalleryString = [String]()
    var listCompanyGalleryString = [String]()
    
    var TypeId = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Statuslb.text = "Previous work"
        SetupCollection()
        addingGradientLayerToNavigationBar([#colorLiteral(red: 0.1607843137, green: 0.6705882353, blue: 0.8862745098, alpha: 1).cgColor, #colorLiteral(red: 0, green: 1, blue: 1, alpha: 1).cgColor])
        GetGallery()
        PreviousWorkView.layer.backgroundColor = #colorLiteral(red: 0.003921568627, green: 0.6274509804, blue: 0.7764705882, alpha: 1)
        PreviousWorkBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        
        CompanyPhotosView.layer.backgroundColor = #colorLiteral(red: 0.4509803922, green: 0.4823529412, blue: 0.4980392157, alpha: 1)
        CompanyPhotosBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
    }
    
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func PreviousWorkPressed(_ sender: Any) {
        TypeId = 1
        Statuslb.text = "Previous work"
        PreviousWorkView.layer.backgroundColor = #colorLiteral(red: 0.003921568627, green: 0.6274509804, blue: 0.7764705882, alpha: 1)
        PreviousWorkBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        
        CompanyPhotosView.layer.backgroundColor = #colorLiteral(red: 0.4509803922, green: 0.4823529412, blue: 0.4980392157, alpha: 1)
        CompanyPhotosBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        collectionview.reloadData()
    }
    
    @IBAction func CompanyPhotosPressed(_ sender: Any) {
        TypeId = 2
        Statuslb.text = "Company Photos"
        PreviousWorkView.layer.backgroundColor = #colorLiteral(red: 0.4509803922, green: 0.4823529412, blue: 0.4980392157, alpha: 1)
        PreviousWorkBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        
        CompanyPhotosView.layer.backgroundColor = #colorLiteral(red: 0.003921568627, green: 0.6274509804, blue: 0.7764705882, alpha: 1)
        CompanyPhotosBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        collectionview.reloadData()
    }
    
    @IBAction func importimage(_ sender: UIButton) {
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
    
    func SetupCollection(){
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.register(UINib(nibName: "GalleryWorkCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GalleryWorkCell")
    }

}
extension GalleryVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if TypeId == 1{
            return listWorkGalleryString.count
        }else{
            return listCompanyGalleryString.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: GalleryWorkCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryWorkCell", for: indexPath) as! GalleryWorkCollectionViewCell
        if TypeId == 1{
            Share.instance.SetimageWithout(Path: listWorkGalleryString[indexPath.row], Image: cell.ImageGallery)
        }else{
            Share.instance.SetimageWithout(Path: listCompanyGalleryString[indexPath.row], Image: cell.ImageGallery)
        }
        cell.DeleteBtn.addTarget(self, action: #selector(connectedDeleteItem(sender:)), for: .touchUpInside)
        cell.DeleteBtn.tag = indexPath.row
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
     {
        let cellSize = CGSize(width: (collectionView.frame.width)/3, height: (collectionView.frame.height)/2)
        return cellSize
    }
}
extension GalleryVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        let Chosseimage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        UploadImage?.contentMode = .scaleToFill
        
        UploadImage.image = Chosseimage
        ImageBase64Code = Chosseimage.ImageToBase64() ?? ""
        AddImage(type: TypeId, ImagesBase64: [ImageBase64Code])
        dismiss(animated: true, completion: nil)
        UploadImage.layer.cornerRadius = 22
        UploadImage .clipsToBounds = true
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
extension GalleryVC{
    func GetGallery(){

        AF.request(APIRouter.GetGalleryRouter(Auth: Share.savedToken as! String))
            .responseJSON(completionHandler: { (res) in
                print(res)
            })
            .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<GalleryCodable, AFError>) in
                switch response.result {
                    case .failure(let err):
                        print(err.localizedDescription)
                    case .success(let model):
                        // previous = 1
                        // Company = 2
                        if !self.listWorkGalleryString.isEmpty{
                            self.listWorkGalleryString.removeAll()
                        }
                        self.listCompanyGalleryString.removeAll()
                        self.listOfGallery = model.data
                        for item in model.data ?? []{
                            if item.galleryType == 1{
                                self.listWorkGalleryString.append(item.imageUrl ?? "")
                            }else{
                                self.listCompanyGalleryString.append(item.imageUrl ?? "")
                            }
                        }
                        self.collectionview.reloadData()
                    }
                })
    }
    
    func AddImage(type: Int, ImagesBase64: [String]){
        AF.request(APIRouter.EditGalleryRouter(GalleryType: type, ImagesBase64: ImagesBase64, Auth: Share.savedToken as! String))
            .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<MessageCode, AFError>) in
                switch response.result {
                    case .failure(let err):
                        print(err.localizedDescription)
                    case .success(let model):
                        if model.errorCode == 0 {
                            AlertView.instance.showAlert(message: "Successfully", alertType: .success)
                            self.GetGallery()
                        }else{
                            ErrorCode.instance.Code(Code: model.errorCode ?? 0)
                    }
                }
            })
    }
    func DeleteImage(Id: Int, GalleryType: Int){
        AF.request(APIRouter.DeletItemGalleryRouter(ImageId: Id, GalleryType: GalleryType, Auth: Share.savedToken as! String))
            .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<MessageCode, AFError>) in
                switch response.result {
                    case .failure(let err):
                        print(err.localizedDescription)
                    case .success(let model):
                        if model.errorCode == 0 {
                            AlertView.instance.showAlert(message: "Successfully", alertType: .success)
                            self.GetGallery()
                        }else{
                            ErrorCode.instance.Code(Code: model.errorCode ?? 0)
                    }
                }
            })
    }
    @objc func connectedDeleteItem(sender: UIButton){
        var ids = 0
        if TypeId == 1{
            let selectitem = self.listOfGallery?.first(where: {$0.imageUrl == listWorkGalleryString[sender.tag]})
            ids = selectitem?.id ?? 0
        }else{
            let selectitem = self.listOfGallery?.first(where: {$0.imageUrl == listCompanyGalleryString[sender.tag]})
            ids = selectitem?.id ?? 0
        }
        DeleteImage(Id: ids, GalleryType: TypeId)
    }

}
