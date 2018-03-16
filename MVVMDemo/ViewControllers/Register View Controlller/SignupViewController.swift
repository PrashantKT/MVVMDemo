//
//  SignupViewController.swift
//  MVVMDemo
//
//  Created by Prashant on 16/03/18.
//

import UIKit

class SignupViewController: BaseViewController,Alertable {

    // MARK: - Outlets
    
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtCity: UITextField!

    @IBOutlet weak var txtPasword: UITextField!
    @IBOutlet weak var txtConfirmPasword: UITextField!
    
    @IBOutlet weak var lblConfirmPassword: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    // MARK: - Var

    var viewModel:RegisterViewModel = RegisterViewModel()
    
    //--------------------------------------------------------------------------------
    
    // MARK: - Memory Managment
    
    //--------------------------------------------------------------------------------
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //--------------------------------------------------------------------------------
    
    // MARK: - Action Methods
    
    //--------------------------------------------------------------------------------
    
    @IBAction func btnRegisterTapped(_ sender: UIButton) {
        switch viewModel.validate() {
        case .success:
            break
        case .failed(let error):
            self.showAlert(withMessage: error)
            
            
        }
    }
    
    //--------------------------------------------------------------------------------
    
    // MARK: - Cusotm Methods
    
    //--------------------------------------------------------------------------------
    
    private func setupView () {
        viewModel.confirmPassword.bind { [unowned self] (string) in
            self.lblConfirmPassword.textColor = self.viewModel.validatePasswordFields()
        }
        
        viewModel.email.bind { [unowned self] (string) in
            self.lblEmail.textColor = self.viewModel.validEmailAddress()
        }
    }
    
    //--------------------------------------------------------------------------------

    func identifyTextField (textField : UITextField) {
        
    }
    
    
    //--------------------------------------------------------------------------------
    
    // MARK: -  View LifeCycle Methods
    
    //--------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //--------------------------------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
    }
    
    //--------------------------------------------------------------------------------
}


// MARK: - UITextField Delegates Extension

extension SignupViewController:UITextFieldDelegate {
        
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == txtFirstName {
            textField.text = viewModel.firstName
        } else if textField == txtLastName {
            textField.text = viewModel.lastName
        } else if textField == txtEmail {
            textField.text = viewModel.email.value
        }else if textField == txtPasword {
            textField.text = viewModel.password
        }else if textField == txtConfirmPasword {
            textField.text = viewModel.confirmPassword.value
        }else if textField == txtPhone {
            textField.text = viewModel.phone
        }else if textField == txtCity {
            textField.text = viewModel.city
        }
        
        return true
    }
    
    //--------------------------------------------------------------------------------

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if  let text =  textField.text ,
            let txtRange = Range(range,in : text) {
            
            let updatedText = text.replacingCharacters(in: txtRange, with: string)
            
            if textField == txtFirstName {
                viewModel.updateField(field: .firstName, withString: updatedText)
            } else if textField == txtLastName {
                viewModel.updateField(field: .lastName, withString: updatedText)
            } else if textField == txtEmail {
                viewModel.updateField(field: .email, withString: updatedText)
            }else if textField == txtPasword {
                viewModel.updateField(field: .password, withString: updatedText)
            }else if textField == txtConfirmPasword {
                viewModel.updateField(field: .confirmPassword, withString: updatedText)
            }else if textField == txtPhone {
                viewModel.updateField(field: .phone, withString: updatedText)
            }else if textField == txtCity {
                viewModel.updateField(field: .city, withString: updatedText)
            }
        }
        
        return true
    }
    
    //--------------------------------------------------------------------------------
    
}

