import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView?
    var urlStr: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        //フォワグラウンドから戻ってきたときに loadWebView を実行する
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.loadWebView),
            name: NSNotification.Name.UIApplicationWillEnterForeground,
            object: nil
        )

        self.initWebView()
        self.loadWebView()
        self.view.addSubview(self.webView!)
    }

    //init
    func initWebView() {
        //サイズ設定
        let deviceBound : CGRect = UIScreen.main.bounds
        self.webView = WKWebView(frame: CGRect(x: 0, y: 20, width: deviceBound.size.width, height: deviceBound.size.height - 20))
        self.webView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        self.webView?.navigationDelegate = self as WKNavigationDelegate

        //スワイプで戻る、進むを有効化
        self.webView?.allowsBackForwardNavigationGestures = true
    }

    //load WebView
    func loadWebView() {
        let str = self.getUrlStr()

        if(str == "") {
            //設定画面を開く
            let url = NSURL(string:UIApplicationOpenSettingsURLString)
            UIApplication.shared.open(url! as URL)
        } else if (str != self.urlStr) {
            self.urlStr = str
            let url = NSURL(string: urlStr)
            let req = NSURLRequest(url: url! as URL)
            self.webView!.load(req as URLRequest)
        }
    }

    //設定から URL 取得
    func getUrlStr() -> String {
        let defaults = UserDefaults()
        if( defaults.object(forKey: "url") != nil ) {
            return defaults.object(forKey: "url") as! String
        }

        return "";
    }

    //URL Scheme の対応
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url else {
            decisionHandler(.cancel)
            return
        }

        //http, https 以外なら openURL
        if !url.absoluteString.hasPrefix("http://") && !url.absoluteString.hasPrefix("https://") {
            UIApplication.shared.open(url)
            decisionHandler(.cancel)
            return
        }

        decisionHandler(.allow)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //ランドスケープ時もステータスバーを表示する
    override var prefersStatusBarHidden: Bool {
        return false
    }
}
