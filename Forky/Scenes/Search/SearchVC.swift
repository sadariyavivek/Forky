//
//  SearchVC.swift
//  Forky
//
//  Created by Vivek Patel on 26/12/22.
//

import UIKit
import SwiftUI

class SearchVC: UIViewController {
    
    @IBOutlet weak var tableView: SearchTableView!
    @IBOutlet weak var vwSearch: UIView!
    @IBOutlet weak var txtSearch: UITextField!
    private let viewModel = SearchViewModel(SearchService())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        setComponent()
    }
    

    private func setComponent() {
        //tableView.register(DefiYieldDetailHeader.nib, forHeaderFooterViewReuseIdentifier: DefiYieldDetailHeader.identifier)
        vwSearch.layer.cornerRadius = 4.0
        vwSearch.layer.borderWidth = 1.0
        vwSearch.layer.borderColor = UIColor.borderGray?.cgColor
        vwSearch.addShadowWithOffset(opacity: 0.1, shadowRadius: 1.0, x: 0, y: 1)
        txtSearch.enablesReturnKeyAutomatically = true
        txtSearch.delegate = self
        txtSearch.inputAccessoryView = UIView()
        tableView.register(cellPost.nib, forCellReuseIdentifier: cellPost.identifier)
        tableView.viewController = self
    }

    private func getSeachPostList(query:String?) {
        viewModel.getSearchPostList(query: query, success: {
            self.tableView.viewModel = self.viewModel
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }, failure: { error in
            
        })
    }

}

extension SearchVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        getSeachPostList(query:textField.text)
        self.tableView.setContentOffset(.zero, animated: false)
        return true
    }
}
