//
//  UserCell.swift
//  twitter
//
//  Created by 曾子庭 on 2022/8/24.
//

import UIKit

class UserCell: UITableViewCell {
    
    //MARK: - properties
    var user: User? {
        didSet { configure() }
    }
    
    private lazy var pofileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.setDimensions(width: 40, height: 40)
        imageView.layer.cornerRadius = 40 / 2
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .twitterBlue
        
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Username"
        return label
    }()
    
    private let fullnameLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "fullname"
        return label
    }()
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(pofileImageView)
        pofileImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(12)
        }
        
        let stack = UIStackView(arrangedSubviews: [usernameLabel, fullnameLable])
        stack.axis = .vertical
        stack.spacing = 2
        
        addSubview(stack)
        stack.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(pofileImageView.snp.trailing).offset(12)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Helpers
    
    func configure(){
        guard let user = user else { return }
        pofileImageView.sd_setImage(with: user.pofileImageURL)
        usernameLabel.text = user.username
        fullnameLable.text = user.fullname
    }

}
