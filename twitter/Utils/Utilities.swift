//
//  Utilities.swift
//  twitter
//
//  Created by 曾子庭 on 2022/6/16.
//

import UIKit

class Utilities{
    
    func inputContainerView(withImage image: UIImage?, textField:UITextField) -> UIView{
        let view = UIView()
        let imageView = UIImageView()
        imageView.image = image
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.width.height.equalTo(24)
        }
        
        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-8)
            make.leading.equalTo(imageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview()
        }
        
        let divider = UIView()
        divider.backgroundColor = .white

        view.addSubview(divider)
        divider.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(0.75)
            make.bottom.equalToSuperview()
        }
        return view
    }
    
    func textField(placeholder:String) -> UITextField{
        let textField = UITextField()
        textField.textColor = .white
        textField.font = UIFont.systemFont(ofSize: 16)
        //讓placeholder設定成白色的
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key .foregroundColor:UIColor.white])
        
        return textField
    }
    
    func attributeButton(_ firstPart:String, _ secondPart:String) -> UIButton{
        let button = UIButton(type: .system)
        
        let attributeTitle = NSMutableAttributedString(string: firstPart, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor:UIColor.white])
        
        attributeTitle.append(NSMutableAttributedString(string: secondPart, attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor:UIColor.white]))
        
        button.setAttributedTitle(attributeTitle, for: .normal)
        return button
    }
    
}
