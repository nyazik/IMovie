//
//  ViewController.swift
//  IMoview
//
//  Created by User on 9/8/20.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   let tabBar = UITabBar()
    override func viewDidLoad() {
      super.viewDidLoad()
      addTabbar()
    }
    override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()
      addHeightConstraintToTabbar()
    }
    func addTabbar() -> Void {
      self.view.addSubview(tabBar)
      tabBar.translatesAutoresizingMaskIntoConstraints = false
      tabBar.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
      tabBar.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
      tabBar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
      let item1 = UITabBarItem(tabBarSystemItem: UITabBarItem.SystemItem.topRated, tag: 1)
      let item2 = UITabBarItem(tabBarSystemItem: UITabBarItem.SystemItem.search, tag: 2)
      tabBar.items = [item1, item2]
      self.view.bringSubviewToFront(tabBar)
    }
    func addHeightConstraintToTabbar() -> Void {
      let heightConstant:CGFloat = self.view.safeAreaInsets.bottom + 49.0
      tabBar.heightAnchor.constraint(equalToConstant: heightConstant).isActive = true
    }

}

