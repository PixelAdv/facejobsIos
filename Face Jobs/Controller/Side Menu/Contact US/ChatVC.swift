//
//  ChatVC.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 7/21/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import UIKit
import Alamofire
class ChatVC: UIViewController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backBTN: UIButton!
    @IBOutlet weak var chatCollectionView: UICollectionView!
    @IBOutlet weak var addressLBL: UILabel!
    @IBOutlet weak var phoneLBL: UILabel!
    @IBOutlet weak var nameLBL: UILabel!
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var status: UILabel!
    var participtions: chatModelClient?
    var messagesArray = [Message]()
    var Conversations: ConversationModel?
//    var hubConnection = HubConnection(withUrl: "http://face-jobs.com/Signalr/hubs")
//    var hub: HubProxy!
    var myImage = ""
    let constant = Constants.shared
    let userType = UserDefaults.standard.integer(forKey: "USERTYPE")
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        getParticiation()
        getConversation()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //        DispatchQueue.main.async {
        //            let lastRow: Int = self.chatTableView.numberOfRows(inSection: 0) - 1
        //            let indexPath = IndexPath(row: lastRow, section: 0);
        //            self.chatTableView.scrollToRow(at: indexPath, at: .top, animated: false)
        //        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        hubConnection.stop()
    }
    private func getConversation()
    {
        userType == 1 ? getConverastionForEmployee(JobId: Share.jobApplied_ID) : getConverastion(JobId: Share.jobApplied_ID)
    }
    private func getParticiation()
    {
        userType == 1 ? getParticiantForEmployee(jobId: Share.jobApplied_ID) : getParticiant(jobId: Share.jobApplied_ID)
    }
    private func setUpConnection(RoomId: Int)
    {
        
                connection = SignalR("http://face-jobs.com/Signalr/hubs")
                complexHub = Hub("ChatHub")
                connection.useWKWebView = false
        //        connection.signalRVersion = .v2_2_2
        //        connection.transport = .auto
                connection.headers = ["Authorization":"Bearer \(Share.savedToken ?? "")"]
                complexHub.on("broadCastMessage") { args in
                    print("args",args)
                }
                complexHub.isProxy()
                connection.addHub(complexHub)
                connection.starting = {
        //            do{
        ////                let RoomId = 66
        //                try self.complexHub.invoke("ConnectToTheChatRoom", arguments: [RoomId])
        //            } catch {
        //                print("rrrrrrr",error.localizedDescription)
        //
        //            }
                }
                connection.disconnected = {
                    self.status.text = "disconnected"
                }
                connection.connected = {
                    self.status.text = "Connected"
                    do{
                        print("ConnectionStateWhenConnectedToChatRoom",self.connection.state.rawValue)
                        try self.complexHub.invoke("ConnectToTheChatRoom", arguments: [RoomId])
                        print("succes connected to chat room")
        
        
                    } catch {
                        print("rrrrrrr",error.localizedDescription)
        
                    }
                }
                connection.reconnected = {
                    self.status.text = "disconnected"
                    do{
                        try self.complexHub.invoke("ConnectToTheChatRoom", arguments: [RoomId])
        
                    } catch {
                        print("rrrrrrr",error.localizedDescription)
        
                    }
                }
                connection.error = { [weak self] error in
                    print("errorConnection",error)
                    if let source = error?["source"] as? String , source == "TimeoutException" {
                        print("Connection timed out. Restarting...")
                        self?.connection.start()
                    }
                }
                connection.start()
    }
    private func setUpView()
    {
        status.text = "Starting..."
        chatCollectionView.delegate = self
        chatCollectionView.dataSource = self
        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTableView.tableFooterView = UIView()
        addingGradientLayerToView([#colorLiteral(red: 0.1607843137, green: 0.6705882353, blue: 0.8862745098, alpha: 1).cgColor, #colorLiteral(red: 0, green: 1, blue: 1, alpha: 1).cgColor], view: topView)
        let chatCellNib = UINib(nibName: "ChatTableViewCell", bundle: nil)
        chatTableView.register(chatCellNib, forCellReuseIdentifier: "ChatTableViewCell")
        
        let chatSenderCellNib = UINib(nibName: "ChatSenderTableViewCell", bundle: nil)
        chatTableView.register(chatSenderCellNib, forCellReuseIdentifier: "ChatSenderTableViewCell")
        if constant.isArabic() {
            backBTN.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
    }
    // employee
    func getConverastionForEmployee(JobId: Int)
    {
        AF.request(APIRouter.getConversationsForEmployee(jobID: JobId ,Auth: Share.savedToken as! String))
            .responseDecodable(completionHandler: { (response: DataResponse<ConversationModel, AFError>) in
                print("response",response)
                print("token",Share.savedToken)
                switch response.result {
                case .failure(let err):
                    print(err.localizedDescription)
                case .success(let model):
                    self.setUpConnection(RoomId: model.data?.chatRoomId ?? 0)
                    self.Conversations = model
                    self.chatTableView.reloadData()
                    self.addressLBL.text = model.data?.company?.landLine ?? ""
                    self.nameLBL.text = model.data?.company?.name ?? ""
                    self.phoneLBL.text = model.data?.company?.phoneNumber ?? ""
                }
            })
    }
    private func getParticiantForEmployee(jobId: Int)
    {
        AF.request(APIRouter.getPariticipateForEmployee(JobId: jobId,Auth: Share.savedToken as! String))
            .responseDecodable(completionHandler: { (response: DataResponse<chatModelClient, AFError>) in
                switch response.result {
                case .failure(let err):
                    print(err.localizedDescription)
                case .success(let model):
                    self.participtions = model
                    self.chatCollectionView.reloadData()
                }
            })
    }
    // client
    func getConverastion(JobId: Int)
    {
        AF.request(APIRouter.getConversations(jobID: JobId, Auth: Share.savedToken as! String))
            .responseDecodable(completionHandler: { (response: DataResponse<ConversationModel, AFError>) in
                switch response.result {
                case .failure(let err):
                    print(err.localizedDescription)
                case .success(let model):
                    self.setUpConnection(RoomId: model.data?.chatRoomId ?? 0)
                    self.Conversations = model
                    self.chatTableView.reloadData()
                    self.addressLBL.text = model.data?.company?.landLine ?? ""
                    self.nameLBL.text = model.data?.company?.name ?? ""
                    self.phoneLBL.text = model.data?.company?.phoneNumber ?? ""
                }
            })
    }
    private func getParticiant(jobId: Int)
    {
        AF.request(APIRouter.getPariticipate(JobId: jobId,Auth: Share.savedToken as! String))
            .responseDecodable(completionHandler: { (response: DataResponse<chatModelClient, AFError>) in
                switch response.result {
                case .failure(let err):
                    print(err.localizedDescription)
                case .success(let model):
                    self.participtions = model
                    self.chatCollectionView.reloadData()
                }
            })
    }
    @IBAction func sendButtonClickd(_ sender: Any) {
        let message = textField.text ?? ""
        let chatID = Conversations?.data?.chatRoomId ?? 0
        
        let name = Conversations?.data?.company?.name ?? ""
        if (message != "") && (message != " ") {
            if userType == 2 {
                do {
                    try complexHub.invoke("SendMessage", arguments: [true,chatID,message]) { (data, error) in
                        if let er = error {
                            print("errorr",er)
                        }
                        else {
                            self.Conversations?.data?.messages?.append(Messages(isMyMessage: true, messageOwnerType: 2, message: message, hasAttachment: false, attachmentName: nil, date: "\(Date())", name: name, image: self.myImage, attachmentUrl: nil))
                            self.chatTableView.reloadData()
                            let lastRow: Int = self.chatTableView.numberOfRows(inSection: 0) - 1
                            let indexPath = IndexPath(row: lastRow, section: 0);
                            self.chatTableView.scrollToRow(at: indexPath, at: .top, animated: false)
                        }
                    }
                }
                catch (let error){
                    print("Error catch",error.localizedDescription)
                }
            }
            else {
                do {
                    print("ConnectionStateWhenSendMessage",connection.state.rawValue)
                    print("ChataaID",chatID)
                    //                    try self.complexHub.invoke("ConnectToTheChatRoom", arguments: [chatID])
                    try complexHub.invoke("SendMessage", arguments: [false,chatID,message]) { (data, error) in
                        if let er = error {
                            print("errorr",er)
                        }
                        else {
                            self.Conversations?.data?.messages?.append(Messages(isMyMessage: true, messageOwnerType: 1, message: message, hasAttachment: false, attachmentName: nil, date: "\(Date())", name: name, image: self.myImage, attachmentUrl: nil))
                            self.chatTableView.reloadData()
                            let lastRow: Int = self.chatTableView.numberOfRows(inSection: 0) - 1
                            let indexPath = IndexPath(row: lastRow, section: 0);
                            self.chatTableView.scrollToRow(at: indexPath, at: .top, animated: false)
                        }
                    }
                }
                catch (let error){
                    print("Error catch",error.localizedDescription)
                }
            }
            
        }
        textField.text = ""
    }
    
    
    
    @IBAction func BackPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension ChatVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return participtions?.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "chatCell", for: indexPath) as! chatCell
        guard let CurrentCellData = participtions?.data?[indexPath.row] else {
            return cell
        }
        let image = CurrentCellData.imageUrl ?? ""
        Share.instance.SetimageWithCorner(Path: image, Image: cell.personImage)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 60)
    }
    
}

extension ChatVC : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Conversations?.data?.messages?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = Conversations?.data?.messages?[indexPath.row]
        if message?.isMyMessage ?? false {
            let cell = chatTableView.dequeueReusableCell(withIdentifier: "ChatSenderTableViewCell") as! ChatSenderTableViewCell
            cell.configurCell(text: message?.message ?? "", image: message?.image ?? "", time: message?.date ?? "", name: message?.name ?? "")
            self.myImage = message?.image ?? ""
            return cell
            
        }else {
            let cell = chatTableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell") as! ChatTableViewCell
            cell.configurCell(text: message?.message ?? "", image: message?.image ?? "", time: message?.date ?? "", name: message?.name ?? "")
            return cell
        }
        
    }
    
    
}

struct Message {
    let text: String
    let type: Bool
    
    init(text: String, type: Bool) {
        self.text = text
        self.type = type
    }
}

