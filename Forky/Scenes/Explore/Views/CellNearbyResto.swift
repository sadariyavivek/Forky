//
//  CellNearbyResto.swift
//  Forky
//
//  Created by Vivek Sadariya on 30/10/21.
//

import UIKit

class CellNearbyResto: UITableViewCell {

    @IBOutlet weak var lblOpenStatus: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUI()
    }

    private func setUI() {
        img.layer.cornerRadius = 8.0
        img.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
