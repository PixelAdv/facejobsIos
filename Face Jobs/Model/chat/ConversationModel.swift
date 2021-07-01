//
//  ConversationModel.swift
//  Face Jobs
//
//  Created by Apple on 6/6/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
// ConversationModel

import Foundation
struct ConversationModel : Codable {
    let errorCode : Int?
    let errorMessage : String?
    var data : ConversationModelData?

    enum CodingKeys: String, CodingKey {

        case errorCode = "ErrorCode"
        case errorMessage = "ErrorMessage"
        case data = "Data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try values.decodeIfPresent(Int.self, forKey: .errorCode)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        data = try values.decodeIfPresent(ConversationModelData.self, forKey: .data)
    }
    

}
struct ConversationModelData : Codable {
    let company : Company?
    let chatRoomId : Int?
    var messages : [Messages]?

    enum CodingKeys: String, CodingKey {

        case company = "Company"
        case chatRoomId = "ChatRoomId"
        case messages = "Messages"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        company = try values.decodeIfPresent(Company.self, forKey: .company)
        chatRoomId = try values.decodeIfPresent(Int.self, forKey: .chatRoomId)
        messages = try values.decodeIfPresent([Messages].self, forKey: .messages)
    }

}
struct Company : Codable {
    let phoneNumber : String?
    let landLine : String?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case phoneNumber = "PhoneNumber"
        case landLine = "LandLine"
        case name = "Name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        landLine = try values.decodeIfPresent(String.self, forKey: .landLine)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}
struct Messages : Codable {
    let isMyMessage : Bool?
    let messageOwnerType : Int?
    let message : String?
    let hasAttachment : Bool?
    let attachmentName : String?
    let date : String?
    let name : String?
    let image : String?
    let attachmentUrl : String?
    
    enum CodingKeys: String, CodingKey {

        case isMyMessage = "IsMyMessage"
        case messageOwnerType = "MessageOwnerType"
        case message = "Message"
        case hasAttachment = "HasAttachment"
        case attachmentName = "AttachmentName"
        case date = "Date"
        case name = "Name"
        case image = "Image"
        case attachmentUrl = "AttachmentUrl"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isMyMessage = try values.decodeIfPresent(Bool.self, forKey: .isMyMessage)
        messageOwnerType = try values.decodeIfPresent(Int.self, forKey: .messageOwnerType)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        hasAttachment = try values.decodeIfPresent(Bool.self, forKey: .hasAttachment)
        attachmentName = try values.decodeIfPresent(String.self, forKey: .attachmentName)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        attachmentUrl = try values.decodeIfPresent(String.self, forKey: .attachmentUrl)
    }
    init(isMyMessage : Bool?,
     messageOwnerType : Int?,
     message : String?,
     hasAttachment : Bool?,
     attachmentName : String?,
     date : String?,
     name : String?,
     image : String?,
     attachmentUrl : String?) {
        self.isMyMessage = isMyMessage
        self.messageOwnerType = messageOwnerType
        self.message = message
        self.attachmentName = attachmentName
        self.hasAttachment = hasAttachment
        self.date = date
        self.name = name
        self.image = image
        self.attachmentUrl = attachmentUrl
    }

}
