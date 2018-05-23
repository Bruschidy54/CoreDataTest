//
//  UIViewController+Helpers.swift
//  CoreDataTest
//
//  Created by Dylan Bruschi on 5/21/18.
//  Copyright © 2018 Dylan Bruschi. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // Extensions and helper methods
    
    func setupPlusButtonInNavBar(selector: Selector) {
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Plus"), style: .plain, target: self, action: selector)
    }
    
    func setupCancelButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancelModal))
    }
    
    @objc func handleCancelModal() {
        dismiss(animated: true, completion: nil)
    }
    
    func setupLightBlueBackgroundView(height: CGFloat) -> UIView {
        let lightBlueBackgroundView = UIView()
        lightBlueBackgroundView.backgroundColor = UIColor.lightBlue
        lightBlueBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(lightBlueBackgroundView)
        lightBlueBackgroundView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: height)
        
        return lightBlueBackgroundView
    }
}
