//
//  FilterVC.swift
//  Forky
//
//  Created by Vivek Patel on 08/09/22.
//

import UIKit

class FilterVC: UIViewController {
    
    @IBOutlet weak var collview: FilterCollectionView?
    @IBOutlet weak var tableView: FilterTableView?
    @IBOutlet weak var viewSearch: UIView?
    var viewModel:FilterViewModel = FilterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setComponent()
    }
    
    private func setComponent() {
        tableView?.viewModel = viewModel
        tableView?.reloadData()
        
        viewSearch?.layer.cornerRadius = 4.0
        viewSearch?.layer.borderWidth = 1.0
        viewSearch?.layer.borderColor = UIColor.borderGray?.cgColor
        viewSearch?.addShadowWithOffset(opacity: 0.1, shadowRadius: 1.0, x: 0, y: 1)
    }
    
    @IBAction func actClose(_ sender: Any) {
        self.dismiss(animated: true)
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
