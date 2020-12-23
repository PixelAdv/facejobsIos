//
//  documentVC.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 6/28/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import UIKit
import Alamofire

// 0 Image
// 1 PDF
// 2 Excel
// 3 Word

class documentVC: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var filenamelb: UILabel!
    @IBOutlet weak var fileView: UIView!
    
    @IBOutlet weak var ScrollView: UIScrollView!

    @IBOutlet weak var SelectFile: UITextField!
    var attachmentManager: AttachmentManager = AttachmentManager()
    var CvBase64 = ""

    var listDocument: [DataDocumentCodable]?
    
    var TypeId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fileView.isHidden = true
        GetDocument()
        addingGradientLayerToNavigationBar([#colorLiteral(red: 0.1607843137, green: 0.6705882353, blue: 0.8862745098, alpha: 1).cgColor, #colorLiteral(red: 0, green: 1, blue: 1, alpha: 1).cgColor])
        SelectFile.attributedPlaceholder = NSAttributedString(string: "Add attached file name", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])

        setupTable()
    }
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func chooseCVPressed(_ sender: Any) {
        presentAttachmentActionSheet()
    }
    @IBAction func SendPressed(_ sender: Any) {
        if SelectFile.text == ""{
            AlertView.instance.showAlert(message: "File name is required", alertType: .failure)
        }else if CvBase64 == ""{
            AlertView.instance.showAlert(message: "File is required", alertType: .failure)
        }else{
            AddSocial(FileName: SelectFile.text ?? "", FileType: TypeId ?? 0, FileBase64: CvBase64)
        }
    }
    func setupTable(){
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableFooterView = UIView()
        tableview.register(UINib(nibName: "DocumentTableViewCell", bundle: nil), forCellReuseIdentifier: "DocumentCell")
    }
    
}
extension documentVC: MediaPickerPresenter{
    func SetupFile(){
        var titles = attachmentManager.settings.titles
        var settings = attachmentManager.settings
        
        //Customize titles
        titles.actionSheetTitle = "My title"
        titles.cancelTitle = "CANCEL"
        
        //Customize pickers settings
        settings.allowedAttachments = [.documents];
        settings.documentTypes = ["public.data"];
        
        settings.libraryAllowsEditing = true
        settings.cameraAllowsEditing = true
    }
    
    func didSelectFromMediaPicker(_ file: FileInfo) {
        do {
            let fileData = try Data.init(contentsOf: file.url!)
            let fileStream:String = fileData.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
            CvBase64 = fileStream
            
            if file.mimeType == "application/vnd.ms-excel"{
                TypeId = 2
            }else if file.mimeType == "application/pdf"{
                TypeId = 1
            }else if file.mimeType == "application/vnd.openxmlformats-officedocument.wordprocessingml.document"{
                TypeId = 3
            }else if file.mimeType == "application/msword"{
                TypeId = 3
            }else{
                TypeId = 0
            }
            print(file.mimeType)
            filenamelb.text = file.fileName
            fileView.isHidden = false
        }
        catch { }
    }
}
extension documentVC{
    func GetDocument(){
        AF.request(APIRouter.GetDocumentRouter(Auth: Share.savedToken as! String))
            .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<DocumentCodable, AFError>) in
                switch response.result {
                    case .failure(let err):
                        print(err.localizedDescription)
                    case .success(let model):
                        if let data = model.data{
                            self.listDocument = data
                        }
                        self.tableview.reloadData()
                    }
                })
    }
    
    func AddSocial(FileName: String, FileType: Int, FileBase64: String){
        AF.request(APIRouter.EditDocumentRouter(FileName: FileName, FileType: FileType, FileBase64: FileBase64, Auth: Share.savedToken as! String))
            .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<MessageCode, AFError>) in
                switch response.result {
                    case .failure(let err):
                        print(err.localizedDescription)
                    case .success(let model):
                        if model.errorCode == 0 {
                            AlertView.instance.showAlert(message: "Successfully", alertType: .success)
                        }else{
                            ErrorCode.instance.Code(Code: model.errorCode ?? 0)
                    }
                        
                }
        })
    }
    func DeleteImage(Id: Int){
        AF.request(APIRouter.DeleteDocumentRouter(DocumentId: Id, Auth: Share.savedToken as! String))
            .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<MessageCode, AFError>) in
                switch response.result {
                    case .failure(let err):
                        print(err.localizedDescription)
                    case .success(let model):
                        if model.errorCode == 0 {
                            AlertView.instance.showAlert(message: "Successfully", alertType: .success)
                            self.GetDocument()
                        }else{
                            ErrorCode.instance.Code(Code: model.errorCode ?? 0)
                    }
                }
            })
    }

}
extension documentVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listDocument != nil {
            return listDocument!.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DocumentTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DocumentCell", for: indexPath) as! DocumentTableViewCell
        cell.Documlb.text = listDocument?[indexPath.row].fileName ?? ""
        cell.RemoveBtn.addTarget(self, action: #selector(connectedDeleteItem(sender:)), for: .touchUpInside)
        cell.RemoveBtn.tag = indexPath.row
        return cell
    }
    @objc func connectedDeleteItem(sender: UIButton){
        DeleteImage(Id: listDocument?[sender.tag].id ?? 0)
    }
}
extension documentVC: UITextFieldDelegate{
    func getRadius() {
     let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didtapview(gesture:)))
        view.addGestureRecognizer(tapGesture)
        SelectFile.addDoneButtonOnKeyboard()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        SelectFile.resignFirstResponder()
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
