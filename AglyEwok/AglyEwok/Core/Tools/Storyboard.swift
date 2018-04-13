//
//  Storyboard.swift
//  Profile
//
//  Created by YevhenHerasymenko on 1/23/17.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import UIKit

enum AppStoryboard: String {
  case authorization = "Authorization"
  case pieChart = "PieChart"
  case suitcase = "Suitcase"
  case portfolioProducts = "PortfolioProducts"
  case productDetails = "ProductDetails"
  case profile = "Profile"
  
  var instance: UIStoryboard {
    return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
  }
  
  var initialViewController: UIViewController? {
    return instance.instantiateInitialViewController()
  }
  
  func viewController<T: UIViewController>(_ viewControllerClass: T.Type) -> T? {
    let storyboardId = (viewControllerClass as UIViewController.Type).storyboardId
    return instance.instantiateViewController(withIdentifier: storyboardId) as? T
  }
}

extension UIViewController {
  
  @nonobjc class var storyboardId: String {
    return "\(self)"
  }
  
  static func instantiate(from storyboard: AppStoryboard) -> Self? {
    return storyboard.viewController(self)
  }
  
}
