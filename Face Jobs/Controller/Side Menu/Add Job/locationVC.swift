//
//  locationVC.swift
//  Face Jobs
//
//  Created by Eslam Hassan on 8/10/20.
//  Copyright © 2020 Eslam Hassan. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps
protocol LocationDelegate: class {
    func RetriveLocation(lat: Double, lng: Double, add: String)
}
class locationVC: UIViewController {

    @IBOutlet weak var myMapView: UIView!
    @IBOutlet weak var addressLabel: UILabel!

    //MARK: Variables
    let locationManager = CLLocationManager()
    var lat: Double?
    var lng: Double?
    var address = ""
    
    var mapView: GMSMapView!
    var centerMapCoordinate:CLLocationCoordinate2D!
    var marker: GMSMarker!

    weak var delegate: LocationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationAuth()

    }
    @IBAction func doneBtnPressed(_ sender: UIButton) {
        self.delegate?.RetriveLocation(lat: self.lat ?? 0.0, lng: self.lng ?? 0.0, add: self.address)
        print("lat: ",self.lat ?? 0.0, "lng: ", self.lng ?? 0.0, "add:", self.address)
        dismiss(animated: true, completion: nil)
    }

}
//MARK:- Maps Helper Funcs
extension locationVC: CLLocationManagerDelegate, GMSMapViewDelegate {
    
    private func locationAuth(){
        mapView = GMSMapView()
        marker = GMSMarker()
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        self.lat = locValue.latitude
        self.lng = locValue.longitude
        
        print(address)

        self.MapSetup(lat:"\((locValue.latitude))", long: "\((locValue.longitude))")
        
        locationManager.stopUpdatingLocation()
        
    }
    
    
    private func MapSetup(lat: String , long: String) {
        let camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(lat)!, longitude: CLLocationDegrees(long)!, zoom: 150.0)
        let mapFrame = CGRect(x: myMapView.frame.origin.x, y: 0, width: myMapView.frame.size.width, height: myMapView.frame.size.height)
        mapView = GMSMapView.map(withFrame: mapFrame, camera: camera)
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        mapView.isMyLocationEnabled = true
        mapView.mapType = .normal
        mapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
        self.myMapView.addSubview(mapView)
        mapView.delegate = self
    }
    
    
    private func MapMarkerSetup() {
        let marker1 = GMSMarker()
        marker1.position = CLLocationCoordinate2D(latitude: self.lat!, longitude: self.lng!)
        marker1.icon = GMSMarker.markerImage(with: UIColor.green)
        marker1.title = self.address
        marker1.map = mapView
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        
        let latitude = mapView.camera.target.latitude
        let longitude = mapView.camera.target.longitude
        
        centerMapCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.placeMarkerOnCenter(centerMapCoordinate:centerMapCoordinate)
    }
    
    private func placeMarkerOnCenter(centerMapCoordinate:CLLocationCoordinate2D) {
        marker.position = centerMapCoordinate
        marker.map = self.mapView
        marker.title = self.address
        marker.icon = GMSMarker.markerImage(with: UIColor.green)
    }
    
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        returnPostionOfMapView(mapView: mapView)
    }
    
    private func returnPostionOfMapView(mapView:GMSMapView) {
        let geocoder = GMSGeocoder()
        let latitute = mapView.camera.target.latitude
        let longitude = mapView.camera.target.longitude
        
        self.lat = Double(latitute)
        self.lng = Double(longitude)
        
        let position = CLLocationCoordinate2DMake(latitute, longitude)
        geocoder.reverseGeocodeCoordinate(position) { response , error in
            if error != nil {
                print("Error: \(String(describing: error?.localizedDescription))")
            } else {
                let result = response?.results()?.first
                let location = result?.lines?.reduce("") { $0 == "" ? $1 : $0 + ", " + $1 }
                self.address = location ?? ""
                self.marker.title = self.address
                self.addressLabel.text = self.address
                self.delegate?.RetriveLocation(lat: self.lat ?? 0.0, lng: self.lng ?? 0.0, add: self.address)
            }
        }
    }
}

