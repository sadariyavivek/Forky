//
//  CellSearchTF.swift
//  Forky
//
//  Created by Vivek Patel on 26/12/22.
//

import UIKit

class CellSearchTF: UITableViewCell {

    @IBOutlet weak var viewContainer: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUI()
    }

    private func setUI() {
        self.selectionStyle = .none
        viewContainer.layer.cornerRadius = 4.0
        viewContainer.layer.borderWidth = 1.0
        viewContainer.layer.borderColor = UIColor.borderGray?.cgColor
        viewContainer.addShadowWithOffset(opacity: 0.1, shadowRadius: 1.0, x: 0, y: 1)
        
    }
    
}
