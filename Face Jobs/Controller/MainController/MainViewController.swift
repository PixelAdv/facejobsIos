//
//  MainViewController.swift
//  Face Jobs
//
//  Created by Apple on 3/4/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var loader: LoadingView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    private func setUpView()
    {
        loader = LoadingView(nibName: "LoadingView", bundle: nil)
        self.addChild(loader)
    }
    func showProgress()
    {
        self.loader.view.frame = self.view.frame
        self.view.addSubview(loader.view)
        self.loader.loader.startAnimating()
    }
    func dismisProgress()
    {
        self.loader.hideLoader()
    }
    func callTextPickerAppearanceManager(title: String, items: [String],completion: @escaping (String)-> Void)
    {
//        var selected_Value = ""
        let theme = YBTextPickerAppearanceManager.init(
            pickerTitle         : title,
            titleTextColor      : .white,
            titleBackground     : UIColor.mainColor,
            searchBarPlaceholder: "search".localized,
            closeButtonTitle    : "Cancel".localized,
            closeButtonColor    : UIColor.mainColor,
            doneButtonTitle     : "Done".localized,
            doneButtonColor     : UIColor.mainColor,
            checkMarkPosition   : .Right,
            itemCheckedImage    : nil,
            itemUncheckedImage  : nil,
            itemColor           : .black
        )
        let picker = YBTextPicker.init(with: items, appearance: theme, onCompletion: {(selectedIndexes, selectedValues) in
            if let selectedValue = selectedValues.first{
                completion(selectedValue)
//                selected_Value = selectedValue
            }else{
               
            }
        }, onCancel: {
            
        })
        picker.show(withAnimation: .FromBottom)
//        return selected_Value
    }
    }

