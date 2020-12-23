//
//  ErrorCode.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 6/24/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import Foundation

class ErrorCode{
    static let instance = ErrorCode()
    func Code(Code: Int){
        switch Code{
        case 0:
            AlertView.instance.showAlert(message: "Success".localized, alertType: .success)
        case 1:
            AlertView.instance.showAlert(message: "LoginRequired".localized, alertType: .failure)
        case 2:
            AlertView.instance.showAlert(message: "Somewrong".localized, alertType: .failure)
        case 3:
            AlertView.instance.showAlert(message: "Providerrequired".localized, alertType: .failure)
        case 4:
            AlertView.instance.showAlert(message: "PasswordIsRequired".localized, alertType: .failure)
        case 5:
            AlertView.instance.showAlert(message: "PasswordFieldMustBeChars".localized, alertType: .failure)
        case 6:
            AlertView.instance.showAlert(message: "InvalidEmail".localized, alertType: .failure)
        case 7:
            AlertView.instance.showAlert(message: "InvalidPhoneNumber".localized, alertType: .failure)
        case 8:
            AlertView.instance.showAlert(message: "UserNotFound".localized, alertType: .failure)
        case 9:
            AlertView.instance.showAlert(message: "InvalidRefreshToken".localized, alertType: .failure)
        case 10:
            AlertView.instance.showAlert(message: "TokenProblemOccured".localized, alertType: .failure)
        case 11:
            AlertView.instance.showAlert(message: "RegisterDataIsRequired".localized, alertType: .failure)
        case 12:
            AlertView.instance.showAlert(message: "FirstNameFieldIsRequired".localized, alertType: .failure)
        case 13:
            AlertView.instance.showAlert(message: "LastNameFieldIsRequired".localized, alertType: .failure)
        case 14:
            AlertView.instance.showAlert(message: "EmailFieldIsRequired".localized, alertType: .failure)
        case 15:
            AlertView.instance.showAlert(message: "PhoneFieldIsRequired".localized, alertType: .failure)
        case 16:
            AlertView.instance.showAlert(message: "InvalidUserType".localized, alertType: .failure)
        case 17:
            AlertView.instance.showAlert(message: "CompanyNameFieldIsRequired".localized, alertType: .failure)
        case 18:
            AlertView.instance.showAlert(message: "PasswordDoNotMatch".localized, alertType: .failure)
        case 19:
            AlertView.instance.showAlert(message: "DateOfBirthFieldIsRequired".localized, alertType: .failure)
        case 20:
            AlertView.instance.showAlert(message: "FailedToCreateTheAccount".localized, alertType: .failure)
        case 21:
            AlertView.instance.showAlert(message: "FailedToCreateRolesForTheAccount".localized, alertType: .failure)
        case 22:
            AlertView.instance.showAlert(message: "PushTokenFieldIsRequired".localized, alertType: .failure)
        case 23:
            AlertView.instance.showAlert(message: "OperatingSystemIsInvalid".localized, alertType: .failure)
        case 24:
            AlertView.instance.showAlert(message: "EmailAlreadyExists".localized, alertType: .failure)
        case 25:
            AlertView.instance.showAlert(message: "PhoneAlreadyExists".localized, alertType: .failure)
        case 26:
            AlertView.instance.showAlert(message: "ChangePasswordDataIsRequired".localized, alertType: .failure)
        case 27:
            AlertView.instance.showAlert(message: "OldPasswordFieldIsRequired".localized, alertType: .failure)
        case 28:
            AlertView.instance.showAlert(message: "NewPasswordFieldIsRequired".localized, alertType: .failure)
        case 29:
            AlertView.instance.showAlert(message: "FailedToChangePassword".localized, alertType: .failure)
        case 30:
            AlertView.instance.showAlert(message: "WrongPasswordProvided".localized, alertType: .failure)
        case 31:
            AlertView.instance.showAlert(message: "UserNotAuthorized".localized, alertType: .failure)
        case 32:
            AlertView.instance.showAlert(message: "TheAccountIsBlocked".localized, alertType: .failure)
        case 33:
            AlertView.instance.showAlert(message: "ClientNotFound".localized, alertType: .failure)
        case 34:
            AlertView.instance.showAlert(message: "ImageIsRequired".localized, alertType: .failure)
        case 35:
            AlertView.instance.showAlert(message: "FailedToUploadTheImage".localized, alertType: .failure)
        case 36:
            AlertView.instance.showAlert(message: "LandlineFieldIsRequired".localized, alertType: .failure)
        case 37:
            AlertView.instance.showAlert(message: "LandlineAlreadyExists".localized, alertType: .failure)
        case 38:
            AlertView.instance.showAlert(message: "InvalidFacebookUrl".localized, alertType: .failure)
        case 39:
            AlertView.instance.showAlert(message: "InvalidTwitterUrl".localized, alertType: .failure)
        case 40:
            AlertView.instance.showAlert(message: "InvalidInstagramUrl".localized, alertType: .failure)
        case 41:
            AlertView.instance.showAlert(message: "InvalidLinkedInUrl".localized, alertType: .failure)
        case 42:
            AlertView.instance.showAlert(message: "InvalidWebsiteUrl".localized, alertType: .failure)
        case 43:
            AlertView.instance.showAlert(message: "InvalidOtherUrl".localized, alertType: .failure)
        case 44:
            AlertView.instance.showAlert(message: "NullObjectProvided".localized, alertType: .failure)
        case 45:
            AlertView.instance.showAlert(message: "InvalidGalleryType".localized, alertType: .failure)
        case 46:
            AlertView.instance.showAlert(message: "ImageNotFound".localized, alertType: .failure)
        case 47:
            AlertView.instance.showAlert(message: "FileIsRequired".localized, alertType: .failure)
        case 48:
            AlertView.instance.showAlert(message: "FileNameIsRequired".localized, alertType: .failure)
        case 49:
            AlertView.instance.showAlert(message: "InvalidMediaType".localized, alertType: .failure)
        case 50:
            AlertView.instance.showAlert(message: "FailedToUploadTheFile".localized, alertType: .failure)
        case 51:
            AlertView.instance.showAlert(message: "UserDoesNotHaveEnoughCoins".localized, alertType: .failure)
        case 52:
            AlertView.instance.showAlert(message: "ForgetPasswordDataIsRequired".localized, alertType: .failure)
        case 53:
            AlertView.instance.showAlert(message: "EmailNotFound".localized, alertType: .failure)
        case 54:
            AlertView.instance.showAlert(message: "FailedToSendTheEmail".localized, alertType: .failure)
        case 55:
            AlertView.instance.showAlert(message: "AddJobDataIsMissing".localized, alertType: .failure)
        case 56:
            AlertView.instance.showAlert(message: "JobTitleFieldIsRequired".localized, alertType: .failure)
        case 57:
            AlertView.instance.showAlert(message: "JobDescriptionFieldIsRequired".localized, alertType: .failure)
        case 58:
            AlertView.instance.showAlert(message: "JobIsMultiDaysFieldIsRequired".localized, alertType: .failure)
        case 59:
            AlertView.instance.showAlert(message: "JobDateTimesFieldIsRequired".localized, alertType: .failure)
        case 60:
            AlertView.instance.showAlert(message: "JobIsBreakAvailableFieldIsRequired".localized, alertType: .failure)
        case 61:
            AlertView.instance.showAlert(message: "JobIsBreakPaidFieldIsRequired".localized, alertType: .failure)
        case 62:
            AlertView.instance.showAlert(message: "JobNumberOfEmployeesFieldIsRequired".localized, alertType: .failure)
        case 63:
            AlertView.instance.showAlert(message: "JobCategoryIdFieldIsRequired".localized, alertType: .failure)
        case 64:
            AlertView.instance.showAlert(message: "InvalidJobType".localized, alertType: .failure)
        case 65:
            AlertView.instance.showAlert(message: "JobCategoryIsNotFound".localized, alertType: .failure)
        case 66:
            AlertView.instance.showAlert(message: "JobDateTimesDayFieldIsRequired".localized, alertType: .failure)
        case 67:
            AlertView.instance.showAlert(message: "JobDateTimesFieldIsInvalid".localized, alertType: .failure)
        case 68:
            AlertView.instance.showAlert(message: "JobDateTimesFromFieldIsInvalid".localized, alertType: .failure)
        case 69:
            AlertView.instance.showAlert(message: "JobDateTimesToFieldIsInvalid".localized, alertType: .failure)
        case 70:
            AlertView.instance.showAlert(message: "UserReachedToTheMaximumNumberOfJobsThat HeCanAdd".localized, alertType: .failure)
        case 71:
            AlertView.instance.showAlert(message: "UserDoesNotHaveJobPackages".localized, alertType: .failure)
        case 72:
            AlertView.instance.showAlert(message: "JobNumberOfEmployeesIsMoreThanCurrentJobPa ckageNumber".localized, alertType: .failure)
        case 73:
            AlertView.instance.showAlert(message: "JobCategoryPaymentMethodIsInvalid".localized, alertType: .failure)
        case 74:
            AlertView.instance.showAlert(message: "JobCategoryCreditTypeRequirePriceNotToBeNull".localized, alertType: .failure)
        case 75:
            AlertView.instance.showAlert(message: "UserDoesNotHaveEnoughWallet".localized, alertType: .failure)
        case 76:
            AlertView.instance.showAlert(message: "InvalidJobTimeType".localized, alertType: .failure)
        case 77:
            AlertView.instance.showAlert(message: "JobTimesAreaRequired".localized, alertType: .failure)
        case 78:
            AlertView.instance.showAlert(message: "JobTimeToFieldMustBeEqualToOrGreaterThankFr omField".localized, alertType: .failure)
        case 79:
            AlertView.instance.showAlert(message: "AreaNotFound".localized, alertType: .failure)
        case 80:
            AlertView.instance.showAlert(message: "CityNotFound".localized, alertType: .failure)
        case 81:
            AlertView.instance.showAlert(message: "CountryNotFound".localized, alertType: .failure)
        case 82:
            AlertView.instance.showAlert(message: "JobAddressFieldIsRequired".localized, alertType: .failure)
        case 83:
            AlertView.instance.showAlert(message: "ClientDocumentNotFound".localized, alertType: .failure)
        case 84:
            AlertView.instance.showAlert(message: "JopNotFound".localized, alertType: .failure)
        default:
            AlertView.instance.showAlert(message: "".localized, alertType: .failure)
            break
        }
    }
}
