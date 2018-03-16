//
//  BaseViewController.swift
//  MVVMDemo
//
//  Created by Prashant on 15/03/18.
//

import UIKit



protocol Alertable {
    func showAlert(withMessage message: String);
    func showAlert(withMessage message: String, customActions actions: [UIAlertAction])
}


extension Alertable where Self : UIViewController {
    func showAlert(withMessage message: String) {
        
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "MVVM", message: message, preferredStyle: .alert)
            let actionOK = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alertController.addAction(actionOK)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    //----------------------------------------------------------------
    
    func showAlert(withMessage message: String, customActions actions: [UIAlertAction]) {
        
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "MVVM", message: message, preferredStyle: .alert)
            
            for (_, action) in actions.enumerated() {
                alertController.addAction(action)
            }
            self.present(alertController, animated: true, completion: nil)
        }
    }
}


class BaseViewController: UIViewController {

    // MARK: - Outlets
    
    
    // MARK: - Var
    
    
    //--------------------------------------------------------------------------------
    
    // MARK: - Memory Managment
    
    //--------------------------------------------------------------------------------
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    //--------------------------------------------------------------------------------
    
    // MARK: -  View LifeCycle Methods
    
    //--------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //--------------------------------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
    }
    
    //--------------------------------------------------------------------------------

}
