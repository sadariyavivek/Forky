//
//  cellExploreCarousel.swift
//  Forky
//
//  Created by Vivek Sadariya on 09/10/21.
//

import UIKit

class cellExploreCarousel: UITableViewCell {

    @IBOutlet weak var collview: collCarouselExplore!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setComponent()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setComponent() {
        self.collview.delegate = self
        self.collview.dataSource = self

        collview.register(cellCarousel.nib, forCellWithReuseIdentifier: cellCarousel.identifier)
    }
    
}

extension cellExploreCarousel: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellCarousel.identifier, for: indexPath) as? cellCarousel else { return UICollectionViewCell() }
        //cell.add
        
        return cell
    }
}

extension cellExploreCarousel: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
}

extension cellExploreCarousel: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collview.didScroll()
        guard let currentCenterIndex = collview.currentCenterCellIndex?.row else { return }
       print(currentCenterIndex)
    }
}
