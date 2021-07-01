//
//  PendingJobVC.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 7/13/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import UIKit
import Alamofire

class PendingJobVC: MainViewController {

    @IBOutlet weak var BackBtn: UIBarButtonItem!
    @IBOutlet weak var tableview: UITableView!
    let constant = Constants.shared
    var listPending: [DataPendingJobCodable]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addingGradientLayerToNavigationBar([#colorLiteral(red: 0.1607843137, green: 0.6705882353, blue: 0.8862745098, alpha: 1).cgColor, #colorLiteral(red: 0, green: 1, blue: 1, alpha: 1).cgColor])
        GetPendingJob(page: 1)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableFooterView = UIView()
        tableview.register(UINib(nibName: "PendingJobTableViewCell", bundle: nil), forCellReuseIdentifier: "PendJobCell")
        title = "pendingJobs".localized
        if constant.isArabic() {
            BackBtn.image = UIImage(named: "backRight")
        }

    }
    @IBAction func BackPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
extension PendingJobVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listPending != nil {
            return listPending!.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PendingJobTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PendJobCell", for: indexPath) as! PendingJobTableViewCell
        Share.instance.SetimageWithCorner(Path: listPending?[indexPath.row].imageUrl ?? "", Image: cell.PendImage)
        cell.PendTitlelb.text = listPending?[indexPath.row].jobTitle ?? ""
        cell.PendDailylb.text = listPending?[indexPath.row].jobType ?? ""
        cell.Pendlocationlb.text = listPending?[indexPath.row].city ?? ""
        cell.EditBtn.tag = indexPath.row
        cell.EditBtn.addTarget(self, action: #selector(editPendingJob(_:)), for: .touchUpInside)
        cell.DeleteBtn.tag = indexPath.row
        cell.DeleteBtn.addTarget(self, action: #selector(deletePendingJob(_:)), for: .touchUpInside)
        cell.ResendBtn.tag = indexPath.row
        cell.ResendBtn.addTarget(self, action: #selector(resendEmailPendingJob(_:)), for: .touchUpInside)
        return cell
    }
}
extension PendingJobVC{
    func GetPendingJob(page: Int){
        showProgress()
        AF.request(APIRouter.GetpendingJobRouter(lang: constant.getCurrentLanguage(), Page: page, Auth: Share.savedToken as! String))
            .responseJSON(completionHandler: { (res) in
                print(res)
            })
            .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<PendingJobCodable, AFError>) in
                self.dismisProgress()
                switch response.result {
                    case .failure(let err):
                        print(err.localizedDescription)
                    case .success(let model):
                        if model.errorCode == 0 {
                            self.listPending = model.data
                            self.tableview.reloadData()
                        }else{
                            ErrorCode.instance.Code(Code: model.errorCode ?? 0)
                    }
            }
        })
    }
}
extension PendingJobVC{
    @objc func editPendingJob(_ sender:UIButton){
        if let id = listPending?[sender.tag].JobId{
            showProgress()
            AF.request(APIRouter.GetEditJopPageData(lang: constant.getCurrentLanguage(), JobId: id, Auth: Share.savedToken as! String))
                .responseJSON(completionHandler: { (res) in
                    print(res)
                })
                .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<GetEditJopPageDataCodable, AFError>) in
                    self.dismisProgress()
                    switch response.result {
                        case .failure(let err):
                            print(err.localizedDescription)
                        case .success(let model):
                            if model.ErrorCode == 0 {
                                let vc = Share.storyBoard.instantiateViewController(withIdentifier: "AddJobPage") as! UINavigationController
                                let addJopVC = vc.viewControllers.first as! AddJobVC
                                addJopVC.JopModel = model
                                self.present(vc, animated: true, completion: nil)
                            }else{
                                ErrorCode.instance.Code(Code: model.ErrorCode )
                        }
                }
            })
        }
    }
    @objc func deletePendingJob(_ sender:UIButton){
        if !listPending!.isEmpty{
            if let id = listPending?[sender.tag].JobId{
                showProgress()
                AF.request(APIRouter.DeleteJop(lang: constant.getCurrentLanguage(), JobId: id, Auth: Share.savedToken as! String))
                    .responseJSON(completionHandler: { (res) in
                        print(res)
                    })
                    .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<DeleteJopCodable, AFError>) in
                        self.dismisProgress()
                        switch response.result {
                            case .failure(let err):
                                print(err.localizedDescription)
                            case .success(let model):
                                if model.ErrorCode == 0 {
                                    self.listPending?.remove(at: sender.tag)
                                    let index = IndexPath(row: sender.tag, section: 0)
                                    self.tableview.deleteRows(at: [index], with: .automatic)
                                }else{
                                    ErrorCode.instance.Code(Code: model.ErrorCode )
                            }
                    }
                })
            }
        }
    }
    @objc func resendEmailPendingJob(_ sender:UIButton){
        if let id = listPending?[sender.tag].JobId{
            showProgress()
            AF.request(APIRouter.ResendConfirmationMail(lang: constant.getCurrentLanguage(), JobId: id, Auth: Share.savedToken as! String))
                .responseJSON(completionHandler: { (res) in
                    print(res)
                })
                .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<DeleteJopCodable, AFError>) in
                    self.dismisProgress()
                    switch response.result {
                        case .failure(let err):
                            print(err.localizedDescription)
                        case .success(let model):
                            if model.ErrorCode == 0 {
                                ErrorCode.instance.Code(Code: model.ErrorCode )
                            }else{
                                ErrorCode.instance.Code(Code: model.ErrorCode )
                        }
                }
            })
        }
    }
}
