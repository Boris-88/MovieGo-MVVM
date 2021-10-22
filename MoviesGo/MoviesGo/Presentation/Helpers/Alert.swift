// Alert.swift
// Copyright © Boris Zverik. All rights reserved.

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String?, message: String?, actionTitle: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: actionTitle, style: .default)
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }

    func alertShowComplition(
        title: String?,
        message: String?,
        isAction: Bool,
        buttonAction: String,
        selectButtonAction: String,
        comlitionHandler: @escaping () -> ()
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: selectButtonAction, style: .default, handler: { _ in comlitionHandler()
        }))
        if isAction {
            alert.addAction(UIAlertAction(title: buttonAction, style: .destructive, handler: { _ in comlitionHandler()
            }))
        }
        present(alert, animated: true)
    }
}
