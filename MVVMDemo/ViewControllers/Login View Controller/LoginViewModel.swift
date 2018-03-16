//
//  LoginViewModel.swift
//  MVVMDemo
//
//  Created by Prashant on 15/03/18.
//

import Foundation

enum ValidateFields {
    case success
    case failed (msg:String)
}


class LoginViewModel {
    
    // MARK: - Var
    
   private let minimumUserNameText = 5
   private let minimumPasswordText = 8
   private  let refereshTokenTime = 5.0
    
    
    private var user:User = User()
    var speaker:Speaker?
    
    
    var userName : String {
        return user.userName
    }
    
    var password : String {
        return user.password
    }
    
    var securedUserName : String {
        var strUserName = userName
        
        if strUserName.count > minimumUserNameText {
            
            var secure = "*"
            for _ in 0..<minimumUserNameText {
                secure += "*"
            }
            
            strUserName = strUserName.replacingCharacters(in:strUserName.startIndex ... strUserName.index(strUserName.startIndex, offsetBy: minimumUserNameText), with: secure)
        }
        
        return strUserName
    }
    
    var refereshToken : Box<String?> = Box(value: nil)
    
    
    init(user : User = User()) {
        self.user = user
        self.updateRefereshToken()
    }
    
}

extension LoginViewModel {
    
    func validate () -> ValidateFields {
        
        if userName.isEmpty || userName.count < minimumUserNameText {
            return .failed(msg: "User Name is not valid")
        } else if password.isEmpty || password.count < minimumPasswordText {
            return .failed(msg:"Password should be \(minimumPasswordText) characters long")
        }
        
        return .success
    }
    
    //--------------------------------------------------------------------------------
    
    func updateUserName(userName:String) {
        user.userName = userName
    }
    
    //--------------------------------------------------------------------------------
    
    func updatePassword(password:String) {
        user.password = password
    }
    
    //--------------------------------------------------------------------------------
    
    
    func callWSToLogin (failed:@escaping ((String?) -> Void)) {
        let urlStr = "http://edi.pluto-men.com/api/speakers"
        
        AFWrapper.requestGETURL(urlStr, success: { [unowned self] (data) in
            do  {
                let object = try Speaker(data: data)
                self.speaker = object
                print(self.speaker?.message)
            } catch {
                failed(error.localizedDescription)
                
            }
        }) { (error) in
            failed(error.localizedDescription)
        }
        
    }
    
    //--------------------------------------------------------------------------------

    private func updateRefereshToken () {
        
        
        let timer =  Timer.scheduledTimer(withTimeInterval: refereshTokenTime, repeats: true) {[weak self] (timer) in
            self?.refereshToken.value = self?.random()
        }
        timer.fire()
    }
    
    //--------------------------------------------------------------------------------

    
   private func random(_ n: Int = 6) -> String
    {
        let a = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
        
        var s = ""
        
        for _ in 0..<n
        {
            let r = Int(arc4random_uniform(UInt32(a.count)))
            
            s += String(a[a.index(a.startIndex, offsetBy: r)])
        }
        
        return s
    }
    
    
}


