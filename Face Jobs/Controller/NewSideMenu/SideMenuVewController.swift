//
//  SideMenuVewController.swift
//  Face Jobs
//
//  Created by Apple on 3/22/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
//  Share.UserTypeId


import UIKit

class SideMenuVewController: UIViewController {

    @IBOutlet weak var sideMenuTable: UITableView!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileEmail: UILabel!
    @IBOutlet weak var profileCoins: UILabel!
    @IBOutlet weak var leadingViewConstraints: NSLayoutConstraint!
   
    let sideMenuCellIdentifier = "sideMenuCell"
    var tableViewData = [CellData]()
    let userType = UserDefaults.standard.integer(forKey: "USERTYPE")
    // Data Source for expanding profile Section
    var profile_infoData = [sectionDataSource(sectionTitle: "basicInfo".localized, sectionPhoto: UIImage(named: "Profile") ?? UIImage()),
        sectionDataSource(sectionTitle: "experience".localized, sectionPhoto: UIImage(named: "Profile") ?? UIImage()),
        sectionDataSource(sectionTitle: "education".localized, sectionPhoto: UIImage(named: "Profile") ?? UIImage()),
        sectionDataSource(sectionTitle: "address".localized, sectionPhoto: UIImage(named: "Address Profile") ?? UIImage()),
        sectionDataSource(sectionTitle: "document".localized, sectionPhoto: UIImage(named: "Docum Profile") ?? UIImage()),
        sectionDataSource(sectionTitle: "social".localized, sectionPhoto: UIImage(named: "Social Profile") ?? UIImage()),
        sectionDataSource(sectionTitle: "gallery".localized, sectionPhoto: UIImage(named: "Gallery Profile") ?? UIImage()),
        sectionDataSource(sectionTitle: "setting".localized, sectionPhoto: UIImage(named: "Setting Profile") ?? UIImage())]
    // DataSpurce for Expanding Job Section
    var Job_Data = [sectionDataSource(sectionTitle: "jobs".localized, sectionPhoto: UIImage(named: "offers Jobs") ?? UIImage()),
        sectionDataSource(sectionTitle: "offers".localized, sectionPhoto: UIImage(named: "offers Jobs") ?? UIImage()),
        sectionDataSource(sectionTitle: "currentJobs".localized, sectionPhoto: UIImage(named: "Current jobs") ?? UIImage()),
        sectionDataSource(sectionTitle: "jobsApplicant".localized, sectionPhoto: UIImage(named: "Jobs applications Job") ?? UIImage()),
        sectionDataSource(sectionTitle: "jobPrevious".localized, sectionPhoto: UIImage(named: "Previous jobs") ?? UIImage())
//        sectionDataSource(sectionTitle: "emergencyNotice".localized, sectionPhoto: UIImage(named: "Emergency notice") ?? UIImage())
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        ConfigureTabelView()
        GetProfile()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        leadingViewConstraints.constant = 0
        UIView.animate(withDuration: 0.3) {[unowned self] in
            self.view.layoutIfNeeded()
        }
        
    }
    private func ConfigureTabelView()
    {
        sideMenuTable.delegate = self
        sideMenuTable.dataSource = self
        let sideMenuCellNib = UINib(nibName: sideMenuCellIdentifier, bundle: nil)
        sideMenuTable.register(sideMenuCellNib, forCellReuseIdentifier: sideMenuCellIdentifier)
        
    }
    private func setUpView()
    {
        leadingViewConstraints.constant = -view.bounds.width
        // table Data Source
        tableViewData = [CellData(isExpanding: false, sectionData: profile_infoData, titel: "profile".localized ,image: UIImage(named: "Profile") ?? UIImage()),
                         CellData(isExpanding: false, sectionData: Job_Data, titel: "jobs".localized, image: UIImage(named: "Profile") ?? UIImage()),
                         CellData(isExpanding: false, sectionData: [], titel: "addJob".localized,image: UIImage(named: "info Profile") ?? UIImage()),
                         CellData(isExpanding: false, sectionData: [], titel: "inviteFriend".localized,image: UIImage(named: "Invite Friend") ?? UIImage()),
                         CellData(isExpanding: false, sectionData: [], titel: "about".localized,image: UIImage(named: "About") ?? UIImage()),
                         CellData(isExpanding: false, sectionData: [], titel: "logout".localized,image: UIImage(named: "logout") ?? UIImage())]
        
    }
    
}
extension SideMenuVewController{
 
