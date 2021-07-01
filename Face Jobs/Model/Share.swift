//
//  Share.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 6/24/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import UIKit
import Foundation
import Kingfisher
import MOLH
class Share{
    static let instance = Share()
    static let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    static var savedToken = UserDefaults.standard.object(forKey: "AccessToken")
    
    static var savedVisbility = UserDefaults.standard.object(forKey: "Visibility")
    static let isLogin:Bool = UserDefaults.standard.bool(forKey: "isLogin")

    static var UserTypeId = 0
    
    static var TypeList: [Types]?
    static var CategoriesList: [Categories]?
    static var PaymentMethodsList: [PaymentMethods]?
    static var CountriesList: [Countries]?
    static var PriceTypesList: [PriceTypes]?
    static var TypeListString = [String]()
    static var CategoriesListString = [String]()
    static var PaymentMethodsListString = [String]()
    static var CountriesListString = [String]()
    static var PriceTypesListString = [String]()
    
    // Profile
    static var Profile_Name = ""
    static var Profile_Email = ""
    static var Profile_Coin = 0.0
    static var Profile_wallet = 0.0
    static var Profile_Image = ""

    // Add Job
    static var Job_Title = ""
    static var Job_Description = ""
    static var Job_TypeId = -1
    static var Job_CategoryId = -1
    static var Job_PaymentMethodJob = -1

    static var Job_Image_String = [String]()
    static var Job_Image = [UIImage]()
    
    static var Job_DateTime = [DateTimesCodable]()
    static var Job_Address = [AddressCodableJob]()
    static var Job_AddressName = [String]()

    static var Job_IsAvilable = false
    static var Job_IsPaid = false

    static var Job_ExpectedWork = ""
    static var Job_WorkingHoursDescription = ""
    static var Job_Price = 0.0
    static var Job_WorkNumber = 0
    static var Job_PaymentType = -1
    static var Job_PaymentMethod = -1
    static var Job_CountryId = -1

    static var address_lat = 0.0
    static var address_long = 0.0

    static var jobApplied_ID = 0
    
    func SetimageWithCorner(Path: String, Image: UIImageView){
        let url = APIRouter.baseURL+Path
        let newURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        Image.kf.setImage(with: URL(string: newURL!)!, placeholder: UIImage.init(named: "image Profile"), options: [.transition(.fade(1)), .cacheOriginalImage], progressBlock: nil, completionHandler: { (downloadImage) in
            if (downloadImage != nil) {
                Image.layer.cornerRadius = Image.frame.height / 2
                Image .clipsToBounds = true
            }
        else
            {
                Image.image = UIImage(named: "Logo Backgound")
                print("Error In load image")
            }
        })
    }
    func SetimageWithout(Path: String, Image: UIImageView){
        let url = APIRouter.baseURL+Path
        let newURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        Image.kf.setImage(with: URL(string: newURL!)!, placeholder: UIImage.init(named: ""), options: [.transition(.fade(1)), .cacheOriginalImage], progressBlock: nil, completionHandler: { (downloadImage) in
            if (downloadImage != nil) {

            }
        else
            {
                Image.image = UIImage(named: "Logo Backgound")
                print("Error In load image")
            }
        })
    }
    
   static func isArabic()-> Bool
    {
        return MOLHLanguage.isArabic()
    }
    static func getCurrentLanguage()-> String{
        return MOLHLanguage.currentAppleLanguage()
    }
   
}

extension UIViewController{
    func ShareViewController(withIdentifier: String){
        let vc = Share.storyBoard.instantiateViewController(withIdentifier: withIdentifier)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
extension String{
    var localized: String{
        return NSLocalizedString(self, comment: "")
    }
}


