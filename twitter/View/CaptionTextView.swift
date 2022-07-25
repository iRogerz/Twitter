//
//  CaptionTextView.swift
//  twitter
//
//  Created by 曾子庭 on 2022/7/20.
//

import UIKit

//另一個方法是使用UITextViewDelegate來製作
class CaptionTextView: UITextView {
    
    //MARK: - properties
    let placeHolderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.text = "what happining"
        return label
    }()
    
    //MARK: - lifeCycle
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        configureUI()
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - selectors
    @objc func handleTextInputChange(){
        placeHolderLabel.isHidden = !text.isEmpty
    }
    
    //MARK: - Helpers
    func configureUI(){
        
        font = UIFont.systemFont(ofSize: 16)
        backgroundColor = .white
        isScrollEnabled = false
        
        addSubview(placeHolderLabel)
        placeHolderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(8)
        }
    }
}
