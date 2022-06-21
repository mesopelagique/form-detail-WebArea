//
//  ___TABLE___DetailsForm.swift
//  ___PACKAGENAME___
//
//  Created by mesopelagique (eric marchand)
//  Licence MIT https://github.com/mesopelagique/form-detail-WebArea

import UIKit
import WebKit

import QMobileAPI
import QMobileUI

/// Generated details form for ___TABLE___ table.
@IBDesignable
class ___TABLE___DetailsForm: DetailsFormBare, WKUIDelegate, WKNavigationDelegate, UIScrollViewDelegate {

    @IBOutlet var webView: WKWebView!
    @IBOutlet weak var reloadButton: UIBarButtonItem!

    /// The record displayed in this form
    var record: ___TABLE___ {
        return super.record as! ___TABLE___ // swiftlint:disable:this force_cast
    }

    // MARK: URL
    var url: URL? {
        guard let urlString = self.record["___FIELD_1___"] as? String else {
            return nil // not a string
        }
        if urlString.hasPrefix("http") {
            return URL(string: urlString)
        } else if var components = URLComponents(url: .qmobile, resolvingAgainstBaseURL: true) {
            // if no scheme add 4D Server URL, so data is a relative url
            if urlString.hasPrefix("/") {
                components.path = urlString
            } else {
                components.path = "/\(urlString)"
            }
            return components.url
        }
        return nil
    }

    var htmlString: String? {
        guard let urlString = self.record["___FIELD_1___"] as? String else {
            return nil // not a string
        }
        guard urlString.hasPrefix("<") && urlString.hasSuffix(">") else {
            return nil // not html, very very simple way to check
        }
        return urlString
    }

    func loadURL() {
        webView.configuration.websiteDataStore.httpCookieStore.injectSharedHTTPCookies()
        if let htmlString = self.htmlString {
            self.reloadButton.isEnabled = false
            webView.loadHTMLString(htmlString, baseURL: nil)
        } else if let url = self.url {
            self.reloadButton.isEnabled = true
            let request = URLRequest(url: url)
            webView.load(request)
        } else {
            logger.debug("No url to load")
        }
    }

    @IBAction func shareURL(_ sender: Any) {
        if let url = self.url {
            let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
            activityViewController.checkPopUp(sender)

            UIApplication.topViewController?.present(activityViewController, animated: true) {
                logger.info("Share activity presented for url \(url)")
            }
        } else {
            logger.debug("No url to share")
        }
    }

    @IBAction func reload(_ sender: Any) {
        webView.configuration.websiteDataStore.httpCookieStore.injectSharedHTTPCookies()
        if self.webView.isLoading {
            self.webView.stopLoading()
        } else {
            self.webView.reload()
        }
    }

    // MARK: Events
    override func onLoad() {
        // Do any additional setup after loading the view.
        webView.frame = view.bounds
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.scrollView.delegate = self
    }

    override func onWillAppear(_ animated: Bool) {
        // Called when the view is about to made visible. Default does nothing
    }

    override func onDidAppear(_ animated: Bool) {
        // Called when the view has been fully transitioned onto the screen. Default does nothing

        // there is no refresh is URL change, you must close this webview and open it again
        foreground {
            self.loadURL()
        }
    }

    override func onWillDisappear(_ animated: Bool) {
        // Called when the view is dismissed, covered or otherwise hidden. Default does nothing
    }

    override func onDidDisappear(_ animated: Bool) {
        // Called after the view was dismissed, covered or otherwise hidden. Default does nothing
    }

    override open func onRecordChanged() {
        self.loadURL()
    }

    // override on swipe to navigate on webview instead of previous/next record
    @objc override open func onSwipe(_ sender: UISwipeGestureRecognizer!) {
        if sender.direction.contains(.left) {
            if self.webView.canGoForward {
                self.webView.goForward()
            }
        } else if sender.direction.contains(.right) {
            if self.webView.canGoBack {
                self.webView.goBack()
            }
        }
    }

    // MARK: WKNavigationDelegate

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        reloadButton.image = UIImage(systemName: "arrow.clockwise")
        self.navigationItem.title = webView.title ?? ""
        // activityIndicator.stopAnimating()
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        reloadButton.image = UIImage(systemName: "arrow.clockwise")
        // activityIndicator.stopAnimating()
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        reloadButton.image = UIImage(systemName: "xmark")
        // activityIndicator.startAnimating()
    }

    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil { // open blank link too here
            webView.load(navigationAction.request)
        }
        return nil
    }

}

extension WKHTTPCookieStore {

    fileprivate func injectSharedHTTPCookies() {
        for cookie in HTTPCookieStorage.shared.cookies ?? [] {
            setCookie(cookie)
        }
    }

}
