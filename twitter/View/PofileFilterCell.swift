//
//  PofileFilterCell.swift
//  twitter
//
//  Created by 曾子庭 on 2022/8/1.
//

import UIKit

class PofileFilterCell: UICollectionViewCell {
    
    //MARK: - properties
    var option: PofileFilterOptions!{
        didSet{ titleLabel.text = option.destription }
    }
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()
    
    override var isSelected: Bool{
        didSet{
            titleLabel.font = isSelected ? UIFont.boldSystemFont(ofSize: 16) : UIFont.systemFont(ofSize: 14)
            titleLabel.textColor = isSelected ? .twitterBlue : .lightGray
//            underLineView.backgroundColor = isSelected ? .twitterBlue : .white
//            UIView.animate(withDuration: 0.4) {
//                self.underLineView.layoutIfNeeded()
//            }
        }
    }
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        titleLabel.center(inView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
