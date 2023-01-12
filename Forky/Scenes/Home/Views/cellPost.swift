//
//  cellPost.swift
//  Forky
//
//  Created by Vivek Sadariya on 04/10/21.
//

import UIKit

class cellPost: UITableViewCell {

    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var imgPost: UIImageView!
    @IBOutlet weak var imgPostBy: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUI()
    }
    
    private func setUI() {
        imgPostBy.roundedView()
        imgPost.layer.cornerRadius = 12.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