    @IBAction func closeMenu(_ sender: UIButton) {
        closeMenu()
    }
}
extension SideMenuVewController{
    func GetProfile(){
        let userDefault = UserDefaults.standard
        let FIRST_NAME = userDefault.string(forKey: "FIRST_NAME") ?? ""
        let LAST_NAME = userDefault.string(forKey: "LAST_NAME") ?? ""
        let COMPANY_NAME = userDefault.string(forKey: "COMPANY_NAME") ?? ""
        let completeName = "\(FIRST_NAME)  \(LAST_NAME)"
        userType == 2 ? (profileName.text = completeName) : (profileName.text = completeName)
        self.profileEmail.text = Share.Profile_Email
//        self.profileName.text = Share.Profile_Name
        Share.instance.SetimageWithCorner(Path: Share.Profile_Image, Image: self.profilePicture)

        if Share.Profile_Coin == 0.0{
            if Share.Profile_wallet == 0.0{
                self.profileCoins.text = ""
            }else{
                self.profileCoins.text = "Wallet: \(Share.Profile_wallet)"
            }
        }else{
            if Share.Profile_wallet == 0.0{
                self.profileCoins.text = "Coin: \(Share.Profile_Coin)"

            }else{
                self.profileCoins.text = "Coin: \(Share.Profile_Coin), Wallet: \(Share.Profile_wallet)"
            }
        }
    }
}

extension SideMenuVewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].isExpanding {
            return tableViewData[section].sectionData.count + 1
        }
        else {
           return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.row - 1
        if indexPath.row == 0 {
             let cell = tableView.dequeueReusableCell(withIdentifier: sideMenuCellIdentifier) as! sideMenuCell
            cell.titleLBL.text = tableViewData[indexPath.section].titel
            cell.rightImage.image = tableViewData[indexPath.section].image
            cell.leadingPhotoConstraint.constant = 10
            if indexPath.section == 0 || indexPath.section == 1 {
            if tableViewData[indexPath.section].isExpanding == true {
                cell.leftImage.isHidden = false
            }
            else {
                cell.leftImage.image = #imageLiteral(resourceName: "Action Side menu left")
                cell.leftImage.isHidden = false
            }
            }
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: sideMenuCellIdentifier) as! sideMenuCell
            cell.leftImage.isHidden = true
            cell.titleLBL.text = tableViewData[indexPath.section].sectionData[section].sectionTitle
            cell.rightImage.image = tableViewData[indexPath.section].sectionData[section].sectionPhoto
            if tableViewData[indexPath.section].sectionData.count > 0 {
            cell.leadingPhotoConstraint.constant = 30
            cell.RightImageLeading.constant = 18
            }
            
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // switch Section
        switch indexPath.section {
        // switch expanding profile section
        case 0:
            if tableViewData[indexPath.section].isExpanding == true {
                tableViewData[indexPath.section].isExpanding = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .fade)
                switch indexPath.row {
                case 1:
                    goToViewControllerFromSideMenu(viewIdentifier: "BasicInfoPage")
                case 2:
                    goToViewControllerFromSideMenu(viewIdentifier: "ExperienceVc")
                case 3:
                    goToViewControllerFromSideMenu(viewIdentifier: "EducationVc")
                case 4:
                  goToViewControllerFromSideMenu(viewIdentifier: "AddressPage")
                case 5:
                    goToViewControllerFromSideMenu(viewIdentifier: "DocumentPage")
                case 6:
                    goToViewControllerFromSideMenu(viewIdentifier: "SocialPage")
                case 7:
                    goToViewControllerFromSideMenu(viewIdentifier: "GalleryPage")
                case 8:
                    let vc = Share.storyBoard.instantiateViewController(withIdentifier: "SettingPage")
                    let uinavigation = UINavigationController(rootViewController: vc)
                    uinavigation.modalPresentationStyle = .fullScreen
                    self.present(uinavigation, animated: true, completion: nil)
                    closeMenu()
                default:
                    print("Defulat")
                }
            }
            else {
                tableViewData[indexPath.section].isExpanding = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .fade)
            }
        // switch expanding jobs section
        case 1:
            if tableViewData[indexPath.section].isExpanding == true {
                tableViewData[indexPath.section].isExpanding = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .fade)
                switch indexPath.row {
                case 1:
                    let vc = Share.storyBoard.instantiateViewController(withIdentifier: "jobsVC")
                    let uinavigation = UINavigationController(rootViewController: vc)
                    uinavigation.modalPresentationStyle = .fullScreen
                    self.present(uinavigation, animated: true, completion: nil)
                    closeMenu()

                case 2:
                    goToViewControllerFromSideMenu(viewIdentifier: "PendingPage")
                case 3:
                closeMenu()
                case 4:
                    print("job applicant")
                    goToViewControllerFromSideMenu(viewIdentifier: "ResumesPage")
                case 5:
                    let addJobVC = Share.storyBoard.instantiateViewController(withIdentifier: "previousPage")
                    addJobVC.modalPresentationStyle = .fullScreen
                    self.navigationController?.pushViewController(addJobVC, animated: true)
                    closeMenu()
                case 6:
                    goToViewControllerFromSideMenu(viewIdentifier: "EmergencyPage")
                default:
                    print("Defulat")
                }
            }
            else {
                tableViewData[indexPath.section].isExpanding = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .fade)
            }
        case 2:
            let addJobVC = Share.storyBoard.instantiateViewController(withIdentifier: "jobViewController")
            addJobVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(addJobVC, animated: true)
            closeMenu()
        case 3:
            inviteFriend()
        case 4:
            goToViewControllerFromSideMenu(viewIdentifier: "contactusPage")
        case 5:
            logout()
        default:
            print("Defulat")
        }
       
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if userType == 2 {
            // hide experience and education from profile Section
            if indexPath.section == 0 {
                if indexPath.row == 2 ||  indexPath.row == 3 {
                    return 0
                }
        }
            // hide job from jobs section
            else if  indexPath.section == 1 {
                if indexPath.row == 1 {
                    return 0
                }
            }
        }
        else if userType == 1 {
             if indexPath.section == 1 {
                // hide all row except job row
                if indexPath.row == 1 || indexPath.row == 0 {
                }
                else {
                    return 0
                }
                
            }
            if indexPath.section == 2 {
                return 0
            }
            
        }
        return 50
    }
    
}

