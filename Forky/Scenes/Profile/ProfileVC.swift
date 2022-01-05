//
//  ProfileVC.swift
//  Forky
//
//  Created by Vivek Sadariya on 05/01/22.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var tableView: ProfileTableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        setComponent()
        // Do any additional setup after loading the view.
    }
    
    private func setComponent() {
        //tableView.register(DefiYieldDetailHeader.nib, forHeaderFooterViewReuseIdentifier: DefiYieldDetailHeader.identifier)
        tableView.register(CellProfile.nib, forCellReuseIdentifier: CellProfile.identifier)
        tableView.register(CellProfilePic.nib, forCellReuseIdentifier: CellProfilePic.identifier)
        tableView.reloadData()
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
