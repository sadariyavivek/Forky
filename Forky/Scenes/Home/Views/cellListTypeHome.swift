//
//  cellListTypeHome.swift
//  Forky
//
//  Created by Vivek Sadariya on 03/10/21.
//

import UIKit

class cellListTypeHome: UITableViewCell {

    @IBOutlet weak var viewSlc: UIView!
    @IBOutlet weak var viewBG: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUI()
    }

    private func setUI() {
        viewBG.layer.cornerRadius = 8.0
        viewBG.layer.borderWidth = 1.0
        viewBG.layer.borderColor = UIColor.borderGray?.cgColor
        
        viewSlc.addShadowWithOffset(opacity: 0.2)
        viewSlc.layer.cornerRadius = 5.0
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func actAll(_ sender: Any) {
        
    }
    
    @IBAction func actEvents(_ sender: Any) {
        
    }
    
    @IBAction func actOffers(_ sender: Any) {
        
    }
    
    @IBAction func actOthers(_ sender: Any) {
        
    }
}
