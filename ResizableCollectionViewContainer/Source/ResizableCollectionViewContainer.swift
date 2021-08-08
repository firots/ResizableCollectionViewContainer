//
//  ResizableCollectionViewContainer.swift
//  ResizableCollectionViewContainer
//
//  Created by Firot on 8.08.2021.
//

import UIKit

class ResizableCollectionViewContainer<Cell: ResizableCollectionViewCell, Model:ResizableCollectionViewModel>: UIView, UICollectionViewDelegateFlowLayout {
    
    weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    var resizableCollectionView: UICollectionView {
        fatalError("resizablecollectionView needs to be overridden.")
    }
    
    var items = [Model]()
    
    private var calculatedLargestSize: CGSize?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionViewHeightConstraint = resizableCollectionView.heightAnchor.constraint(equalToConstant: Cell.targetCellSize.height)
        collectionViewHeightConstraint.isActive = true
    }
    
    /* Call super if overridden. */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        calculatedLargestSize ?? calculateLargestCellSize()
    }
    
    /* Call before every reloaddata. */
    func resetCalculatedCellSize() {
        calculatedLargestSize = nil
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if previousTraitCollection?.preferredContentSizeCategory != traitCollection.preferredContentSizeCategory {
            resetCalculatedCellSize()
            calculateLargestCellSize()
            resizableCollectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    /* Calculate estimated largest cell size and set it's height to collection view. */
    @discardableResult
    private func calculateLargestCellSize() -> CGSize {
        guard let model = getModelWithLargestEstimatedContentSize(), let nib = Bundle.main.loadNibNamed(Cell.reuseId, owner: Cell.self, options: nil), let cell = nib[0] as? Cell else {
            return CGSize(width: 0, height: 0)
        }
        
        cell.loadModel(model: model)
        
        cell.setNeedsLayout()
        cell.layoutIfNeeded()

        let cellSize = cell.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        
        collectionViewHeightConstraint.constant = cellSize.height
        
        calculatedLargestSize = cellSize
        
        layoutIfNeeded()
        
        return cellSize
    }
    
    /* Override for custom content size calculations, no need to call super. */
    func getModelWithLargestEstimatedContentSize() -> Model? {
        guard var largestModel = items.first else {
            return nil
        }
        
        for model in items {
            if calculateEstimatedContentSize(for: model) > calculateEstimatedContentSize(for: largestModel) {
                largestModel = model
            }
        }
        
        return largestModel
    }
    
    /* Override for custom content size calculations or better performance, no need to call super. */
    func calculateEstimatedContentSize(for model: Model) -> Int {
        let mirror = Mirror(reflecting: model)
        
        var size = 0
        
        for child in mirror.children {
            if let strChild = child.value as? String {
                size += strChild.count
            }
        }
        
        return size
    }
}

protocol ResizableCollectionViewModel {
    
}

/* Conform your cell to this protocol. */
protocol ResizableCollectionViewCell where Self: UICollectionViewCell {
    static var reuseId: String { get }
    func loadModel<T: ResizableCollectionViewModel>(model: T)
    static var targetCellSize: CGSize { get }
}
