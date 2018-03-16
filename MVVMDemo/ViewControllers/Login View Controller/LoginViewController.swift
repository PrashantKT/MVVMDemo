//
//  LoginViewController.swift
//  MVVMDemo
//
//  Created by Prashant on 15/03/18.
//

import UIKit

class LoginViewController: BaseViewController,Alertable {
    
    // MARK: - Outlets
    
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var lblCode: UILabel!
    
    var loginViewModel = LoginViewModel ()
    
    
    
    //--------------------------------------------------------------------------------
    
    // MARK: - Memory Managment
    
    //--------------------------------------------------------------------------------
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //--------------------------------------------------------------------------------
    
    // MARK: - Action Methods
    
    //--------------------------------------------------------------------------------
    
    @IBAction func btnSignInTapped(_ sender: UIButton) {
        let objectValidation = loginViewModel.validate()
        
        switch objectValidation {
        case .success:
            // CALL WS
            loginViewModel.callWSToLogin(failed: { (errorMsg) in
                if let errorMsg = errorMsg {
                    self.showAlert(withMessage: errorMsg)
                }
            })
            
        case .failed (let msg) :
            self.showAlert(withMessage: msg)
        }
        
    }
    
    //--------------------------------------------------------------------------------
    
    // MARK: - Custom Methods
    
    //--------------------------------------------------------------------------------
    
    private func setupView () {
        self.txtUserName.delegate = self
        self.txtPassword.delegate = self
    }
    

    //--------------------------------------------------------------------------------
    
    // MARK: -  View LifeCycle Methods
    
    //--------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        loginViewModel.refereshToken.bind {[unowned self] (strToken) in
            self.lblCode.text = strToken
        }
    }
    
    //--------------------------------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
    }
    
    //--------------------------------------------------------------------------------
    
}

extension LoginViewController : UITextFieldDelegate {
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtUserName {
            textField.text = loginViewModel.userName
        }
        return true
    }
    
    //--------------------------------------------------------------------------------
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtUserName {
            textField.text = loginViewModel.securedUserName
        }
    }
    
    
    //--------------------------------------------------------------------------------
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text ,
            let textRange = Range.init(range, in: text) {
            
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            
            if textField == self.txtUserName {
                loginViewModel.updateUserName(userName: updatedText)
            } else {
                loginViewModel.updatePassword(password: updatedText)
            }
            
        }
        
        return true
    }
    
    
}


