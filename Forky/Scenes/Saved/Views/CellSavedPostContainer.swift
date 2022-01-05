//
//  CellSavedPostContainer.swift
//  Forky
//
//  Created by Vivek Sadariya on 05/01/22.
//

import UIKit

class CellSavedPostContainer: UITableViewCell {

    @IBOutlet weak var collview: UICollectionView!
    let cellSpacing:CGFloat = 24
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setCollectionView()
    }

    func setCollectionView() {
        collview.delegate = self
        collview.dataSource = self
        
        collview.register(CellSavedPost.nib, forCellWithReuseIdentifier: CellSavedPost.identifier)
        setCollectionViewLayout()
    }
    
    func setCollectionViewLayout() {
        if let flowLayout = collview.collectionViewLayout as? UICollectionViewFlowLayout {
            //flowLayout.itemSize = CGSize(width: (self.view.frame.size.width-61)/3, height: ((self.view.frame.size.width-61)/3)*1.2)
            flowLayout.minimumInteritemSpacing = cellSpacing
            flowLayout.minimumLineSpacing = cellSpacing
            flowLayout.scrollDirection = .vertical
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


extension CellSavedPostContainer: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellSavedPost.identifier, for: indexPath) as? CellSavedPost else { return UICollectionViewCell() }
        cell.layer.cornerRadius = 8
        cell.layer.borderWidth = 1
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
   
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.frame.width-cellSpacing-48)/2, height: ((self.frame.width-cellSpacing-48)/2)+80.0)
    }
}
