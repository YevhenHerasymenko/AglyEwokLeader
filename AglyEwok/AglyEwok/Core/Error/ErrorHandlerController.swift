//
//  ErrorHandlerController.swift
//  ReSwiftSample_Stratege
//
//  Created by YevhenHerasymenko on 6/2/17.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import UIKit

protocol ErrorHandlerController {
    func show(error: String?)
}

extension ErrorHandlerController where Self: UIViewController {
    func show(error: String?) {
        guard let error = error else { return }
        let alertController = UIAlertController(title: error, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
