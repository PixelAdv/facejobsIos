//
//  jobsVC.swift
//  Face Jobs
//
//  Created by Apple on 3/8/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
//

import UIKit
import Alamofire
class jobsVC: MainViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var jobsTableView: UITableView!
    @IBOutlet weak var backBTN: UIButton!
    @IBOutlet weak var previousLBL: UILabel!
    @IBOutlet weak var currentLBL: UILabel!
    @IBOutlet weak var applidLBL: UILabel!
    var listOfCurrentJob: [EmployeeJobsModelData]?
    let constant = Constants.shared
    var currentStatus = "previous"
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpTableView()
        getPreviousJop()
    }
    
    private func setUpTableView()
    {
        applidLBL.alpha = 0
        currentLBL.alpha = 0
        previousLBL.alpha = 1
        jobsTableView.delegate = self
        jobsTableView.dataSource = self
        jobsTableView.tableFooterView = UIView()
        jobsTableView.register(UINib(nibName: "EmployeeJobCell", bundle: nil), forCellReuseIdentifier: "EmployeeJobCell")
    }
    private func setUpView()
    {
        self.navigationController?.navigationBar.isHidden = true
        addingGradientLayerToView([#colorLiteral(red: 0.1607843137, green: 0.6705882353, blue: 0.8862745098, alpha: 1).cgColor, #colorLiteral(red: 0, green: 1, blue: 1, alpha: 1).cgColor], view:  topView)
        if constant.isArabic(){
            backBTN.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
        
    }
    
    
    @IBAction func back_Tapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func jobsButtonTapped(_ sender: UIButton) {
        if sender.tag == 0 {
            applidLBL.alpha = 0
            currentLBL.alpha = 0
            previousLBL.alpha = 1
            currentStatus = "previous"
            getPreviousJop()
        }
        if sender.tag == 1 {
            applidLBL.alpha = 0
            previousLBL.alpha = 0
            currentLBL.alpha = 1
            currentStatus = "current"
            getCurrentJop()
            
        }
        if sender.tag == 2 {
            previousLBL.alpha = 0
            currentLBL.alpha = 0
            applidLBL.alpha = 1
            currentStatus = "applied"
            getappliedJop()
        }
    }
    
}
extension jobsVC {
    private func getPreviousJop()
    {
        showProgress()
        AF.request(APIRouter.getPreviou_JobRouter(lang: constant.getCurrentLanguage(), Page: 1, Auth: Share.savedToken as! String))
            .responseJSON(completionHandler: { (res) in
                print(res)
            })
            .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<EmployeeJobsModel, AFError>) in
                self.dismisProgress()
                switch response.result {
                case .failure(let err):
                    print(err.localizedDescription)
                case .success(let model):
                    if model.errorCode == 0 {
                        listOfCurrentJob = model.data
                        jobsTableView.reloadData()
                        
                    }else{
                        ErrorCode.instance.Code(Code: model.errorCode ?? 0)
                    }
                }
            })
    }
    private func getCurrentJop()
    {
        showProgress()
        AF.request(APIRouter.getCurrentJob_Router(lang: constant.getCurrentLanguage(), Page: 1, Auth: Share.savedToken as! String))
            .responseJSON(completionHandler: { (res) in
                print(res)
            })
            .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<EmployeeJobsModel, AFError>) in
                self.dismisProgress()
                switch response.result {
                case .failure(let err):
                    print(err.localizedDescription)
                case .success(let model):
                    if model.errorCode == 0 {
                        listOfCurrentJob = model.data
                        jobsTableView.reloadData()
                    }else{
                        ErrorCode.instance.Code(Code: model.errorCode ?? 0)
                    }
                }
            })
    }
    private func getappliedJop()
    {
        showProgress()
        AF.request(APIRouter.getAppliedJob_Router(lang: constant.getCurrentLanguage(), Page: 1, Auth: Share.savedToken as! String))
            .responseJSON(completionHandler: { (res) in
                print(res)
            })
            .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<EmployeeJobsModel, AFError>) in
                self.dismisProgress()
                switch response.result {
                case .failure(let err):
                    print(err.localizedDescription)
                case .success(let model):
                    if model.errorCode == 0 {
                        listOfCurrentJob = model.data
                        jobsTableView.reloadData()
                    }else{
                        ErrorCode.instance.Code(Code: model.errorCode ?? 0)
                    }
                }
            })
    }
}
extension jobsVC : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfCurrentJob?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeJobCell", for: indexPath) as! EmployeeJobCell
        guard let currentCellData = listOfCurrentJob?[indexPath.row] else {
            return cell
        }
        let jobImage = currentCellData.companyLogo ?? ""
        let jobDescription = currentCellData.jobDescription ?? ""
        let jobTitel = currentCellData.jobTitle ?? ""
        let jobDate = currentCellData.jobDate ?? ""
        let jobPrice = currentCellData.price ?? 0.0
        cell.jobDate.text = jobDate
        cell.jobDescription.text = jobDescription
        cell.jobTitle.text = jobTitel
        cell.jobPrice.text = "\(jobPrice)"
        cell.jobImage.loadImageFrom(imgUrl: jobImage)
        switch currentStatus {
        case "previous":
            print("currentStatus",currentStatus)
            cell.cancelBTN.isHidden = false
            cell.editBTN.isHidden = true
            cell.cancelBTN.tag = indexPath.row
            cell.cancelBTN.addTarget(self, action: #selector(self.cancelBtnTapped(sender:)), for: .touchUpInside)
        case "current":
            print("currentStatus",currentStatus)
//            cell.s
            cell.cancelBTN.isHidden = true
            cell.editBTN.isHidden = true
        case "applied":
            print("currentStatus",currentStatus)
            cell.cancelBTN.isHidden = true
            cell.editBTN.isHidden = false
            cell.editBTN.tag = indexPath.row
            cell.editBTN.addTarget(self, action: #selector(self.editBtnTapped(sender:)), for: .touchUpInside)
        default:
            print("not selected")
        }
       
        return cell
    }
    
    @objc func editBtnTapped(sender: UIButton)
    {
        
        let applayJobView = Share.storyBoard.instantiateViewController(withIdentifier: "applayViewController") as! applayViewController
        applayJobView.jobID = listOfCurrentJob?[sender.tag].jobId ?? 0
        applayJobView.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(applayJobView, animated: true)
    }
    @objc func cancelBtnTapped(sender: UIButton)
    {
        guard let job_id = listOfCurrentJob?[sender.tag].jobId else {
            return
        }
        print("job_id",job_id)
        showProgress()
        AF.request(APIRouter.finishJob(jobID: job_id,Auth: Share.savedToken as! String))
            .responseJSON(completionHandler: { (res) in
                print(res)
            })
            .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<EmployeeJobsModel, AFError>) in
                self.dismisProgress()
                switch response.result {
                case .failure(let err):
                    print(err.localizedDescription)
                case .success(let model):
                    if model.errorCode == 0 {
                        AlertView.instance.showAlert(message: "finishJob".localized, alertType: .success)
                        self.listOfCurrentJob?.remove(at: sender.tag)
                        jobsTableView.reloadData()
                    }else{
                        AlertView.instance.showAlert(message: "faildFinishJob".localized, alertType: .failure)
                    }
                }
            })
    }
    }
