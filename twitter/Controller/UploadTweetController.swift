//
//  UploadTweetController.swift
//  twitter
//
//  Created by 曾子庭 on 2022/7/19.
//

import UIKit



class UploadTweetController: UIViewController{
    
    //MARK: - properties
    private let user: User
    private let config: UploadTweetConfiguration
    private lazy var viewModel = UPloadTweetViewModel(config: config)
    
    private lazy var tweetButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .twitterBlue
        button.setTitle("Tweet", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(handleUploadTweet), for: .touchUpInside)
        return button
    }()
    
    private let pofileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.setDimensions(width: 48, height: 48)
        imageView.layer.cornerRadius = 48 / 2
        imageView.backgroundColor = .twitterBlue
        return imageView
    }()
    
    private let captionTextView = CaptionTextView()
    
    //MARK: - LifeCycle
    init(user: User, config: UploadTweetConfiguration){
        self.user = user
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        switch config {
        case .tweet:
            print("DEBUG: Config is tweet")
        case .reply(let tweet):
            print("DEBUG: Repling to \(tweet.caption)")
        }
    }
    
    //MARK: - selectors
    @objc func handleCancel(){
        dismiss(animated: true)
    }
    
    @objc func handleUploadTweet(){
        guard let caption = captionTextView.text else { return }
        TweetService.shared.uploadTweet(caption: caption) { error, ref in
            if let error = error {
                print("DEBUG: Fail to upload tweets with error \(error.localizedDescription)")
                return
            }
            self.dismiss(animated: true)
        }
    }
    //MARK: - Helpers
    func configureUI(){
        view.backgroundColor = .white
        configureNavigationBar()
        
        //        let stack = UIStackView(arrangedSubviews: [pofileImageView, captionTextView])
        //        stack.axis = .horizontal
        //        stack.spacing = 12
//        stack.alignment = .leading
        //        view.addSubview(stack)
        //        stack.snp.makeConstraints { make in
        //            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
        //            make.leading.equalToSuperview().offset(16)
        //            make.trailing.equalToSuperview().offset(-16)
        //        }
        view.addSubview(pofileImageView)
        pofileImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        view.addSubview(captionTextView)
        captionTextView.snp.makeConstraints { make in
            make.top.equalTo(pofileImageView.snp.top)
            make.leading.equalTo(pofileImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(300)
        }
        
//        guard let url = URL(string: user.pofileImageURL) else { return }
        pofileImageView.sd_setImage(with: user.pofileImageURL)
    }
    
    func configureNavigationBar(){
        //        navigationController?.navigationBar.tintColor = .twitterBlue
        //        navigationController?.navigationBar.barTintColor = .white
        //        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: tweetButton)
    }
}
