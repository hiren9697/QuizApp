//
//  NoAnimationNavigationController.swift
//  QuizeAppTests
//
//  Created by Hirenkumar Fadadu on 19/09/23.
//

import UIKit

class NoAnimationNavigationController: UINavigationController {
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: false)
    }
}
