//
//  SavedVC.swift
//  Forky
//
//  Created by Vivek Sadariya on 05/01/22.
//

import UIKit

class SavedVC: UIViewController {
    
    @IBOutlet weak var tableView: SavedTableView!
    var viewModel:SavedViewModel = SavedViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setComponent()
        // Do any additional setup after loading the view.
    }
    
    private func setComponent() {
        tableView.register(CellSavedSearch.nib, forCellReuseIdentifier: CellSavedSearch.identifier)
        tableView.register(CellSavedPostContainer.nib, forCellReuseIdentifier: CellSavedPostContainer.identifier)
        tableView.viewModel = viewModel
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
