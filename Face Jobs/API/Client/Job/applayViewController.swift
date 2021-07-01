//
//  applayViewController.swift
//  Face Jobs
//
//  Created by Apple on 6/7/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
//

import UIKit
import Alamofire
class applayViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backBTN: UIButton!
    @IBOutlet weak var jobImage: UIImageView!
    @IBOutlet weak var jobTime: UILabel!
    @IBOutlet weak var jobType: UILabel!
    @IBOutlet weak var jobLocation: UILabel!
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var catigoryLBL: UILabel!
    @IBOutlet weak var typeLBL: UILabel!
    @IBOutlet weak var addressCollectionView: UICollectionView!
    @IBOutlet weak var workingNumberLBL: UILabel!
    @IBOutlet weak var jobPriceLBL: UILabel!
    @IBOutlet weak var paymentLBL: UILabel!
    @IBOutlet weak var expectingHourLBL: UILabel!
    @IBOutlet weak var jobBreakLBL: UILabel!
    @IBOutlet weak var viewTime: NSLayoutConstraint!
    @IBOutlet weak var timeTable: UITableView!
    @IBOutlet weak var descriptionLBL: UILabel!
    @IBOutlet weak var applay: UIButton!
    var jobDetails: JobDetailsModel?
    let constant = Constants.shared
    var Datas:[DateTimesCodable] = [DateTimesCodable]()
    let timeCellIdentifier = "JobTimeCell"
    let addressCellIdentifier = "address_Cell"
    var jobID: Int?
    var isShowDetails = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setTableViewAndCollectionView()
        getJobDetails()

    }
    override func viewWillAppear(_ animated: Bool) {
//        setUpData()
    }
    private func configureData(jobDetails: JobDetailsModel)
    {
        jobTitle.text = jobDetails.data?.jobTitle ?? ""
        jobImage.loadImageFrom(imgUrl: jobDetails.data?.companyImage ?? "")
        jobLocation.text = (jobDetails.data?.addresses?[0].city ?? "") + " " + (jobDetails.data?.companyName ?? "")
        typeLBL.text = jobDetails.data?.jobType ?? ""
        catigoryLBL.text = jobDetails.data?.jobCategory ?? ""
        descriptionLBL.text = jobDetails.data?.jobDescription ?? ""
        if let dates = jobDetails.data?.jobTimes {
            for date in dates {
                Datas.append(DateTimesCodable(Day: date.day ?? "" , TimeFrom: date.timeFrom ?? "", TimeTo: date.timeTo ?? ""))
            }
        }
        paymentLBL.text = jobDetails.data?.paymentMethod ?? ""
        jobPriceLBL.text = "\( jobDetails.data?.jobPrice ?? 0.0)"
        workingNumberLBL.text = "\(jobDetails.data?.numberOfRequiredPeople ?? 0)"
        jobDetails.data?.isJobHasBreak ?? false ? (jobBreakLBL.text = "yes".localized) : (jobBreakLBL.text = "no".localized)
//        jobBreakLBL.text = "\(jobDetails.data?.isJobHasBreak ?? false)"
        expectingHourLBL.text = "\(jobDetails.data?.expectedWorkingHours ?? 0)"
        viewTime.constant = CGFloat((Datas.count)*50) + 20
        jobType.text = jobDetails.data?.createDate ?? ""
        addressCollectionView.reloadData()
        timeTable.reloadData()
        
    }
    private func setUpView()
    {
        isShowDetails ? (applay.isHidden = true) :  (applay.isHidden = false)
        applay.titleLabel?.textAlignment = .center
        self.navigationController?.navigationBar.isHidden = true
        self.addingGradientLayerToView([#colorLiteral(red: 0.1607843137, green: 0.6705882353, blue: 0.8862745098, alpha: 1).cgColor, #colorLiteral(red: 0, green: 1, blue: 1, alpha: 1).cgColor], view: topView)
        if constant.isArabic() {
            backBTN.setImage(UIImage(named: "backRight"), for: .normal)
        }
    }
    private func setTableViewAndCollectionView()
    {
        timeTable.delegate = self
        timeTable.dataSource = self
        addressCollectionView.delegate = self
        addressCollectionView.dataSource = self
        timeTable.register(UINib(nibName: "JobTimeTableViewCell", bundle: nil), forCellReuseIdentifier: timeCellIdentifier)
        timeTable.tableFooterView = UIView()
        addressCollectionView.register(UINib(nibName: addressCellIdentifier, bundle: nil), forCellWithReuseIdentifier: "address_Cell")
    }
   
    
    @IBAction func applayJob(_ sender: Any) {
        let vc  = applayView.loadFromNib()
        vc.view.frame = self.view.frame
        vc.prices = jobDetails?.data?.allPriceTypes ?? [AllPriceTypes]()
        vc.jobID = jobID ?? 0
        self.addChild(vc)
        self.view.addSubview(vc.view)
    }
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension applayViewController{
    private func getJobDetails()
    {
        guard let job_ID = jobID else {
            return
        }
        AF.request(APIRouter.getJobDetail(jobID: job_ID, Auth: Share.savedToken as! String, lang: constant.getCurrentLanguage()))
            .responseDecodable(completionHandler: { (response: DataResponse<JobDetailsModel, AFError>) in
                print("repsone",response)
                switch response.result {
                case .failure(let err):
                    print(err.localizedDescription)
                case .success(let model):
                    if model.errorCode == 0 {
                        self.jobDetails = model
                        self.configureData(jobDetails: model)
                    }
                }
            })
    }
    
}
extension applayViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Datas.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: timeCellIdentifier, for: indexPath) as! JobTimeTableViewCell
        cell.DateJob.text = Datas[indexPath.row].Day ?? ""
        cell.Time1Job.text = Datas[indexPath.row].TimeFrom ?? ""
        cell.Time2Job.text = Datas[indexPath.row].TimeTo ?? ""
        cell.RemoveBtn.isHidden = true
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
}
extension applayViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jobDetails?.data?.addresses?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "address_Cell", for: indexPath) as! address_Cell
        guard let currentCellData = jobDetails?.data?.addresses?[indexPath.row] else {
            return cell
        }
        cell.country.text = currentCellData.country ?? ""
        cell.city.text = currentCellData.city ?? ""
        cell.postalCode.text = currentCellData.postalCode ?? ""
        cell.valiage.text = currentCellData.details ?? ""
        cell.street.text = currentCellData.streetNumber ?? ""
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: addressCollectionView.frame.width, height: addressCollectionView.frame.height)
    }
    
}
