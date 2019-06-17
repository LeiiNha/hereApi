//
//  LocationDetailViewController.swift
//  hereApi
//
//  Created by Erica Geraldes on 16/06/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import UIKit
import NMAKit
import CoreLocation

class LocationDetailViewController: UIViewController {

    let url: String
    let networkManager = NetworkManager()
    let location: Location
    private(set) var favoriteLocations: [Location]?
    public init(url: String, location: Location) {
        self.url = url
        self.location = location
        super.init(nibName: nil, bundle: nil)

        self.configureSubviews()
        self.favoriteLocations = FavoritesManager.loadFavorites()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Colors.primary
    }

    func configureSubviews() {
        guard let coords = self.location.position.first else { return }
        self.addMapView(latitude: coords.key, longitude: coords.value)
        self.addLabel(address: self.location.address, latitude: coords.key, longitude: coords.value)
        self.addLikeButton()
    }

    func addMapView(latitude: Double, longitude: Double) {
        let mapView = NMAMapView(frame: CGRect(x: 0, y: Spacing.XL, width: self.view.safeAreaLayoutGuide.layoutFrame.width, height: self.view.safeAreaLayoutGuide.layoutFrame.height / 2))
        let coordinates = NMAGeoCoordinates(latitude: latitude, longitude: longitude)

        let marker = NMAMapMarker(geoCoordinates: coordinates)
        marker.icon = Images.pin

        mapView.set(geoCenter: coordinates, animation: .none)
        mapView.add(marker)
        mapView.zoomLevel = 15.0
        self.view.addSubview(mapView)
    }

    func addLabel(address: Address, latitude: Double, longitude: Double) {
        let lbl = UILabel(frame: CGRect.zero)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.font.withSize(FontSize.S)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(lbl)
        lbl.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -200.0).isActive = true
        lbl.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        lbl.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true

        lbl.text = String(format: "Street: %@\nPostal Code: %@\nLatitude: %@, Longitude: %@\n", address.street.orDefault(""), address.postalCode.orDefault(""), latitude.description, longitude.description)
        if let location = CLLocationManager().location {
            lbl.text?.append(String(format: "Distance: %@ meters", self.calculateDistance(lat1: location.coordinate.latitude, long1: location.coordinate.longitude, lat2: latitude, long2: longitude)))
        }
    }

    func addLikeButton() {
        let likeBtn = UIButton(type: .custom)
        if FavoritesManager.checkIsFavorite(self.location) {
            likeBtn.setImage(Images.likeFilled, for: .normal)
        } else {
            likeBtn.setImage(Images.like, for: .normal)
        }
        likeBtn.addTarget(self, action: #selector(handleFavorite(_:)), for: .touchUpInside)
        self.view.addSubview(likeBtn)
        likeBtn.translatesAutoresizingMaskIntoConstraints = false
        likeBtn.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        likeBtn.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        likeBtn.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        likeBtn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    @objc func handleFavorite(_ sender: UIButton) {
        print("oi")
    }

    func calculateDistance(lat1: Double, long1: Double, lat2: Double, long2: Double) -> String {

        let coordinateA = CLLocation(latitude: lat1, longitude: long1)
        let coordinateB = CLLocation(latitude: lat2, longitude: long2)

        let distanceInMeters = coordinateA.distance(from: coordinateB)
        return distanceInMeters.description
    }


    


}
