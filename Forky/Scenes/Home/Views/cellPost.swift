//
//  cellPost.swift
//  Forky
//
//  Created by Vivek Sadariya on 04/10/21.
//

import UIKit

class cellPost: UITableViewCell {

    @IBOutlet weak var lblSubtitle: ExpandableLabel!
    @IBOutlet weak var lblVendorName: UILabel!
    @IBOutlet weak var lblVendorAddress: UILabel!
    @IBOutlet weak var lblPostDate: UILabel!
    @IBOutlet weak var imgPost: UIImageView!
    @IBOutlet weak var imgPostBy: UIImageView!
    
    
    var btnCallCompletion : (()->Void)?
    var btnLocationCompletion : (()->Void)?
    var reloadExpandableLabel: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUI()
    }
    
    private func setUI() {
        imgPostBy.roundedView()
        imgPost.layer.cornerRadius = 12.0
        lblSubtitle.numberOfLines = 2
        lblSubtitle.delegate = self
        lblSubtitle.shouldExpand = true
        lblSubtitle.shouldCollapse = true
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 1), .font: UIFont.boldSystemFont(ofSize: lblSubtitle.font.pointSize)]
        lblSubtitle.collapsedAttributedLink = NSAttributedString(string: "Read More", attributes: attributes)
        lblSubtitle.expandedAttributedLink = NSAttributedString(string: "...Read Less", attributes: attributes)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnCallTapped(_ sender: Any) {
        if let completion = btnCallCompletion {
            completion()
        }
    }
    @IBAction func btnLocationTapped(_ sender: Any) {
        if let completion = btnLocationCompletion {
            completion()
        }
    }
    
}

extension cellPost: ExpandableLabelDelegate {
    
    func willExpandLabel(_ label: ExpandableLabel) {}
    
    func didExpandLabel(_ label: ExpandableLabel) {
        if let reload = reloadExpandableLabel {
            reload()
        }
    }
    
    func willCollapseLabel(_ label: ExpandableLabel) {}
    
    func didCollapseLabel(_ label: ExpandableLabel) {
        if let reload = reloadExpandableLabel {
            reload()
        }
    }
}
