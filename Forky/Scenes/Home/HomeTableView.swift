//
//  HomeTableView.swift
//  Forky
//
//  Created by Vivek Sadariya on 03/10/21.
//

import UIKit

class HomeTableView: UITableView {
    //var viewModel:DefiYeidDetailViewModel?
    var hSectionHeader:CGFloat = 0.0
    var hSectionFooter:CGFloat = 0.0
    var isScrolltoTop = true
    var callBackSrollTop:((Bool)->Void)?
    var callBackSlc:(()->Void)?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTablview()
    }
    
    private func setupTablview() {
        self.delegate = self
        self.dataSource = self
        self.separatorStyle = .none
        self.showsVerticalScrollIndicator = false
//        self.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.self.bounds.size.width, height: hSectionHeader))
//        self.contentInset = UIEdgeInsets(top: -hSectionHeader, left: 0, bottom: 0, right: 0)
//        self.contentInsetAdjustmentBehavior = .never
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 10 {
            callBackSrollTop?(true)
            isScrolltoTop = true
        } else {
            if isScrolltoTop == true {
                callBackSrollTop?(false)
            }
            isScrolltoTop = false
        }
    }

}

extension HomeTableView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return hSectionFooter
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return hSectionHeader
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellListTypeHome.identifier) as? cellListTypeHome else { return UITableViewCell() }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellPost.identifier) as? cellPost else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        callBackSlc?()
    }
 
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
         header.contentView.backgroundColor = .white
        }
    }
}
