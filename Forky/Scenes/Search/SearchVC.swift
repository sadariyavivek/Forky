//
//  SearchVC.swift
//  Forky
//
//  Created by Vivek Patel on 26/12/22.
//

import UIKit

class SearchVC: UIViewController {
    @IBOutlet weak var tableView: SearchTableView!
    var viewModel:SearchViewModel = SearchViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        setComponent()
        // Do any additional setup after loading the view.
    }
    
    private func setComponent() {
        //tableView.register(DefiYieldDetailHeader.nib, forHeaderFooterViewReuseIdentifier: DefiYieldDetailHeader.identifier)
        tableView.register(CellSearchTF.nib, forCellReuseIdentifier: CellSearchTF.identifier)
        tableView.register(CellNearbyResto.nib, forCellReuseIdentifier: CellNearbyResto.identifier)
        
        tableView.viewModel = viewModel
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
