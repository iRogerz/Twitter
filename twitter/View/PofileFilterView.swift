//
//  PofileFilterView.swift
//  twitter
//
//  Created by 曾子庭 on 2022/8/1.
//

import UIKit

private let reuserIdentifier = "PofileCell"

//MARK: - protocol
//protocol PofileFilterViewDelegate: AnyObject{
//    func filterView(_ view: PofileFilterView, didSelect indexpath: IndexPath)
//}

class PofileFilterView: UIView {
    
    //MARK: - properties
//    weak var delegate: PofileFilterViewDelegate?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PofileFilterCell.self, forCellWithReuseIdentifier: reuserIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private let underLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .twitterBlue
        return view
    }()
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //讓起始預設第一個cell是點擊狀態
        let selectedIndexPath = IndexPath(row: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .left)
        
        addSubview(collectionView)
        collectionView.addConstraintsToFillView(self)
        addSubview(underLineView)
        underLineView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalToSuperview().dividedBy(PofileFilterOptions.allCases.count)
            make.height.equalTo(2)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UICollectionViewDataSource
extension PofileFilterView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PofileFilterOptions.allCases.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuserIdentifier, for: indexPath) as! PofileFilterCell
        let option = PofileFilterOptions(rawValue: indexPath.row)
        cell.option = option
        //我以前應該會這樣寫
        //        cell.titleLabel.text = PofileFilterOptions(rawValue: indexPath.row)?.destription
        return cell
    }
    
}


//MARK: - UICollectionViewDelegate
extension PofileFilterView: UICollectionViewDelegate{
    //用來傳值回去pofileheader來操控underline的移動
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        delegate?.filterView(self, didSelect: indexPath)
        guard let cell = collectionView.cellForItem(at: indexPath) as? PofileFilterCell else { return }
        let xPosition = cell.frame.origin.x
        UIView.animate(withDuration: 0.3) {
            self.underLineView.frame.origin.x = xPosition
        }
        
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension PofileFilterView: UICollectionViewDelegateFlowLayout{
    
    //每個cell的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let count = CGFloat(PofileFilterOptions.allCases.count)
        return CGSize(width: frame.width / count, height: frame.height)
    }
    
    //item之間的spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
