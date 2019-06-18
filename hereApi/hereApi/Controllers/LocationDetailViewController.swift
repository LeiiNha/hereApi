//
//  LocationDetailViewController.swift
//  hereApi
//
//  Created by Erica Geraldes on 16/06/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import UIKit
import NMAKit

final class LocationDetailViewController: UIViewController {

    private(set) var mapView: NMAMapView?
    let viewModel: LocationDetailViewModel

    private(set) var favoriteLocations: [Location]?

    public init(viewModel: LocationDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

        self.configureSubviews()
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

        self.addMapView()
        self.addLabel()
        self.addLikeButton()
    }

    func addMapView() {
        self.mapView = NMAMapView(frame: CGRect(x: 0,
                                                y: Spacing.xLarge,
                                                width: self.view.safeAreaLayoutGuide.layoutFrame.width,
                                                height: self.view.safeAreaLayoutGuide.layoutFrame.height / 2))
        guard let mapView = self.mapView else { return }

        mapView.zoomLevel = 15.0
        self.view.addSubview(mapView)
        guard let coords = self.viewModel.getGeoCoordinatesForLocation(),
            let marker = self.viewModel.getMarkerForLocation() else { return }
        mapView.add(marker)
        mapView.set(geoCenter: coords, animation: .none)

    }

    func addLabel() {
        let detailsText: UILabel = UILabel(frame: CGRect.zero)
        detailsText.textAlignment = .left
        detailsText.numberOfLines = 0
        detailsText.font.withSize(FontSize.small)
        detailsText.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(detailsText)
        if let mapView = self.mapView {
            detailsText.topAnchor.constraint(equalTo: mapView.bottomAnchor).isActive = true
            detailsText.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            detailsText.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        }
        detailsText.text = self.viewModel.getAddress()

        if let distance = self.viewModel.calculateDistanceToLocation() {
        detailsText.text?.append(String(format: "Distance: %@ meters", distance))
        }

    }

    func addLikeButton() {
        let likeBtn = UIButton(type: .custom)
        likeBtn.setImage(self.viewModel.getImageForLocation(), for: .normal)
        likeBtn.addTarget(self, action: #selector(handleBtnPress(_:)), for: .touchUpInside)
        self.view.addSubview(likeBtn)
        likeBtn.translatesAutoresizingMaskIntoConstraints = false
        likeBtn.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        likeBtn.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        likeBtn.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        likeBtn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,
                                        constant: -Spacing.xLarge).isActive = true
    }

    @objc func handleBtnPress(_ sender: UIButton) {
        self.viewModel.handleBtnPress(sender)
        sender.setImage(self.viewModel.getImageForLocation(), for: .normal)
    }
}
