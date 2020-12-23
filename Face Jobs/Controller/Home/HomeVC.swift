//
//  HomeVC.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 6/25/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import MOLH
import UIKit
import SideMenu
import Alamofire

class HomeVC: UIViewController {
    
    @IBOutlet weak var WidthView: UIView!
    @IBOutlet weak var tableview: UITableView!
    
    var listOfCurrentClientJob: [DataCurrentClientJobCodable]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetCurrentJob(page: 1)
        SetupMenu()
        addingGradientLayerToNavigationBar([#colorLiteral(red: 0.1607843137, green: 0.6705882353, blue: 0.8862745098, alpha: 1).cgColor, #colorLiteral(red: 0, green: 1, blue: 1, alpha: 1).cgColor])
        setuptable()
    }
    
    func setuptable(){
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableFooterView = UIView()
        tableview.register(UINib(nibName: "PostedJobTableViewCell", bundle: nil), forCellReuseIdentifier: "PostJobCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        GetProfile()
    }
    
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listOfCurrentClientJob != nil {
            return listOfCurrentClientJob!.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PostedJobTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PostJobCell", for: indexPath) as! PostedJobTableViewCell
//        Share.instance.SetimageWithCorner(Path: listOfCurrentClientJob?[indexPath.row].imageUrl ?? "", Image: cell.JobImage)
        cell.JobTitlelb.text = listOfCurrentClientJob?[indexPath.row].jobTitle ?? ""
        cell.Joblocationlb.text = listOfCurrentClientJob?[indexPath.row].city ?? ""
        cell.JobDailylb.text = listOfCurrentClientJob?[indexPath.row].jobType ?? ""
//        cell.JobHourlb.text = listOfCurrentClientJob?[indexPath.row].jobTitle ?? ""
        cell.JobApprovedlb.text = "Approved ( \(listOfCurrentClientJob?[indexPath.row].numberOfAcceptedPeople ?? 0) )"
        cell.AvilableBtn.addTarget(self, action: #selector(connectedAvilableCV(sender:)), for: .touchUpInside)
        cell.AvilableBtn.tag = indexPath.row
        return cell
    }
}
extension HomeVC{
    func GetCurrentJob(page: Int){
        AF.request(APIRouter.GetCurrentJobRouter(lang: MOLHLanguage.currentAppleLanguage(), Page: page, Auth: Share.savedToken as! String))
            .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<CurrentClientJobCodable, AFError>) in
                switch response.result {
                    case .failure(let err):
                        print(err.localizedDescription)
                    case .success(let model):
                        if model.errorCode == 0 {
                            self.listOfCurrentClientJob = model.data
                            self.tableview.reloadData()
                        }else{
                            ErrorCode.instance.Code(Code: model.errorCode ?? 0)
                    }
            }
        })
    }
    
    func GetProfile(){
        AF.request(APIRouter.GetProfile(lang: MOLHLanguage.currentAppleLanguage(), Auth: Share.savedToken as! String))
            .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<ProfileCodable, AFError>) in
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
        SideMenuManager.default.addPanGestureToPresent(toView: navigationController!.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: view)
        SideMenuManager.default.leftMenuNavigationController?.menuWidth = (self.WidthView.frame.width) - 50
        SideMenuManager.default.leftMenuNavigationController?.presentationStyle =  .menuSlideIn
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
        self.ShareViewController(withIdentifier: "ResumesPage")
    }
}
