//
//  EmergencyVC.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 7/21/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import UIKit
import Alamofire
class EmergencyVC: UIViewController {
    @IBOutlet weak var reasonTXT: UITextView!
    @IBOutlet weak var holdmage: UIImageView!
    @IBOutlet weak var cancelJobImage: UIImageView!
    @IBOutlet weak var holdBTN: UIButton!
    @IBOutlet weak var cancelBTN: UIButton!
    @IBOutlet weak var addFileTapped: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var backBTN: UIButton!
    let constant = Constants.shared
    var imagePicker: ImagePicker!
    var imageToString: String?
    var job_id: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        setBorderView()
        setUpView()
    }
    private func setUpView()
    {
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        addingGradientLayerToView([#colorLiteral(red: 0.1607843137, green: 0.6705882353, blue: 0.8862745098, alpha: 1).cgColor, #colorLiteral(red: 0, green: 1, blue: 1, alpha: 1).cgColor], view: firstView)
        self.navigationController?.navigationBar.isHidden = true
        title = "emergencyNotice".localized
        if constant.isArabic() {
            backBTN.setImage(UIImage(named: "backRight"), for: .normal)
        }
    }
    private func setBorderView()
    {
        containerView.layer.cornerRadius = 8
        containerView.layer.masksToBounds = true
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.borderColor.cgColor
    }
   
    @IBAction func holdTapped(_ sender: Any) {
        holdBTN.setImage(#imageLiteral(resourceName: "Radio Fill"), for: .normal)
        cancelBTN.setImage(#imageLiteral(resourceName: "Radio Empty"), for: .normal)
    }
    @IBAction func cancelTapped(_ sender: Any) {
        holdBTN.setImage(#imageLiteral(resourceName: "Radio Empty"), for: .normal)
        cancelBTN.setImage(#imageLiteral(resourceName: "Radio Fill"), for: .normal)
    }
    @IBAction func BackPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func addFileTapped(_ sender: Any) {
        chooseImage()
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        guard let reason = reasonTXT.text, !reason.isEmpty else {
            AlertView.instance.showAlert(message: "cancelJob".localized, alertType: .failure)
            return
        }
        guard let emerengcyPhoto = imageToString else {
            AlertView.instance.showAlert(message: "emergencyPhoto".localized, alertType: .failure)
            return
        }
        guard let jobID = job_id else {
            AlertView.instance.showAlert(message: "job id not found ".localized, alertType: .failure)
            return
        }
        callEmerengcy(jobID: jobID, reason: reason, image: emerengcyPhoto)
    }
    private func callEmerengcy(jobID: Int, reason: String, image: String)
    {
        AF.request(APIRouter.sendEmerengcy(JobId: jobID, Auth: Share.savedToken as! String, image: image, reason: reason))
            .responseDecodable(completionHandler: { (response: DataResponse<jobResponse, AFError>) in
                switch response.result {
                case .failure(let err):
                    print(err.localizedDescription)
                case .success(let model):
                    if model.errorCode == 0{
                        AlertView.instance.showAlert(message: "jobdeleted".localized, alertType: .failure)
                    }
                    else {
                        AlertView.instance.showAlert(message: "deleteJobFail".localized, alertType: .failure)
                    }
                }
            })
    }
}

extension EmergencyVC: ImagePickerDelegate{
    func didSelect(image: UIImage?) {
        guard let selectedImage = image else {
            return
        }
        let imageData = selectedImage.jpegData(compressionQuality: 0.5)
        let imageBase64 = imageData!.base64EncodedString()
        self.imageToString = imageBase64
    }
    
    func chooseImage(){
        self.imagePicker.present(from: self.view)
    }
}
