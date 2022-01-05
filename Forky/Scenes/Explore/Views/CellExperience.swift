//
//  CellExperience.swift
//  Forky
//
//  Created by Vivek Sadariya on 30/10/21.
//

import UIKit

class CellExperience: UICollectionViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblDescr: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUI()
    }

    private func setUI() {
        img.layer.cornerRadius = 8.0
        img.clipsToBounds = true
    }
}
