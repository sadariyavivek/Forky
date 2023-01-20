//
//  HomeVC.swift
//  Forky
//
//  Created by Vivek Sadariya on 03/10/21.
//

import UIKit
import SwiftUI

class HomeVC: UIViewController {

    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var cnstViewHeader: NSLayoutConstraint!
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var tableView: HomeTableView!
    @IBOutlet weak var btnFollowing: UIButton!
    @IBOutlet weak var btnRecent: UIButton!
  
    @IBOutlet weak var cnstTabIndicatorLeading: NSLayoutConstraint!
    private let viewModel = HomeViewModel(HomeService())
    
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
        tableView.callBackSrollTop = { [weak self] isTop in
            if isTop {
                self?.cnstViewHeader.constant = 70
            } else {
                self?.cnstViewHeader.constant = 0
            }
            UIView.animate(withDuration: 0.25) {
                self?.view.layoutIfNeeded()
                if isTop {
                    self?.viewHeader.alpha = 1.0
                } else {
                    self?.viewHeader.alpha = 0.0
                }
            }
        }
        tableView.callBackSlc = { [weak self] objPostModel in
            let objPostVC = self?.storyboard?.instantiateViewController(withIdentifier: "PostDetailsVC") as! PostDetailsVC
            objPostVC.objPostModel = objPostModel
            self?.navigationController?.pushViewController(objPostVC, animated: true)
        }
        tableView.viewController = self
        btnFilter.layer.cornerRadius = 4.0
        btnFilter.layer.borderColor = UIColor.black?.cgColor
        btnFilter.layer.borderWidth = 1.0
        getPostList(type: nil)
    }

    private func getPostList(type:String?) {
        viewModel.getPostList(type: type, success: {
            self.tableView.viewModel = self.viewModel
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }, failure: { error in
            
        })
    }
    
    @IBAction func actAll(_ sender: UIButton) {
        cnstTabIndicatorLeading.constant = sender.frame.origin.x + 24
        getPostList(type: nil)
    }
    
    @IBAction func actOffer(_ sender: UIButton) {
        cnstTabIndicatorLeading.constant = sender.frame.origin.x + 24
        getPostList(type: "offer")
    }
    
    @IBAction func actEvent(_ sender: UIButton) {
        cnstTabIndicatorLeading.constant = sender.frame.origin.x + 24
        getPostList(type: "event")
    }
    @IBAction func actFilter(_ sender: Any) {
        let vc = FilterVC.instantiateFromStoryboard("Filter")
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
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

