//
//  Simple3DShowController.swift
//  HelloRealityKit
//
//  Created by zhoufei on 2023/10/22.
//

import UIKit
import SceneKit


class Simple3DShowController: UIViewController {
    var sceneView: SCNView!
    var scene: SCNScene!
    
    // MARK: - Life Cycle
    init() {
        super.init(nibName: nil, bundle: nil)
        self.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 创建一个SceneKit视图
         sceneView = SCNView(frame: CGRectMake(0, 0, 200, 200))
         self.view.addSubview(sceneView)

         // 创建一个SceneKit场景
         scene = SCNScene()

         // 创建一个3D模型
         if let modelScene = SCNScene(named: "AirForce.usdz") {
             let modelNode = modelScene.rootNode
             scene.rootNode.addChildNode(modelNode)
         }

         // 设置场景到视图
         sceneView.scene = scene

         // 允许用户旋转查看模型
         sceneView.allowsCameraControl = true
    }
    
    // MARK: - Private Method
    
    // MARK: - Public Method
    
    // MARK: - Event
    
}