extension SideMenuVewController{
    private func inviteFriend()
    {
        guard let url = URL(string: "https://apps.apple.com/us/app/key-by-amazon/id1291586307") else {
            return
        }
        let items: [Any] = ["FaceJobs", url, #imageLiteral(resourceName: "Logo Backgound")]
        let vc = VisualActivityViewController(activityItems: items, applicationActivities: nil)
        vc.previewNumberOfLines = 10
        presentActionSheet(vc, from: self.view)
        closeMenu()
    }
    private func logout()
    {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "isLogin")
        defaults.removeObject(forKey: "AccessToken")
        defaults.synchronize()
        Share.savedToken = nil
        UserDefaults.standard.set(Share.savedToken, forKey: "AccessToken")
        UserDefaults.standard.synchronize()
        self.ShareViewController(withIdentifier: "loginPage")
    }
    private func goToViewControllerFromSideMenu(viewIdentifier: String)
    {
        ShareViewController(withIdentifier: viewIdentifier)
        closeMenu()
    }
    func closeMenu(){
        leadingViewConstraints.constant = -view.bounds.width
        UIView.animate(withDuration: 0.3, animations: {[weak self] in
            self?.view.layoutIfNeeded()
        }) { (_) in
            self.removeFromParent()
            self.view.removeFromSuperview()
        }
        
    }
    private func presentActionSheet(_ vc: VisualActivityViewController, from view: UIView) {
        if UIDevice.current.userInterfaceIdiom == .pad {
            vc.popoverPresentationController?.sourceView = view
            vc.popoverPresentationController?.sourceRect = view.bounds
            vc.popoverPresentationController?.permittedArrowDirections = [.right, .left]
        }
        present(vc, animated: true, completion: nil)
    }
}

struct CellData {
    var isExpanding = Bool()
    var sectionData = [sectionDataSource]()
    var titel = String()
    var image = UIImage()
}
struct sectionDataSource {
    var sectionTitle = String()
    var sectionPhoto = UIImage()
}
