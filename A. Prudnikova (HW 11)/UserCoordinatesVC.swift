//
//  UserCoordinatesVC.swift
//  A. Prudnikova (HW 11)
//
//  Created by Ann Prudnikova on 11.11.22.
//

import UIKit
import GoogleMaps

class UserCoordinatesVC: UIViewController, GMSMapViewDelegate {

    @IBOutlet weak var stackWithCoordinates: UIStackView!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var acceptCoordinatesButt: UIButton!
    var setCoordinates: ((Double,Double) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: 54.029, longitude: 27.597, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        mapView.settings.scrollGestures = true
        mapView.settings.zoomGestures = true
        view.insertSubview(mapView, at: 0)
        mapView.delegate = self
        acceptCoordinatesButt.setGradient(button: acceptCoordinatesButt)
        acceptCoordinatesButt.setTitle("Accept coordinates", for: .normal)
        
        
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        
        stackWithCoordinates.backgroundColor = .lightGray
        stackWithCoordinates.isOpaque = false
        stackWithCoordinates.alpha = 0.8
        stackWithCoordinates.layer.cornerRadius = 30
        
        latitudeLabel.layer.zPosition = 2
        latitudeLabel.textColor = .purple
        latitudeLabel.text = "\(coordinate.latitude)"
        
        longitudeLabel.layer.zPosition = 2
        longitudeLabel.textColor = .purple
        longitudeLabel.text = "\(coordinate.longitude)"
        
    }
    @IBAction func setCoordinates(_ sender: Any) {
        
       if let lat = latitudeLabel.text,
          let long = longitudeLabel.text,
          let latitude = Double(lat),
          let longitude = Double(long) {
           if latitude != 0.0 && longitude != 0.0 {
            setCoordinates?(latitude, longitude)
           }
       }
        
        dismiss(animated: true)
    }
}


