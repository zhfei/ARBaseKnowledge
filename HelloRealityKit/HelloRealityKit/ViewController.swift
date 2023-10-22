//
//  ViewController.swift
//  HelloRealityKit
//
//  Created by zhoufei on 2023/10/22.
//

import UIKit
import RealityKit
import ARKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
//        let arV = ARView(frame: CGRectMake(0, 0, 100, 100))
//        let arSc = UIScene()
        
//        ARCamera.TrackingState.Reason
        let prevc = MyPreviewController()
        
        self.view.addSubview(prevc.view)
        self.addChild(prevc)
        
        
    }
    



}

