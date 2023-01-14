//
//  SearchTableView.swift
//  Forky
//
//  Created by Vivek Patel on 26/12/22.
//

import UIKit

class SearchTableView: UITableView {
    //var viewModel:DefiYeidDetailViewModel?
    var hSectionHeader:CGFloat = 0.0
    var hSectionFooter:CGFloat = 0.0
    var isScrolltoTop = true
    var callBackSrollTop:((Bool)->Void)?
    var callBackSlc:(()->Void)?
    var viewModel: SearchViewModel?
    var viewController : UIViewController?
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

extension SearchTableView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return hSectionFooter
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return hSectionHeader
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.dataPost?.data?.vendor_posts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellPost.identifier) as? cellPost else { return UITableViewCell() }
            cell.selectionStyle = .none
            if let data = viewModel?.dataPost?.data?.vendor_posts?[indexPath.row] {
                cell.lblSubtitle.text = data.caption?.htmlToString
                cell.imgPost.loadImageUsingCache(withUrl: data.photo ?? "")
                cell.lblPostDate.text = "Available from \(data.from_date?.convertDateFormat() ?? "") to \(data.to_date?.convertDateFormat() ?? "")"

                cell.reloadExpandableLabel = {
                    DispatchQueue.main.async {
                        self.reloadData()
                    }
                }
                
                if let vendorData = data.vendor {
                    cell.lblVendorName.text = vendorData.business_name
                    cell.lblVendorAddress.text = vendorData.address_line_1
                    cell.imgPostBy.loadImageUsingCache(withUrl: vendorData.logo ?? "")
                    cell.btnLocationCompletion = {
                        if let lat = vendorData.latitude, let long = vendorData.longitude,let url = URL(string: "http://maps.apple.com/?daddr=\(lat),\(long)") {
                            if UIApplication.shared.canOpenURL(url) {
                                  UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            }
                        }
                    }
                    
                    cell.btnCallCompletion = {
                        if let strMobNumber = vendorData.primary_contact {
                            self.viewController?.openActionSheet(title: nil, message: "Mobile Number", actionTitles: [strMobNumber], completion: { (index,title) in
                                if let title = title {
                                    if let url = URL(string: "tel://\(title)") {
                                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                     }
                                }
                            })
                        }
                    }
                }
        }
        return cell
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
