//
//  LoginViewController.swift
//  twitter
//
//  Created by 曾子庭 on 2022/6/16.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - properties
    private let loginImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "TwitterLogo")
        
        return imageView
    }()
    
    private lazy var emailContainerView:UIView = {
        let image = UIImage(named: "ic_mail_outline_white_2x-1")
        let view = Utilities().inputContainerView(withImage: image, textField: emailTextField)
//        view.backgroundColor = .red
        
        return view
    }()
    
    private lazy var passwordContainerView:UIView = {
        let image = UIImage(named: "ic_lock_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: image, textField: passwordTextField)
//        view.backgroundColor = .green
        return view
    }()
    
    private let emailTextField:UITextField = {
        let textField = Utilities().textField(placeholder: "Email")
        return textField
    }()
    
    private let passwordTextField:UITextField = {
        let textField = Utilities().textField(placeholder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let loginButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private let signUpButton:UIButton = {
        let button = Utilities().attributeButton("Don't have an account?", " Sign Up")
        button.addTarget(self, action: #selector(handleShowingSignUp), for: .touchUpInside)
        return button
    }()

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    //MARK: - selectors
    @objc func handleShowingSignUp(){
        
    }
    @objc func handleLogin(){
        
    }
    
    //MARK: - Helpers
    func configureUI(){
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        view.backgroundColor = .twitterBlue
        
        view.addSubview(loginImageView)
        loginImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.width.height.equalTo(150)
        }

        let stackView = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually

        //        stackView.backgroundColor = .systemPink
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            //            make.edges.equalToSuperview()
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(32)
            make.centerX.equalToSuperview()
            make.top.equalTo(loginImageView.snp.bottom)
        }
        
        emailContainerView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}
