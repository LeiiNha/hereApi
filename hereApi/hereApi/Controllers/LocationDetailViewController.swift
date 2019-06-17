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
    let networkManager: NetworkManager
    let location: Location
    let currentLocation: CLLocation?

    private(set) var favoriteLocations: [Location]?

    public init(url: String, location: Location, currentLocation: CLLocation?) {
        self.url = url
        self.networkManager = NetworkManager()
        self.currentLocation = currentLocation
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
}

private extension LocationDetailViewController {

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
        let detailsText: UILabel = UILabel(frame: CGRect.zero)
        detailsText.textAlignment = .left
        detailsText.numberOfLines = 0
        detailsText.font.withSize(FontSize.S)
        detailsText.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(detailsText)
        detailsText.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -200.0).isActive = true
        detailsText.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        detailsText.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true

        detailsText.text = String(format: "Street: %@\nPostal Code: %@\nLatitude: %@, Longitude: %@\n", address.street.orDefault(""), address.postalCode.orDefault(""), latitude.description, longitude.description)
        if let currentLocation = currentLocation {
            detailsText.text?.append(String(format: "Distance: %@ meters", self.calculateDistance(lat1: currentLocation.coordinate.latitude, long1: currentLocation.coordinate.longitude, lat2: latitude, long2: longitude)))
        }
    }

    func addLikeButton() {
        let likeBtn = UIButton(type: .custom)
        likeBtn.setImage(self.getButtonImage(), for: .normal)
        likeBtn.addTarget(self, action: #selector(handleFavorite(_:)), for: .touchUpInside)
        self.view.addSubview(likeBtn)
        likeBtn.translatesAutoresizingMaskIntoConstraints = false
        likeBtn.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        likeBtn.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        likeBtn.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        likeBtn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -Spacing.XL).isActive = true
    }

    func getButtonImage() -> UIImage? {
        if FavoritesManager.checkIsFavorite(self.location) {
            return Images.likeFilled
        }
        return Images.like
    }

    @objc func handleFavorite(_ sender: UIButton) {
        if sender.currentImage == Images.like {
            FavoritesManager.saveFavorite(location: self.location)
        } else {
            FavoritesManager.removeFavorite(self.location)
        }
        sender.setImage(self.getButtonImage(), for: .normal)
    }

    func calculateDistance(lat1: Double, long1: Double, lat2: Double, long2: Double) -> String {

        let coordinateA = CLLocation(latitude: lat1, longitude: long1)
        let coordinateB = CLLocation(latitude: lat2, longitude: long2)

        let distanceInMeters = coordinateA.distance(from: coordinateB)
        return distanceInMeters.description
    }
}
