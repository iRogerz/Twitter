//
//  RegistrationViewController.swift
//  twitter
//
//  Created by 曾子庭 on 2022/6/16.
//

import UIKit
import Firebase

class RegistrationViewController: UIViewController{
    
    //MARK: - properties
    //目前我把imagePicker寫到button裡面了
    //    private let imagePicker:UIImagePickerController = {
    //        let imagePicker = UIImagePickerController()
    //        imagePicker.allowsEditing = true
    //        return imagePicker
    //    }()
    
    private var pofileImage:UIImage?
    
    private lazy var plusPhotoButton:UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handlePlusPhoto), for: .touchUpInside)
        return button
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
    private lazy var fullNameContainerView:UIView = {
        let image = UIImage(named: "ic_person_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: image, textField: fullNameTextField)
        
        return view
    }()
    private lazy var userNameContainerView:UIView = {
        let image = UIImage(named: "ic_person_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: image, textField: userNameTextField)
        
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
    
    private let fullNameTextField:UITextField = {
        let textField = Utilities().textField(placeholder: "Full Name")
        return textField
    }()
    
    private let userNameTextField:UITextField = {
        let textField = Utilities().textField(placeholder: "Username")
        return textField
    }()
    
    private lazy var signUpButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign up", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    private lazy var alreadyHaveAccountButton:UIButton = {
        let button = Utilities().attributeButton("Already have an account?", " Log In")
        button.addTarget(self, action: #selector(handleShowingLoginIn), for: .touchUpInside)
        return button
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate()
        configureUI()
        
    }
    //MARK: - delegate
    func delegate(){
//        imagePicker.delegate = self
    }
    
    //MARK: - selectors
    @objc func handlePlusPhoto(){
        let imagePicker:UIImagePickerController = {
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
            return imagePicker
        }()
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    @objc func handleSignUp(){
        guard let pofileImage = pofileImage else {
            print("DEBUG: please select a photo")
            return
        }
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let fullName = fullNameTextField.text else { return }
        guard let userName = userNameTextField.text else { return }
        
        let credentials = AuthCredentials(email: email, password: password, fullName: fullName, userName: userName, pofileImage: pofileImage)
        
        AuthService.shared.registerUser(credentials: credentials){ error, ref in
            guard let tab = self.view.window?.windowScene?.keyWindow?.rootViewController as? MainTabController else { return }
            
            //跳回到rootController，但下面方法在ios15被棄用了所以使用上面的方法
            //            guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
            //            guard let tab = window.rootViewController as? MainTabController else { return }
            
            tab.authenticateUserAndConfigureUI()
            
            self.dismiss(animated: true)
            print("DEBUG: successful signup!")
        }
    }
    @objc func handleShowingLoginIn(){
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Helpers
    func configureUI(){
        view.backgroundColor = .twitterBlue
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.width.height.equalTo(128)
        }
        
        let stackView = UIStackView(arrangedSubviews: [
            emailContainerView, passwordContainerView, fullNameContainerView, userNameContainerView, signUpButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(32)
            make.centerX.equalToSuperview()
            make.top.equalTo(plusPhotoButton.snp.bottom)
        }
        
        emailContainerView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension RegistrationViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let pofileImage = info[.editedImage] as? UIImage else { return }
        self.pofileImage = pofileImage
        plusPhotoButton.layer.cornerRadius = 128/2
        plusPhotoButton.layer.masksToBounds = true
        //        plusPhotoButton.imageView?.contentMode = .scaleAspectFill
        //        plusPhotoButton.imageView?.clipsToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 3
        plusPhotoButton.setImage(pofileImage.withRenderingMode(.alwaysOriginal ), for: .normal)
        dismiss(animated: true)
    }
}
