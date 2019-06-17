//
//  ThemeGuide.swift
//  hereApi
//
//  Created by Erica Geraldes on 15/06/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import Foundation
import UIKit

struct Spacing {
    static let XS: CGFloat = 3.0
    static let S: CGFloat = 5.0
    static let M: CGFloat = 10.0
    static let L: CGFloat = 25.0
    static let XL: CGFloat = 50.0
}

struct Colors {
    static let primary: UIColor = UIColor(red: 117.0/255.0, green: 246.0/255.0, blue: 212.0/255.0, alpha: 1)
    static let secondary: UIColor = UIColor(red: 49.0/255.0, green: 0.0/255.0, blue: 255.0/255.0, alpha: 1)
    static let terciary: UIColor = UIColor(red: 239.0/255.0, green: 177.0/255.0, blue: 146.0/255.0, alpha: 1)
}

struct FontSize {
    static let S: CGFloat = 16.0
}

struct Images {
    static let pin = UIImage(named: "pin")
    static let like = UIImage(named: "like")
    static let likeFilled = UIImage(named: "like_filled")
}
