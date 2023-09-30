//
//  ButtonExtension.swift
//  QuizeAppTests
//
//  Created by Hirenkumar Fadadu on 30/09/23.
//

import UIKit

extension UIBarButtonItem {
    
    func simulateTap() {
        self.target!.performSelector(onMainThread: self.action!,
                                     with: nil,
                                     waitUntilDone: true)
    }
}
