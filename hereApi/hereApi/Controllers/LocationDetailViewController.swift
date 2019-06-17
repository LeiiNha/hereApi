//
//  LocationDetailViewController.swift
//  hereApi
//
//  Created by Erica Geraldes on 16/06/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import UIKit

class LocationDetailViewController: UIViewController {

    let url: String
    let networkManager = NetworkManager()
    public init(url: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white

        let teste = UILabel(frame: CGRect(x: 50.0, y: 200.0, width: 200.0, height: 40.0))
        teste.textColor = .black
        teste.font = UIFont.systemFont(ofSize: 16)
        teste.textAlignment = .right
        teste.numberOfLines = 0
        teste.text = url
        self.view.addSubview(teste)
        getLocationDetails()
    }
    
    func getLocationDetails() {
        networkManager.getDetails(url: url, completion: { location, error in
            print(location)
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
