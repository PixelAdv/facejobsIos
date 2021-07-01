//
//  SecondJobViewController.swift
//  Face Jobs
//
//  Created by Apple on 4/6/21.
//  Copyright © 2021 Eslam Hassan. All rights reserved.
//

import UIKit
extension jobViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == photoCollecction {
        return JobImages.count
            
        }
        else {
            return addresses.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == photoCollecction {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! AddJobImageCollectionViewCell
        cell.imageProJob.image = JobImages[indexPath.row]
        return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddressCell", for: indexPath) as! AddressCell
            cell.addressLabel.text = "address \(indexPath.row + 1)"
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == photoCollecction {
        let cellSize = CGSize(width: (photoCollecction.frame.width)/3, height: (100))
        return cellSize
        }
        else{
            let cellSize = CGSize(width: (addressCollection.frame.width)/3, height: addressCollection.frame.height - 10)
            return cellSize
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == photoCollecction {
        return 0
        }
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == photoCollecction {
        return 0
        }
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // delete image
        if collectionView == photoCollecction {
        let actionSheet = UIAlertController(title: "Confirm".localized, message: "do you want to delete this photo ?".localized, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "delete", style: .destructive, handler: { (action) in
            self.JobImages.remove(at: indexPath.row)
            self.photoCollecction.reloadData()
        }))
            actionSheet.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil))
        present(actionSheet, animated: true, completion: nil)
        }
        else {
            let index = indexPath.row
            postalCode.text = addresses[index].PostalCode ?? ""
            let filterdCountry = countriesModel.filter { (country) in
                country.id == addresses[index].CountryId ?? 0
            }
            let filterdCity = citiesModel.filter { (city) in
                city.id == addresses[index].CityId ?? 0
            }
            let filterdArea = areaModel.filter { (area) in
                area.id == addresses[index].AreaId ?? 0
            }
            country.text = filterdCountry.first?.name ?? ""
            cityTXXT.text = filterdCity.first?.name ?? ""
            valiageTXT.text = filterdArea.first?.name ?? ""
            moreDetailsTXT.text = addresses[index].Details ?? ""
            streetTxt.text = addresses[index].Street ?? ""
        }
    }
   
}
extension jobViewController: ImagePickerDelegate{
    func didSelect(image: UIImage?) {
        guard let selectedImage = image else {
            return
        }
        JobImages.append(selectedImage)
        let imageData = selectedImage.jpegData(compressionQuality: 0.5)
        let imageBase64 = imageData!.base64EncodedString()
        jobsImagesString.append(imageBase64)
        photoCollecction.reloadData()
        
    }
    
    func chooseImage(){
        self.imagePicker.present(from: self.view)
    }
    
}

extension jobViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: timeCellIdentifier, for: indexPath) as! JobTimeTableViewCell
        cell.DateJob.text = Datas[indexPath.row].Day ?? ""
        cell.Time1Job.text = Datas[indexPath.row].TimeFrom ?? ""
        cell.Time2Job.text = Datas[indexPath.row].TimeTo ?? ""
        
        cell.RemoveBtn.addTarget(self, action: #selector(connectedRemove(sender:)), for: .touchUpInside)
        cell.RemoveBtn.tag = indexPath.row
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    
}
