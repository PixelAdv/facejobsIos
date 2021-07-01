//
//  acceptedPeopleVC.swift
//  Face Jobs
//
//  Created by Apple on 3/2/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
//

import UIKit
import Alamofire
import Braintree
class acceptedPeopleVC: MainViewController{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backBTN: UIButton!
    @IBOutlet weak var topView: UIView!
    let cellIdentifier = "acceptedPeopleCell"
    var acceptedPeopleModel: acceptedPeopleModel?
    let constant = Constants.shared
    var braintreeCelint: BTAPIClient!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        GetAcceptedPeople(JobId: Share.jobApplied_ID)
    }
    private func configurePaypal(amount: Double)
    {
        
        let paypalDriver = BTPayPalDriver(apiClient: braintreeCelint)
        paypalDriver.viewControllerPresentingDelegate = self
        paypalDriver.appSwitchDelegate = self
        let request = BTPayPalRequest(amount: "\(amount)")
        request.currencyCode = "USD"
        paypalDriver.requestOneTimePayment(request) { (tokenizedPayPalAccount, error) in
            if let tokenizedPayPalAccount = tokenizedPayPalAccount {
                print("Got a nonce: \(tokenizedPayPalAccount.nonce)")
               
                let email = tokenizedPayPalAccount.email
                let firstName = tokenizedPayPalAccount.firstName
                let lastName = tokenizedPayPalAccount.lastName
                let phone = tokenizedPayPalAccount.phone
                
                // See BTPostalAddress.h for details
                let billingAddress = tokenizedPayPalAccount.billingAddress
                let shippingAddress = tokenizedPayPalAccount.shippingAddress
            } else if let error = error {
                // Handle error here...
            } else {
                // Buyer canceled payment approval
            }
        }
    }
    private func setUpView()
    {
        braintreeCelint = BTAPIClient(authorization: "sandbox_ykk7xs4v_qy27kr7q948z9kg4")
        tableView.dataSource = self
        tableView.delegate = self
        let cellNib = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: cellIdentifier)
        tableView.tableFooterView = UIView()
        self.addingGradientLayerToView([#colorLiteral(red: 0.1607843137, green: 0.6705882353, blue: 0.8862745098, alpha: 1).cgColor, #colorLiteral(red: 0, green: 1, blue: 1, alpha: 1).cgColor], view: topView)
        if constant.isArabic() {
            backBTN.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        //        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func back_tapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func GetAcceptedPeople(JobId: Int){
        showProgress()
        AF.request(APIRouter.GetAcceptedPeopleRouter(JobId: JobId,lang: constant.getCurrentLanguage(), Auth: Share.savedToken as! String))
            .responseJSON(completionHandler: { (res) in
                print(res)
            })
            .responseDecodable(completionHandler: { (response: DataResponse<acceptedPeopleModel, AFError>) in
                self.dismisProgress()
                switch response.result {
                case .failure(let err):
                    print(err.localizedDescription)
                case .success(let model):
                    if model.errorCode == 0 {
                        self.acceptedPeopleModel = model
                        self.tableView.reloadData()
                    }else{
                        ErrorCode.instance.Code(Code: model.errorCode ?? 0)
                    }
                }
            })
    }
    
}

extension acceptedPeopleVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return acceptedPeopleModel?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! acceptedPeopleCell
        if let currentCellData = acceptedPeopleModel?.data?[indexPath.row] {
            let name = currentCellData.name ?? ""
            let image = currentCellData.image ?? ""
            let preCost = currentCellData.prePrice ?? 0.0
            let postPrice = currentCellData.postPrice ?? "0.0"
            let status = currentCellData.status ?? ""
            cell.jobTitle.text = name
            cell.previousWorkDES.text = "\(preCost)"
            cell.costDEs.text = postPrice
            cell.donotStartYet.text = status
            cell.pay.tag = indexPath.row
            cell.pay.addTarget(self, action: #selector(self.payDidTapped(sender:)), for: .touchUpInside)
            Share.instance.SetimageWithCorner(Path: image, Image: cell.personalImage)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    @objc func payDidTapped(sender: UIButton){
        guard let amount = acceptedPeopleModel?.data?[sender.tag].prePrice else {
            return
        }
            configurePaypal(amount: amount )
    }
    
}

extension acceptedPeopleVC : BTAppSwitchDelegate, BTViewControllerPresentingDelegate {
    
    func paymentDriver(_ driver: Any, requestsPresentationOf viewController: UIViewController) {
    }
    
    func paymentDriver(_ driver: Any, requestsDismissalOf viewController: UIViewController) {
    }
    func appSwitcherWillPerformAppSwitch(_ appSwitcher: Any) {
    }
    
    func appSwitcherWillProcessPaymentInfo(_ appSwitcher: Any) {
        //        hideLoadingUI()
    }
    
    func appSwitcher(_ appSwitcher: Any, didPerformSwitchTo target: BTAppSwitchTarget) {
        
    }
    
    func showLoadingUI() {
    }
    
    @objc func hideLoadingUI() {
      
    }
    
}
