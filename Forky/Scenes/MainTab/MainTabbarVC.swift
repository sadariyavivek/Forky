//
//  MainTabbarVC.swift
//  Forky
//
//  Created by Vivek Sadariya on 10/09/21.
//

import UIKit

class MainTabbarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupComponent()
    }
    

    private func setupComponent() {
        self.delegate = self
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

extension MainTabbarVC: UITabBarControllerDelegate {
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        if let items = tabBar.items {
//            for (index, item) in items.enumerated() {
//                if index == selectedIndex {
//                    item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .normal)
//                    item.image = UIImage(named: "home")
//                    item.selectedImage = UIImage(named: "home")
//                } else {
//                    item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.blue], for: .normal)
//                    item.image = UIImage(named: "home")
//                }
//            }
//        }
//    }
}

