//
//  HomeController.swift
//  Zoo App
//
//  Created by Javid Sultanov on 14.08.26.
//

import UIKit

class HomeController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .secondarySystemBackground
        navigationItem.title = "Home"
    }
}
