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
        
        return view
    }()
    
    private lazy var passwordContainerView:UIView = {
        let image = UIImage(named: "ic_lock_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: image, textField: passwordTextField)

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
    
    private lazy var loginButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private lazy var dontHaveAccountButton:UIButton = {
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
        let controller = RegistrationViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    @objc func handleLogin(){
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        AuthService.shared.logUserIn(email: email, password: password){ (result, error) in
            if let error = error{
                print("DEBUG: error log in \(error.localizedDescription)")
                return
            }
            
            guard let tab = self.view.window?.windowScene?.keyWindow?.rootViewController as? MainTabController else { return }
            //跳回到rootController，但下面方法在ios15被棄用了所以使用上面的方法
//            guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
//            guard let tab = window.rootViewController as? MainTabController else { return }
            tab.authenticateUserAndConfigureUI()
            
            self.dismiss(animated: true)
            print("DEBUG: successful login")
        }
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
            make.width.height.equalTo(128)
        }

        let stackView = UIStackView(arrangedSubviews: [
            emailContainerView, passwordContainerView, loginButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(32)
            make.centerX.equalToSuperview()
            make.top.equalTo(loginImageView.snp.bottom)
        }
        
        emailContainerView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}
