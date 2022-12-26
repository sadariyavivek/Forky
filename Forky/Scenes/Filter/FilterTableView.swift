//
//  FilterTableView.swift
//  Forky
//
//  Created by Vivek Patel on 08/09/22.
//

import UIKit

class FilterTableView: UITableView {
    //var viewModel:DefiYeidDetailViewModel?
    var hSectionHeader:CGFloat = 0.0
    var hSectionFooter:CGFloat = 0.0
    var isScrolltoTop = true
    var callBackSrollTop:((Bool)->Void)?
    var viewModel:FilterViewModel = FilterViewModel()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTablview()
    }
    
    private func setupTablview() {
        self.delegate = self
        self.dataSource = self
        self.separatorStyle = .none
        self.showsVerticalScrollIndicator = false
        
        self.register(CellFilterCat.nib, forCellReuseIdentifier: CellFilterCat.identifier)
        self.register(cellSearchExplore.nib, forCellReuseIdentifier: cellSearchExplore.identifier)
        self.register(CellExploreExperience.nib, forCellReuseIdentifier: CellExploreExperience.identifier)
        self.register(cellNearByRestoFlt.nib, forCellReuseIdentifier: cellNearByRestoFlt.identifier)
        self.register(CellNearbyResto.nib, forCellReuseIdentifier: CellNearbyResto.identifier)
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

extension FilterTableView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return hSectionFooter
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.data.section.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return hSectionHeader
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.data.section[section] {
        case .carousel:
            return 10
        case .search:
            return 0
        case .experience:
            return 0
        case .nearbyFlt:
            return 0
        case .nearby:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.data.section[indexPath.section] {
        case .carousel:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellFilterCat.identifier) as? CellFilterCat else { return UITableViewCell() }
            return cell
        case .search:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellSearchExplore.identifier) as? cellSearchExplore else { return UITableViewCell() }

            return cell
        case .experience:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellExploreExperience.identifier) as? CellExploreExperience else { return UITableViewCell() }
            return cell
        case .nearbyFlt:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellNearByRestoFlt.identifier) as? cellNearByRestoFlt else { return UITableViewCell() }
            return cell
        case .nearby:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellNearbyResto.identifier) as? CellNearbyResto else { return UITableViewCell() }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
    }
 
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
         header.contentView.backgroundColor = .white
        }
    }
}
