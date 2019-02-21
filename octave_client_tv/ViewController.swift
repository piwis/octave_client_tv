//
//  ViewController.swift
//  octave_client_tv
//
//  Created by Théo on 20/02/2019.
//  Copyright © 2019 Théo Pazzaglia. All rights reserved.
//

import UIKit
import WebKit
import SABlurImageView
import VisualEffectView



class ViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var overView: UIView!
    
    @IBOutlet weak var squareView: UIView!
    @IBOutlet weak var squareView2: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
    
        // Do any additional setup after loading the view, typically from a nib.
        let url = URL(string: "http://192.168.2.3.:8081/")!
        webView.load(URLRequest(url: url))
    
        // 2
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [refresh]
        navigationController?.isToolbarHidden = false
        
        
        self.overView.alpha = 0.3
        
        // BLUR
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 1.0
        
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.overView.addSubview(blurEffectView)


        /*mask(viewToMask: self.overView, maskRect: CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: 400, height: 400))*/
        
        //let imageView = SABlurImageView(image: image)
        //imageView.addBlurEffect(30, times: 1)
        
    }
    
    func mask(viewToMask: UIView, maskRect: CGRect, invert: Bool = false) {
        let maskLayer = CAShapeLayer()
        let path = CGMutablePath()
        if (invert) {
            path.addRect(viewToMask.bounds)
        }
        path.addRect(maskRect)
        
        maskLayer.path = path
        if (invert) {
            maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        }
        
        // Set the mask of the view.
        viewToMask.layer.mask = maskLayer;
    }

}

