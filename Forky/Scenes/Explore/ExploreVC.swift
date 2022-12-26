//
//  ExploreVC.swift
//  Forky
//
//  Created by Vivek Sadariya on 09/10/21.
//

import UIKit

class ExploreVC: UIViewController {

    @IBOutlet weak var tableView: ExploreTableView!
    var viewModel:ExploreViewModel = ExploreViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setComponent()
    }
    
    private func setComponent() {
        //tableView.register(DefiYieldDetailHeader.nib, forHeaderFooterViewReuseIdentifier: DefiYieldDetailHeader.identifier)
        tableView.register(cellExploreCarousel.nib, forCellReuseIdentifier: cellExploreCarousel.identifier)
        tableView.register(cellSearchExplore.nib, forCellReuseIdentifier: cellSearchExplore.identifier)
        tableView.register(CellExploreExperience.nib, forCellReuseIdentifier: CellExploreExperience.identifier)
        tableView.register(cellNearByRestoFlt.nib, forCellReuseIdentifier: cellNearByRestoFlt.identifier)
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
