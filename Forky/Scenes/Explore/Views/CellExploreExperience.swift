//
//  CellExploreExperience.swift
//  Forky
//
//  Created by Vivek Sadariya on 30/10/21.
//

import UIKit

class CellExploreExperience: UITableViewCell {
    @IBOutlet weak var lblQnt: UILabel!
    @IBOutlet weak var collview: UICollectionView!
    
    var slcCallback:((String,String)->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setCollectionView()
        setUI()
    }
    
    private func setUI() {
        lblQnt.text = "Explore by experience"
    }
    
    private func setCollectionView() {
        collview.delegate = self
        collview.dataSource = self
        
        collview.showsHorizontalScrollIndicator = false
        collview.showsVerticalScrollIndicator = false
        
        //collview.isPagingEnabled = true
        collview.register(CellExperience.nib, forCellWithReuseIdentifier: CellExperience.identifier)
        setCollectionViewLayout()
    }
    
    private func setCollectionViewLayout() {
        if let flowLayout = collview.collectionViewLayout as? UICollectionViewFlowLayout {
            //flowLayout.itemSize = CGSize(width: (self.view.frame.size.width-61)/3, height: ((self.view.frame.size.width-61)/3)*1.2)
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.minimumLineSpacing = 0
            flowLayout.scrollDirection = .horizontal
        }
    }
}

extension CellExploreExperience: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellExperience.identifier, for: indexPath) as? CellExperience else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width-50, height: 72)
    }
}

