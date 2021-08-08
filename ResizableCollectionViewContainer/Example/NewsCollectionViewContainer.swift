//
//  NewsCollectionViewContainer.swift
//  ResizableCollectionViewContainer
//
//  Created by Firot on 8.08.2021.
//

import UIKit

class NewsCollectionViewContainer: ResizableCollectionViewContainer<NewsCollectionViewCell, NewsModel> {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override var resizableCollectionView: UICollectionView {
        collectionView
    }
    
    override var collectionViewEdgeInsets: UIEdgeInsets {
        UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    override func awakeFromNib() {
        subviews.first?.translatesAutoresizingMaskIntoConstraints = false
        subviews.first?.fillParent()
        
        super.awakeFromNib()
        
        loadNews()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        
        let newsCell = UINib(nibName: NewsCollectionViewCell.reuseId, bundle: nil)
        self.collectionView.register(newsCell, forCellWithReuseIdentifier: NewsCollectionViewCell.reuseId)
        
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func loadNews() {
        items = [
            NewsModel(title: "Why Did Attorney General Loretta Lynch Plead The Fifth?", subtitle: "Why Did Attorney General Loretta Lynch Plead The Fifth? Barracuda Brigade 2016-10-28 Print The administration is blocking congressional probe into cash payments to Iran."),
            
            NewsModel(title: "Weiner Cooperating With FBI On Hillary Email Investigation", subtitle: "Fox News Sunday reported this morning that Anthony Weiner is cooperating with the FBI, which has re-opened (yes, lefties: “re-opened”) the investigation into Hillary Clinton’s classified emails. "),
            
            NewsModel(title: "FANTASTIC! TRUMP'S 7 POINT PLAN To Reform Healthcare Begins With A Bombshell!", subtitle: "Email HEALTHCARE REFORM TO MAKE AMERICA GREAT AGAIN Since March of 2010, the American people have had to suffer under the incredible economic burden of the Affordable Care Act—Obamacare."),
            
            NewsModel(title: "The Crisis of the European Union Is Irreversible ", subtitle: "Taming the corporate media beast The Crisis of the European Union Is Irreversible The political-economic block and its common currency cannot be salvaged Donate! "),
        ]
    }
    
    /* Nothing to do with example, just init from xib code. */
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        guard let contentView = self.fromNib()
            else { fatalError("View could not load from nib") }
        addSubview(contentView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        collectionViewEdgeInsets
    }
}


extension NewsCollectionViewContainer: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionViewCell.reuseId, for: indexPath) as! NewsCollectionViewCell
        cell.loadModel(model: items[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
}
