//
//  Constants.swift
//  Face Jobs
//
//  Created by Apple on 6/9/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
//

import Foundation
import MOLH
class Constants {
  static let shared = Constants()
    func isArabic() -> Bool {
        return MOLHLanguage.isArabic()
    }
    func getCurrentLanguage() -> String {
        return MOLHLanguage.currentAppleLanguage() == "en" ? "en" : "ar"
    }
}
