//
//  BaseViewController.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 17/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import Foundation

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers()
        setupViews()
    }
    
    public func showLoader(_ show: Bool, status: String? = nil) {
        if let status = status {
            SVProgressHUD.setDefaultMaskType(.clear)
            show == true ? SVProgressHUD.show(withStatus: status) : SVProgressHUD.dismiss()
            return
        }
        show == true ? SVProgressHUD.show() : SVProgressHUD.dismiss()
    }
    
    public func showAlertWith(title: String, message: String, actionTitle: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(
            title: actionTitle,
            style: .default,
            handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
}

// MARK: - Setup views
extension BaseViewController {
    
    private func setupViews() {
        view.backgroundColor = .white()
        navigationController?.navigationBar.isTranslucent = false
    }
    
    /**
     * Add observers to the view
     */
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(retryConnection), name: .retryConnection, object: nil)
    }
    
    @objc private func retryConnection() {
        SVProgressHUD.show(withStatus: "🤔 it seems this is taking a little bit. Please be patience")
    }
    
}
