//
//  HomeVC.swift
//  Forky
//
//  Created by Vivek Sadariya on 03/10/21.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var tableView: HomeTableView!
    @IBOutlet weak var btnFollowing: UIButton!
    @IBOutlet weak var btnRecent: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        for family: String in UIFont.familyNames
              {
                  print(family)
                  for names: String in UIFont.fontNames(forFamilyName: family)
                  {
                      print("== \(names)")
                  }
              }
    
//        btnRecent.titleLabel?.font = UIFont(name: "Inter-SemiBold", size: 14)
//        btnFollowing.titleLabel?.font = UIFont(name: "Inter-SemiBold", size: 14)
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
