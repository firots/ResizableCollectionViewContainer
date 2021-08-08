//
//  CollectionViewCell.swift
//  ResizableCollectionViewContainer
//
//  Created by Firot on 8.08.2021.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell, ResizableCollectionViewCell {
    static var reuseId: String = "NewsCollectionViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    static var targetCellSize = CGSize(width: 200, height: 200)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let heightConstraint = heightAnchor.constraint(equalToConstant: NewsCollectionViewCell.targetCellSize.height)
        heightConstraint.priority = UILayoutPriority(449)
        
        let widthConstraint = widthAnchor.constraint(equalToConstant: NewsCollectionViewCell.targetCellSize.width)
        widthConstraint.priority = UILayoutPriority(449)
        
        widthConstraint.isActive = true
        heightConstraint.isActive = true
    }
    
    func loadModel<T>(model: T) where T : ResizableCollectionViewModel {
        guard let model =  model as? NewsModel else {
            fatalError("Wrong model loaded in \(#file)")
        }
        
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        
        titleLabel.preferredMaxLayoutWidth = NewsCollectionViewCell.targetCellSize.width
        subtitleLabel.preferredMaxLayoutWidth = NewsCollectionViewCell.targetCellSize.width
    }
}
