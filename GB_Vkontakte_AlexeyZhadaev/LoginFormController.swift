//
//  LoginFormController.swift
//  Vtentakle_l1_AlexeyZhadaev
//
//  Created by Жадаев Алексей on 29.07.2020.
//  Copyright © 2020 Жадаев Алексей. All rights reserved.
//

import UIKit
import WebKit

class LoginFormController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    // MARK: - Lifecycle
    var urlComponents = URLComponents()
    let session = Session.instance
    let vkService = VkFriendsService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        authVk()
        vkService.loadVkData(method: "friends.get")
        
    }
    
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
    
            let vc = storyboard?.instantiateViewController(identifier: "TabBarStoryboardKey") as! TabBarController
            self.show(vc, sender: nil)
        }
    
    private func authVk() {
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7610592"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        webView.load(request)
    }
}

extension LoginFormController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html",
              let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        
        let token = params["access_token"]
        session.token = token
        debugPrint("Token is: \(session.token)")
        
        decisionHandler(.cancel)
    }
}
