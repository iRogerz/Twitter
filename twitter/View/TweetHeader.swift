//
//  TweetHeader.swift
//  twitter
//
//  Created by 曾子庭 on 2022/8/31.
//

import UIKit
import SnapKit


class TweetHeader: UICollectionReusableView {
    
    //MARK: - properties
    var tweet: Tweet? {
        didSet { configure() }
    }
    private lazy var pofileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.setDimensions(width: 48, height: 48)
        imageView.layer.cornerRadius = 48 / 2
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .twitterBlue
        let tap = UITapGestureRecognizer(target: self, action: #selector(handlePofileImageTap))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.text = "iroger"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "asdf"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "asdfㄑasdffd some text cod I am so glad to see you"
        //有無限的行數
        label.numberOfLines = 0
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.textAlignment = .left
        label.text = "6:33 PM - 12/22/2022"
        return label
    }()
    
    private lazy var optionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .lightGray
        button.setImage(UIImage(named: "down_arrow_24pt"), for: .normal)
        button.addTarget(self, action: #selector(showActionSheet), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var retweetsLabel = UILabel()
    
    
    private lazy var likesLabel = UILabel()
    
    private lazy var statsView: UIView = {
        let view = UIView()
        
        let divider1 = UIView()
        divider1.backgroundColor = .systemGroupedBackground
        view.addSubview(divider1)
        divider1.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
            make.height.equalTo(1)
        }
        
        let stack = UIStackView(arrangedSubviews: [retweetsLabel, likesLabel])
        stack.axis = .horizontal
        stack.spacing = 12
        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.centerY.equalTo(view.snp.centerY)
            make.leading.equalToSuperview().offset(16)
        }
        
        let divider2 = UIView()
        divider2.backgroundColor = .systemGroupedBackground
        view.addSubview(divider2)
        divider2.snp.makeConstraints { make in
            make.bottom.trailing.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
            make.height.equalTo(1)
        }
        
        return view
    }()
    
    private lazy var commentButton: UIButton = {
        let button = createButton(withImageName: "comment")
        button.addTarget(self, action: #selector(handleCommentTapped), for: .touchUpInside)
        return button
    }()
    private lazy var retweetButton: UIButton = {
        let button = createButton(withImageName: "retweet")
        button.addTarget(self, action: #selector(handleRetweetTapped), for: .touchUpInside)
        return button
    }()
    private lazy var likeButton: UIButton = {
        let button = createButton(withImageName: "like")
        button.addTarget(self, action: #selector(handleLikeTapped), for: .touchUpInside)
        return button
    }()
    private lazy var shareButton: UIButton = {
        let button = createButton(withImageName: "share")
        button.addTarget(self, action: #selector(handleShareTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let labelStack = UIStackView(arrangedSubviews: [fullnameLabel, usernameLabel])
        labelStack.axis = .vertical
        labelStack.spacing = -6
        
        let stack = UIStackView(arrangedSubviews: [pofileImageView, labelStack])
        stack.spacing = 12
        
        addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        
        addSubview(captionLabel)
        captionLabel.snp.makeConstraints { make in
            make.top.equalTo(stack.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(captionLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
        }
        
        addSubview(optionButton)
        optionButton.snp.makeConstraints { make in
            make.centerY.equalTo(stack.snp.centerY)
            make.trailing.equalToSuperview().inset(8)
        }
        
        addSubview(statsView)
        statsView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        
        let actionStack = UIStackView(arrangedSubviews: [commentButton, retweetButton, likeButton, shareButton])
        actionStack.spacing = 72
        addSubview(actionStack)
        actionStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            
            make.bottom.equalToSuperview().inset(12)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - selectors
    @objc func handlePofileImageTap() {
        
    }
    
    @objc func showActionSheet(){
        
    }
    
    @objc func handleCommentTapped(){
        print("asdf")
    }
    @objc func handleRetweetTapped(){
        print("asdf")
    }
    @objc func handleLikeTapped(){
        print("asdf")
    }
    @objc func handleShareTapped(){
        print("asdf")
    }
    
    
    //MARK: - Helpers
    func configure(){
        guard let tweet = tweet else { return }
        
        let viewModel = TweetViewModel(tweet: tweet)
        captionLabel.text = viewModel.tweet.caption
        fullnameLabel.text = viewModel.user.fullname
        usernameLabel.text = viewModel.usernameText
        pofileImageView.sd_setImage(with: viewModel.pofileImageUrl)
        dateLabel.text = viewModel.headerTimestamp
        retweetsLabel.attributedText = viewModel.retweetsAttributedString
        likesLabel.attributedText = viewModel.likesAttributedString
        
    }
    
    func createButton(withImageName imagename: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: imagename), for: .normal)
        button.setDimensions(width: 20, height: 20)
        button.tintColor = .darkGray
        return button
    }
}
