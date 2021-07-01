//
//  HomeVC.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 6/25/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import UIKit
import SideMenu
import Alamofire

class HomeVC: MainViewController {
    
    @IBOutlet weak var WidthView: UIView!
    @IBOutlet weak var tableview: UITableView!
    var listOfCurrentClientJob: [DataCurrentClientJobCodable]?
    var listOfAvilableJobs: AvilableJobsModel?
    var page: Int = 1
    var currentIndex = 0
    private var shouldShowLoadingCell = false
    var isOpenMenu = false
    let userType = UserDefaults.standard.integer(forKey: "USERTYPE")
    let constant = Constants.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        setuptable()
        getJobForType()
        
    }
    private func getJobForType()
    {
        userType == 1 ? getAvilableJobs(page: page) : GetCurrentJob(page: page)

    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        sendPushToken()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setuptable(){
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableFooterView = UIView()
        tableview.register(UINib(nibName: "PostedJobTableViewCell", bundle: nil), forCellReuseIdentifier: "PostJobCell")
    }
    @IBAction func SidemenuClick(_ sender: Any) {
        let st = UIStoryboard(name: "Main", bundle: nil)
        let vc = st.instantiateViewController(withIdentifier: "SideMenuVewController") as! SideMenuVewController
            self.addChild(vc)
            self.view.addSubview(vc.view)
        }
    override func viewDidAppear(_ animated: Bool) {
        GetProfile()
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if userType == 1 {
            return listOfAvilableJobs?.data?.count ?? 0
        }
        else {
            return listOfCurrentClientJob?.count ?? 0
        }
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PostedJobTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PostJobCell", for: indexPath) as! PostedJobTableViewCell
        if userType == 2{
        Share.instance.SetimageWithCorner(Path: listOfCurrentClientJob?[indexPath.row].imageUrl ?? "", Image: cell.JobImage)
        cell.JobTitlelb.text = listOfCurrentClientJob?[indexPath.row].jobTitle ?? ""
        cell.Joblocationlb.text = listOfCurrentClientJob?[indexPath.row].city ?? ""
        cell.JobDailylb.text = listOfCurrentClientJob?[indexPath.row].jobType ?? ""
        let acceptedPeople = listOfCurrentClientJob?[indexPath.row].numberOfAcceptedPeople ?? 0
        if acceptedPeople == 0 {
            cell.JobApprovedlb.isHidden = true
            cell.PromoteBtn.isHidden = true
            cell.promotoView.isHidden = true
            cell.chatView.isHidden = true
        }
        else {
            cell.JobApprovedlb.text = "Approved ( \(acceptedPeople) )"
            cell.PromoteBtn.setTitle("acceptedPeople".localized, for: .normal)
            cell.PromoteBtn.tag = indexPath.row
            cell.PromoteBtn.addTarget(self, action: #selector(acceptedPeople(sender:)), for: .touchUpInside)
            cell.chatBTN.tag = indexPath.row
            cell.chatBTN.addTarget(self, action: #selector(self.chatCliked(sender:)), for: .touchUpInside)
        }
        
        let numberOfCvs = listOfCurrentClientJob?[indexPath.row].numberOfApplications
        
        if numberOfCvs != 0 {
            let title = "(\(numberOfCvs ?? 0))" + "Cvs".localized
            cell.AvilableBtn.setTitle(title, for: .normal)
        }
        else {
            
            cell.AvilableBtn.isHidden = true
            cell.aviabkleView.isHidden = true
        }
        cell.applayBTN.isHidden = true
        cell.AvilableBtn.tag = indexPath.row
        cell.AvilableBtn.addTarget(self, action: #selector(connectedAvilableCV(sender:)), for: .touchUpInside)
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deleteAction(sender:)), for: .touchUpInside)
        cell.editBTN.tag = indexPath.row
        cell.editBTN.addTarget(self, action: #selector(editAction(sender:)), for: .touchUpInside)
       
        }
        else {
            guard let currentCellData = listOfAvilableJobs?.data?[indexPath.row] else {
                return UITableViewCell()
            }
            
            Share.instance.SetimageWithCorner(Path: currentCellData.image ?? "", Image: cell.JobImage)
            cell.JobTitlelb.text = currentCellData.title ?? ""
            cell.Joblocationlb.text = currentCellData.city ?? ""
            cell.JobDailylb.text = currentCellData.jobType ?? ""
            cell.chatBTN.tag = indexPath.row
            cell.chatBTN.addTarget(self, action: #selector(self.chatCliked(sender:)), for: .touchUpInside)
            cell.applayBTN.tag = indexPath.row
            cell.applayBTN.addTarget(self, action: #selector(self.applayJob(sender:)), for: .touchUpInside)
            cell.AvilableBtn.isHidden = true
            cell.DeleteBtn.isHidden = true
            cell.editBTN.isHidden = true
            cell.applayBTN.isHidden = false
            cell.PromoteBtn.isHidden = true
            cell.chatBTN.isHidden = false
            
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if userType == 1 {
//            let applayJobView = Share.storyBoard.instantiateViewController(withIdentifier: "applayViewController") as! applayViewController
//            applayJobView.jobID = listOfAvilableJobs?.data?[indexPath.row].jobId
//            applayJobView.modalPresentationStyle = .fullScreen
//            self.navigationController?.pushViewController(applayJobView, animated: true)
//        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
extension HomeVC: alertOkButtonTapped {
    func handleTapped() {
        if let id = listOfCurrentClientJob?[currentIndex].JobId{
            if let numberOfAcceptedPeople = listOfCurrentClientJob?[currentIndex].numberOfAcceptedPeople ,numberOfAcceptedPeople == 0 {
                AF.request(APIRouter.DeleteJop(lang: constant.getCurrentLanguage(), JobId: id, Auth: Share.savedToken as! String))
                .responseJSON(completionHandler: { (res) in
                    print(res)
                })
                .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<DeleteJopCodable, AFError>) in
                    switch response.result {
                    case .failure(let err):
                        print(err.localizedDescription)
                    case .success(let model):
                        if model.ErrorCode == 0 {
                            self.listOfCurrentClientJob?.remove(at: currentIndex)
                            let index = IndexPath(row: currentIndex, section: 0)
                            self.tableview.deleteRows(at: [index], with: .automatic)
                            self.tableview.reloadData()
                        }else{
                            ErrorCode.instance.Code(Code: model.ErrorCode )
                        }
                    }
                })
        }
            else {
                let emergencyViewController = Share.storyBoard.instantiateViewController(withIdentifier: "EmergencyPage") as! EmergencyVC
                emergencyViewController.job_id = id
                emergencyViewController.modalPresentationStyle = .fullScreen
                self.present(emergencyViewController, animated: true, completion: nil)
            }
        }
    }
    
}
extension HomeVC{
    
    func GetCurrentJob(page: Int){
        self.showProgress()
        let token = UserDefaults.standard.string(forKey: "AccessToken")
        AF.request(APIRouter.GetCurrentJobRouter(lang: constant.getCurrentLanguage(), Page: page, Auth: token!))
            .responseDecodable(completionHandler: {
                (response: DataResponse<CurrentClientJobCodable, AFError>) in
                self.dismisProgress()
                switch response.result {
                case .failure(let err):
                    print(err.localizedDescription)
                case .success(let model):
                    if model.errorCode == 0 {
                        self.listOfCurrentClientJob = model.data
                        self.tableview.reloadData()
                    }else{
//                        ErrorCode.instance.Code(Code: model.errorCode ?? 0)
                    }
                }
            })
    }
    
    func sendPushToken()
    {
        let token = UserDefaults.standard.string(forKey: "Firebase_TOKEN") ?? ""
        AF.request(APIRouter.sendPushToken(Auth: Share.savedToken as! String, Push_token: token))
            .responseDecodable(completionHandler: { (response: DataResponse<responseModel, AFError>) in
                self.dismisProgress()
                switch response.result {
                case .failure(let err):
                    print(err.localizedDescription)
                case .success(_):
                  print("token Sent succefully")
                }
            })
    }
    func getAvilableJobs(page: Int)
    {
        self.showProgress()
        AF.request(APIRouter.GetAvilableJobsRouter(lang: constant.getCurrentLanguage(), Page: page, Auth: Share.savedToken as! String))
            .responseDecodable(completionHandler: { (response: DataResponse<AvilableJobsModel, AFError>) in
                self.dismisProgress()
                print("AvilableJobs",response)
                switch response.result {
                case .failure(let err):
                    print(err.localizedDescription)
                case .success(let model):
                    if model.errorCode == 0 {
                        self.listOfAvilableJobs = model
                        self.tableview.reloadData()
                    }else{
//                        ErrorCode.instance.Code(Code: model.errorCode ?? 0)
                    }
                }
            })
    }
    func GetProfile(){
        self.showProgress()
        var profileUrl =  APIRouter.GetProfile(lang: constant.getCurrentLanguage(), Auth: Share.savedToken as! String)
        if userType == 2  {
            profileUrl = APIRouter.GetProfile(lang: constant.getCurrentLanguage(), Auth: Share.savedToken as! String)
        }
        // get profile for emplpoyee
        else if userType == 1
        {
            profileUrl = APIRouter.getEmployeeProfile(lang: constant.getCurrentLanguage(), Auth: Share.savedToken as! String)
        }
        AF.request(profileUrl)
            .responseDecodable(completionHandler: { (response: DataResponse<ProfileCodable, AFError>) in
                self.dismisProgress()
                switch response.result {
                case .failure(let err):
                    print(err.localizedDescription)
                case .success(let model):
                    Share.Profile_Name = model.data?.companyName ?? ""
                    Share.Profile_Email = model.data?.email ?? ""
                    Share.Profile_Coin = model.data?.coins ?? 0.0
                    Share.Profile_wallet = model.data?.wallet ?? 0.0
                    Share.Profile_Image = model.data?.imageUrl ?? ""
                }
            })
    }
}

extension HomeVC: SideMenuNavigationControllerDelegate {
    func SetupMenu(){
        SideMenuManager.default.leftMenuNavigationController = storyboard?.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? SideMenuNavigationController
        SideMenuManager.default.rightMenuNavigationController = storyboard?.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? SideMenuNavigationController
        SideMenuManager.default.addPanGestureToPresent(toView: navigationController!.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: view)
        SideMenuManager.default.leftMenuNavigationController?.menuWidth = (self.WidthView.frame.width) - 50
        SideMenuManager.default.leftMenuNavigationController?.presentationStyle =  .menuSlideIn
        if constant.isArabic() {
            
            SideMenuManager.default.leftMenuNavigationController?.leftSide = false
            SideMenuManager.default.rightMenuNavigationController?.leftSide = false
        }
        else {
            SideMenuManager.default.leftMenuNavigationController?.leftSide = true
            SideMenuManager.default.rightMenuNavigationController?.leftSide = false
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sideMenuNavigationController = segue.destination as? SideMenuNavigationController else { return }
        sideMenuNavigationController.settings = makeSettings()
    }
    private func makeSettings() -> SideMenuSettings {
        var settings = SideMenuSettings()
        settings.presentationStyle = .menuSlideIn
        settings.menuWidth = (self.WidthView.frame.width) - 50
        return settings
    }
    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Appearing! (animated: \(animated))")
    }
    
    func sideMenuDidAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Appeared! (animated: \(animated))")
    }
    
    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappearing! (animated: \(animated))")
    }
    
    func sideMenuDidDisappear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappeared! (animated: \(animated))")
    }
}

extension HomeVC{
    @objc func connectedAvilableCV(sender: UIButton){
        Share.jobApplied_ID = listOfCurrentClientJob?[sender.tag].JobId ?? 0
        let vc = Share.storyBoard.instantiateViewController(identifier: "ResumesPage")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func acceptedPeople(sender: UIButton){
        print("acceptedPeople")
        Share.jobApplied_ID = listOfCurrentClientJob?[sender.tag].JobId ?? 0
        let vc = Share.storyBoard.instantiateViewController(identifier: "acceptedPeopleVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func chatCliked(sender: UIButton)
    {
        if userType == 2 {
            Share.jobApplied_ID = listOfCurrentClientJob?[sender.tag].JobId ?? 0
        }
        else {
            Share.jobApplied_ID = listOfAvilableJobs?.data?[sender.tag].jobId ?? 0
                    }
        print("Share.jobApplied_ID33",Share.jobApplied_ID)
        let vc = Share.storyBoard.instantiateViewController(identifier: "chatPage")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func applayJob(sender: UIButton)
    {
        let applayJobView = Share.storyBoard.instantiateViewController(withIdentifier: "applayViewController") as! applayViewController
        applayJobView.jobID = listOfAvilableJobs?.data?[sender.tag].jobId
        applayJobView.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(applayJobView, animated: true)
    }
    @objc func deleteAction(sender: UIButton){
        self.currentIndex = sender.tag
        let vc = alertWithTwoButton.loadFromNib()
        vc.view.frame = self.view.bounds
        self.addChild(vc)
        vc.messageLbl.text = "deleteJob".localized
        vc.delegate = self
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    @objc func editAction(sender: UIButton){
        print(sender.tag)
        let addJobVC = Share.storyBoard.instantiateViewController(withIdentifier: "jobViewController") as! jobViewController
        addJobVC.isEdit = true
        addJobVC.jobID = listOfCurrentClientJob?[sender.tag].JobId ?? 0
        addJobVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(addJobVC, animated: true)
    }
}
