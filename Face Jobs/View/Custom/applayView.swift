//
//  applayView.swift
//  Face Jobs
//
//  Created by Apple on 6/11/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
//

import UIKit
import Alamofire
class applayView: MainViewController {

    @IBOutlet weak var priceTypeLBL: UILabel!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var priceTypeTXT: TappedTextField!
    @IBOutlet weak var priceTXT: UITextField!
    @IBOutlet weak var applay: UIButton!
    var prices: [AllPriceTypes] = [AllPriceTypes]()
    var jobID: Int?
    var priceID: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        // Do any additional setup after loading the view.
    }
    private func setUpView(){
        applay.titleLabel?.textAlignment = .center
        priceTypeTXT.tapDelegate = self
        priceView.layer.cornerRadius = 8
        priceView.layer.masksToBounds = true
        priceTypeLBL.layer.cornerRadius = 8
        priceTypeLBL.layer.masksToBounds = true
    }

    @IBAction func dismissBTN(_ sender: Any) {
        self.removeFromParent()
        self.view.removeFromSuperview()
    }
    @IBAction func applayTapped(_ sender: Any) {
        applayforjob()
    }
    private func applayforjob()
    {
        guard let job_ID = jobID else {
            return
        }
        guard let price_id = priceID else {
            AlertView.instance.showAlert(message: "please select price type", alertType: .failure)
            return
        }
        guard let price = priceTXT.text, !prices.isEmpty else {
            AlertView.instance.showAlert(message: "please select salary", alertType: .failure)
            return
        }
        let DoublePrice = Double(price) ?? 0.0
        AF.request(APIRouter.applayJob(jobID: job_ID, RequiredPrice: DoublePrice, PaymentType: price_id, Auth: Share.savedToken as! String))
            .responseDecodable(completionHandler: { (response: DataResponse<jobResponse, AFError>) in
                switch response.result {
                case .failure(let err):
                    print(err.localizedDescription)
                case .success(let model):
                    if model.errorCode == 0{
                        AlertView.instance.showAlert(message: "success_applied".localized, alertType: .failure)
                        self.removeFromParent()
                        self.view.removeFromSuperview()
                    }
                    else {
                        AlertView.instance.showAlert(message: "filure_applied".localized, alertType: .failure)
                        self.removeFromParent()
                        self.view.removeFromSuperview()
                    }
                }
            })
    }
}
extension applayView : TappedTextFieldDelegate {
    func textFieldDidTap(_ textField: TappedTextField) {
        var arrTheme: [String] = [String]()
        for item in prices {
            arrTheme.append(item.name ?? "")
        }
        callTextPickerAppearanceManager(title: "Prices".localized, items: arrTheme, completion: {
            text in
//            self.priceTXT.text = text
            let selectitem = self.prices.first(where: {$0.name == text})
            self.priceTypeTXT.text = selectitem?.name ?? ""
            self.priceID = selectitem?.id ?? 0
        }
        )
    }
}
