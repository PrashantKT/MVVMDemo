//
//  RegisterViewModel.swift
//  MVVMDemo
//
//  Created by Prashant on 16/03/18.
//


import Foundation
import UIKit
class RegisterViewModel {
    
    enum RegisterFields {
        case firstName
        case lastName
        case email
        case phone
        case city
        case password
        case confirmPassword
    }
    
    private var registerModel : RegisterUserModel
        
    private var confirmPasswordObserver : NSKeyValueObservation?
    private var emailObserver : NSKeyValueObservation?

     private let minPasswordLenght = 8
    
    init(model: RegisterUserModel = RegisterUserModel()) {
        self.registerModel = model
        confirmPasswordObserver = self.registerModel.observe(\RegisterUserModel.confirmPassword) {[unowned self] (model, value) in
            self.confirmPassword.value = model.confirmPassword
        }
        emailObserver = self.registerModel.observe(\RegisterUserModel.email) {[unowned self] (model, value) in
            self.email.value = model.email
        }
    }
    
    deinit {
        self.confirmPasswordObserver?.invalidate()
    }
    
    var firstName:String {
        return registerModel.firstName
    }
    
    var lastName:String {
        return registerModel.lastName
    }
    
    var email:Box<String>  = Box(value: "")
    
    var phone : String {
        return registerModel.phone
    }
    
    var city:String {
        return registerModel.city
    }
    
    var password : String {
        return registerModel.password
    }
    
    var confirmPassword : Box<String>  = Box(value: "")
    
    
}

extension RegisterViewModel {

    func updateField (field:RegisterFields, withString str:String) {
        switch field {
        case .firstName:
            registerModel.firstName = str
        
        case .lastName:
            registerModel.lastName = str

        case .email:
            registerModel.email = str

        case .phone:
            registerModel.phone = str

        case .city:
            registerModel.city = str

        case .password:
            registerModel.password = str
            registerModel.confirmPassword =  confirmPassword.value

        case .confirmPassword:
            registerModel.confirmPassword = str
        }
    }
    
    //--------------------------------------------------------------------------------

    private  func isValidEmail(testStr:String) -> Bool {
        
        let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
        
    }

    //--------------------------------------------------------------------------------
    
    func validate () -> ValidateFields {
        
        if firstName.isEmpty {
            return .failed(msg: "Firstname can not be empty")
        } else  if lastName.isEmpty {
            return .failed(msg: "Lastname can not be empty")
        } else  if email.value.isEmpty {
            return .failed(msg: "Email can not be empty")
        } else  if  !isValidEmail(testStr: email.value) {
            return .failed(msg: "Email is not valid")
        } else if password.isEmpty {
            return .failed(msg: "Password can not be empty")
        } else if password.count < minPasswordLenght {
            return .failed(msg: "Password should be 8 Characters long")
        } else if confirmPassword.value.isEmpty {
            return .failed(msg: "Confirm Password can not be empty")
        } else if password != confirmPassword.value {
            return .failed(msg: "Password does not match with confirm password")
        } else  if phone.isEmpty {
            return .failed(msg: "Phone can not be empty")
        } else  if !phone.isPhoneNumber {
            return .failed(msg: "Phone is not valid")
        } else  if city.isEmpty {
            return .failed(msg: "City can not be empty")
        }
        
        return .success
    }
    
    //--------------------------------------------------------------------------------

    func validatePasswordFields () -> UIColor {
        
        if password != confirmPassword.value {
            return .red
        }
        return .black
        
    }
    
    //--------------------------------------------------------------------------------

    func validEmailAddress () -> UIColor {
        
        
        
        if  !isValidEmail(testStr: email.value) && !email.value.isEmpty {
            return .red
        }
        return .black
    }
    
}

extension String {
    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
}
