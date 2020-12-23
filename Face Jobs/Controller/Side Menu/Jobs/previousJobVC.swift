//
//  previousJobVC.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 7/21/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import MOLH
import UIKit
import Alamofire

class previousJobVC: UIViewController {

    @IBOutlet weak var BackBtn: UIBarButtonItem!
    @IBOutlet weak var tableview: UITableView!

    var listPending: [DatapreviousJobCodable]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addingGradientLayerToNavigationBar([#colorLiteral(red: 0.1607843137, green: 0.6705882353, blue: 0.8862745098, alpha: 1).cgColor, #colorLiteral(red: 0, green: 1, blue: 1, alpha: 1).cgColor])
        GetPendingJob(page: 1)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableFooterView = UIView()
        tableview.register(UINib(nibName: "PendingJobTableViewCell", bundle: nil), forCellReuseIdentifier: "PendJobCell")
    }
    
    @IBAction func BackPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
extension previousJobVC: UITableViewDelegate, UITableViewDataSource{
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
        cell.DeleteBtn.tag = indexPath.row
        cell.EditBtn.addTarget(self, action: #selector(editPendingJob(_:)), for: .touchUpInside)
        cell.DeleteBtn.addTarget(self, action: #selector(deletePendingJob(_:)), for: .touchUpInside)
        cell.EditBtn.isHidden = true
        cell.DeleteBtn.isHidden = true
        cell.ResendBtn.isHidden = true
        cell.resendView.isHidden = true
        return cell
    }
}
extension previousJobVC{
    func GetPendingJob(page: Int){
        AF.request(APIRouter.GetpreviousJobRouter(lang: MOLHLanguage.currentAppleLanguage(), Page: page, Auth: Share.savedToken as! String))
            .responseJSON(completionHandler: { (res) in
                print(res)
            })
            .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<previousJobCodable, AFError>) in
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
extension previousJobVC{
    @objc func editPendingJob(_ sender:UIButton){
        if let id = listPending?[sender.tag].JobId{
            AF.request(APIRouter.GetEditJopPageData(lang: MOLHLanguage.currentAppleLanguage(), JobId: id, Auth: Share.savedToken as! String))
                .responseJSON(completionHandler: { (res) in
                    print(res)
                })
                .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<GetEditJopPageDataCodable, AFError>) in
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
                                ErrorCode.instance.Code(Code: model.ErrorCode ?? 0)
                        }
                }
            })
        }
    }
    @objc func deletePendingJob(_ sender:UIButton){
        if let id = listPending?[sender.tag].JobId{
            AF.request(APIRouter.DeleteJop(lang: MOLHLanguage.currentAppleLanguage(), JobId: id, Auth: Share.savedToken as! String))
                .responseJSON(completionHandler: { (res) in
                    print(res)
                })
                .responseDecodable(completionHandler: { [unowned self] (response: DataResponse<DeleteJopCodable, AFError>) in
                    switch response.result {
                        case .failure(let err):
                            print(err.localizedDescription)
                        case .success(let model):
                            if model.ErrorCode == 0 {
                                self.listPending?.remove(at: sender.tag)
                                let index = IndexPath(row: sender.tag, section: 0)
                                self.tableview.deleteRows(at: [index], with: .automatic)
                            }else{
                                ErrorCode.instance.Code(Code: model.ErrorCode ?? 0)
                        }
                }
            })
        }
    }
}
