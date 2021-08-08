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
    
    static let targetCellSize = CGSize(width: 175, height: 275)
    static let forceAspectRatio = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        loadTargetSizeConstraints()
    }
    
    func loadModel<T>(model: T) where T : Any {
        guard let model =  model as? NewsModel else {
            fatalError("Wrong model loaded in \(#file)")
        }
        
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        
        titleLabel.preferredMaxLayoutWidth = NewsCollectionViewCell.targetCellSize.width
        subtitleLabel.preferredMaxLayoutWidth = NewsCollectionViewCell.targetCellSize.width
    }
}
