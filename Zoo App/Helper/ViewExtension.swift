//
//  ViewExtension.swift
//  Zoo App
//
//  Created by Javid Sultanov on 19.08.26.
//

import UIKit

extension UIViewController {
    func showDefaultAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default))
        self.present(alert, animated: true)
    }
}
