//
//  TweetCell.swift
//  twitter
//
//  Created by 曾子庭 on 2022/7/25.
//

import UIKit

protocol TweetCellDelegate: AnyObject {
    func handlePofileImageTapped(_ cell: TweetCell)
    func handleReplyTapped(_ cell: TweetCell)
}

class TweetCell: UICollectionViewCell {
    //MARK: - properties
    var tweet: Tweet?{
        didSet { configure() }
    }
    static let identifier = "tweetCell"
    
    weak var delegate: TweetCellDelegate?
    
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
    
    private let infoLabel = UILabel()
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()

    private lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "comment"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(handleCommentTapped), for: .touchUpInside)
        return button
    }()
    private lazy var retweetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "retweet"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(handleRetweetTapped), for: .touchUpInside)
        return button
    }()
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "like"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(handleLikeTapped), for: .touchUpInside)
        return button
    }()
    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "share"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(handleShareTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - lifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        backgroundColor = .red
        addSubview(pofileImageView)
        pofileImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(8)
        }
        let stack = UIStackView(arrangedSubviews: [infoLabel, captionLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.distribution = .fillProportionally
        addSubview(stack)
        stack.snp.makeConstraints { make in
            make.leading.equalTo(pofileImageView.snp.trailing).offset(12)
            make.top.equalTo(pofileImageView.snp.top)
            make.trailing.equalToSuperview().offset(-12)
        }
        
        infoLabel.font = UIFont.systemFont(ofSize: 14)
//        infoLabel.text = "roger @iRogerz"
        
        let actionStack = UIStackView(arrangedSubviews: [commentButton, retweetButton, likeButton, shareButton])
        actionStack.spacing = 72
        addSubview(actionStack)
        actionStack.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        let underLineView = UIView()
        addSubview(underLineView)
        underLineView.backgroundColor = .systemGroupedBackground
        underLineView.snp.makeConstraints { make in
            make.trailing.leading.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
    }
    
    //MARK: - selectors
    @objc func handlePofileImageTap(){
        //不能在cell事件push新的viewcontroller,要記得在cell的父controller上才能push！！
        //所以使用delegate傳給viewcontroller是個好方法
        delegate?.handlePofileImageTapped(self)
    }
    @objc func handleCommentTapped(){
        delegate?.handleReplyTapped(self)
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helps
    func configure(){
        guard let tweet = tweet else { return }
        let viewModel = TweetViewModel(tweet: tweet)
        
        captionLabel.text = tweet.caption
//        guard let url = URL(string: viewModel.pofileImageUrl) else { return }
        pofileImageView.sd_setImage(with: viewModel.pofileImageUrl)
        infoLabel.attributedText = viewModel.userInfoText
    }
}


