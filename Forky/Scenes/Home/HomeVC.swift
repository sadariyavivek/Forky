//
//  HomeVC.swift
//  Forky
//
//  Created by Vivek Sadariya on 03/10/21.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var btnFilter: UIButton!
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
        setComponent()
    }
    

    private func setComponent() {
        //tableView.register(DefiYieldDetailHeader.nib, forHeaderFooterViewReuseIdentifier: DefiYieldDetailHeader.identifier)
        tableView.register(cellListTypeHome.nib, forCellReuseIdentifier: cellListTypeHome.identifier)
        tableView.register(cellPost.nib, forCellReuseIdentifier: cellPost.identifier)
        
        btnFilter.layer.cornerRadius = 4.0
        btnFilter.layer.borderColor = UIColor.black?.cgColor
        btnFilter.layer.borderWidth = 1.0
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
