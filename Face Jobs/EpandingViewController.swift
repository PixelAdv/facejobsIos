//
//  EpandingViewController.swift
//  Face Jobs
//
//  Created by Apple on 3/22/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
//

import UIKit

class EpandingViewController: UIViewController {
    @IBOutlet weak var table: UITableView!
    var tableViewData = [CellData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
//        tableViewData = [CellData(isExpanding: false, sectionData:            ["cell1", "cell2", "cell3", "cell4"], titel:                "CellTitle"),
//                         CellData(isExpanding: false, sectionData: ["cell1", "cell2", "cell3", "cell4"], titel: "CellTitle"),
//                         CellData(isExpanding: false, sectionData: ["cell1", "cell2", "cell3", "cell4"], titel: "CellTitle"),
//                         CellData(isExpanding: false, sectionData: ["cell1", "cell2", "cell3", "cell4"], titel: "CellTitle")]

    }
}
extension EpandingViewController: UITableViewDelegate, UITableViewDataSource {
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return UITableViewCell()}
            cell.textLabel?.text = tableViewData[indexPath.row].titel
            return cell
        }
        else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return UITableViewCell()}
//            cell.textLabel?.text = tableViewData[section].sectionData[section]
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
        if tableViewData[indexPath.section].isExpanding == true {
            tableViewData[indexPath.section].isExpanding = false
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .fade)
        }
        else {
            tableViewData[indexPath.section].isExpanding = true
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .fade)
        }
    }
    }
    
    
}
