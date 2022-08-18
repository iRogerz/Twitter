//
//  PofileHeader.swift
//  twitter
//
//  Created by 曾子庭 on 2022/8/1.
//

import UIKit
import SnapKit

protocol PofileHeaderDelegate: AnyObject{
    func handleDismissal()
}
class PofileHeader: UICollectionReusableView {
        
    //MARK: - properties
    var user: User?{
        didSet{ configureUI() }
    }
    weak var delegate: PofileHeaderDelegate?
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .twitterBlue
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(42)
            make.leading.equalToSuperview().offset(16)
        }
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        //withRenderingMode強制顯示原本的色彩
        button.setImage(UIImage(named: "baseline_arrow_back_white_24dp")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    let pofileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.setDimensions(width: 80, height: 80)
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = 80/2
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 4
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
    private lazy var editPofileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Loading", for: .normal)
        button.setTitleColor(UIColor.twitterBlue, for: .normal)
        button.layer.borderWidth = 1.25
        button.setDimensions(width: 100, height: 36)
        button.layer.cornerRadius = 36/2
        button.layer.borderColor = UIColor.twitterBlue.cgColor
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleEditPofileFollow), for: .touchUpInside)
        return button
    }()
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 3
        label.text = "asdfaoinbb asfgoasa asdfoasd asoiawg sa"
        return label
    }()
    private let filterBar = PofileFilterView()
    
//    private let underLineView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .twitterBlue
//        return view
//    }()
    
    private let followingLabel: UILabel = {
        let label = UILabel()
        let followTap = UITapGestureRecognizer(target: self, action: #selector(handleFollowingTap))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(followTap)
        return label
    }()
    
    private let followersLabel: UILabel = {
        let label = UILabel()
        let followTap = UITapGestureRecognizer(target: self, action: #selector(handleFollowersTap))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(followTap)
        return label
    }()
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
//        filterBar.delegate = self
        
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(100)
        }
        addSubview(pofileImageView)
        pofileImageView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(-24)
            make.leading.equalToSuperview().offset(8)
//            make.height.width.equalTo(80)
        }
        
        addSubview(editPofileButton)
        editPofileButton.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(12)
            make.trailing.equalToSuperview().offset(-12)
//            make.width.equalTo(100)
//            make.height.equalTo(36)
        }
        let userDetailStack = UIStackView(arrangedSubviews: [fullnameLabel, usernameLabel, bioLabel])
        userDetailStack.axis = .vertical
        userDetailStack.distribution = .fillProportionally
        userDetailStack.spacing = 4
        
        addSubview(userDetailStack)
        userDetailStack.snp.makeConstraints { make in
            make.top.equalTo(pofileImageView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
        
        let followStack = UIStackView(arrangedSubviews: [followingLabel, followersLabel])
        followStack.axis = .horizontal
        followStack.spacing = 8
        followStack.distribution = .fillEqually
        
        addSubview(followStack)
        followStack.snp.makeConstraints { make in
            make.top.equalTo(userDetailStack.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(12)
        }
        
        addSubview(filterBar)
        filterBar.snp.makeConstraints { make in
            make.bottom.trailing.leading.equalToSuperview()
            make.height.equalTo(50)
        }
//        addSubview(underLineView)
//        underLineView.snp.makeConstraints { make in
//            make.bottom.equalToSuperview()
//            make.leading.equalToSuperview()
//            make.width.equalToSuperview().dividedBy(PofileFilterOptions.allCases.count)
//            make.height.equalTo(2)
//        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - selectors
    @objc func handleDismiss(){
        delegate?.handleDismissal()
    }
    @objc func handleEditPofileFollow(){
        
    }
    @objc func handleFollowingTap(){
        
    }
    @objc func handleFollowersTap(){
        
    }
    
    //MARK: - Helpers
    func configureUI(){
        guard let user = user else { return }
        let viewModel = PofileHeaderViewModel(user: user)
        
        pofileImageView.sd_setImage(with: user.pofileImageURL)
        
        editPofileButton.setTitle(viewModel.actionButtonTitle, for: .normal)
        followingLabel.attributedText = viewModel.followeringString
        followersLabel.attributedText = viewModel.followersString
        
        fullnameLabel.text = user.fullname
        usernameLabel.text = viewModel.usernameText
    }
    
}

//MARK: - PofileFilterViewDelegate
//extension PofileHeader: PofileFilterViewDelegate{
//    func filterView(_ view: PofileFilterView, didSelect indexpath: IndexPath) {
//        guard let cell = view.collectionView.cellForItem(at: indexpath) as? PofileFilterCell else { return }
//        let xPosition = cell.frame.origin.x
//        UIView.animate(withDuration: 0.3) {
//            self.underLineView.frame.origin.x = xPosition
//        }
//    }
//}
