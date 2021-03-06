//
//  ResumeAvilableVC.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 8/26/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import MOLH
import UIKit
import Alamofire

class ResumeAvilableVC: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    var listResumes: [DatajobApplicationCodable]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetCurrentJob(JobId: Share.jobApplied_ID)
        addingGradientLayerToNavigationBar([#colorLiteral(red: 0.1607843137, green: 0.6705882353, blue: 0.8862745098, alpha: 1).cgColor, #colorLiteral(red: 0, green: 1, blue: 1, alpha: 1).cgColor])

        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableFooterView = UIView()
        
        tableview.register(UINib(nibName: "ApplicationCVTableViewCell", bundle: nil), forCellReuseIdentifier: "ApplicationCell")
    }
    
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
extension ResumeAvilableVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listResumes != nil {
            return listResumes!.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ApplicationCVTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ApplicationCell", for: indexPath) as! ApplicationCVTableViewCell
        Share.instance.SetimageWithCorner(Path: listResumes?[indexPath.row].Image ?? "", Image: cell.PersonImage)
        cell.personNamelb.text = listResumes?[indexPath.row].name ?? ""
        cell.personRating.rating = listResumes?[indexPath.row].rate ?? 0.0
        cell.previousWorklb.text = "Previous Workes (\(listResumes?[indexPath.row].numberOfFinishedJobs ?? 0))"
        cell.willCostlb.text = "This Will Cost : (\(listResumes?[indexPath.row].Price ?? 0.0)) L.E"
        
        cell.acceptBtn.addTarget(self, action: #selector(connectedAcceptJob(sender:)), for: .touchUpInside)
        cell.acceptBtn.tag = indexPath.row
        
        cell.rejectBtn.addTarget(self, action: #selector(connectedRejectJob(sender:)), for: .touchUpInside)
        cell.rejectBtn.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
}
extension ResumeAvilableVC{
    func GetCurrentJob(JobId: Int){
        AF.request(APIRouter.GetJobApplicationRouter(JobId: JobId, lang: MOLHLanguage.currentAppleLanguage(), Auth: Share.savedToken as! String))
        .responseJSON(completionHandler: { (res) in
            print(res)
        })
            .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<jobApplicationCodable, AFError>) in
                switch response.result {
                    case .failure(let err):
                        print(err.localizedDescription)
                    case .success(let model):
                        if model.errorCode == 0 {
                            self.listResumes = model.data
                            self.tableview.reloadData()
                        }else{
                            ErrorCode.instance.Code(Code: model.errorCode ?? 0)
                    }
            }
        })
    }
    func AcceptJob(JobId: Int){
        AF.request(APIRouter.acceptapplicantRouter(ApplicationId: JobId, Auth: Share.savedToken as! String))
            .responseJSON(completionHandler: { (res) in
                print(res)
            })
            .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<MessageCode, AFError>) in
                switch response.result {
                    case .failure(let err):
                        print(err.localizedDescription)
                    case .success(let model):
                        if model.errorCode == 0 {
                            AlertView.instance.showAlert(message: "]peration accomplished successfully", alertType: .success)
                            self.GetCurrentJob(JobId: Share.jobApplied_ID)
                        }else{
                            ErrorCode.instance.Code(Code: model.errorCode ?? 0)
                    }
            }
        })
    }
    func RejectJob(JobId: Int){
        AF.request(APIRouter.rejectapplicantRouter(ApplicationId: JobId, Auth: Share.savedToken as! String))
            .responseJSON(completionHandler: { (res) in
                print(res)
            })
            .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<MessageCode, AFError>) in
                switch response.result {
                    case .failure(let err):
                        print(err.localizedDescription)
                    case .success(let model):
                        if model.errorCode == 0 {
                            AlertView.instance.showAlert(message: "]peration accomplished successfully", alertType: .success)
                            self.GetCurrentJob(JobId: Share.jobApplied_ID)
                        }else{
                            ErrorCode.instance.Code(Code: model.errorCode ?? 0)
                    }
            }
        })
    }
    @objc func connectedRejectJob(sender: UIButton){
        self.RejectJob(JobId: listResumes?[sender.tag].jobApplicationId ?? 0)
    }
    @objc func connectedAcceptJob(sender: UIButton){
        self.AcceptJob(JobId: listResumes?[sender.tag].jobApplicationId ?? 0)
    }
}
