//
//  LocationTableViewCell.swift
//  hereApi
//
//  Created by Erica Geraldes on 15/06/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    var name: String? {
        didSet {
            nameLabel.text = name
        }
    }
    
    private let nameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: FontSize.S)
        lbl.textAlignment = .left
        return lbl
    }()

    static var reuseIdentifier: String = "LocationTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = Colors.terciary.withAlphaComponent(0.3)
        addSubview(nameLabel)
        configurePinImage()
        setAnchors()
    }

    private func configurePinImage() {
        let pinImageView = UIImageView(image: Images.pin)
        self.addSubview(pinImageView)
        pinImageView.translatesAutoresizingMaskIntoConstraints = false
        pinImageView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor).isActive = true
        pinImageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Spacing.M).isActive = true
    }
    
    private func setAnchors() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Spacing.M).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

