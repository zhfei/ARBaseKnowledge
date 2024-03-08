//
//  Simple3DObjShowController.swift
//  HelloRealityKit
//
//  Created by zhoufei on 2024/1/9.
//

import UIKit
import SceneKit


class Simple3DObjShowController: UIViewController {
    
    var sceneView: SCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 创建 SceneView
        sceneView = SCNView(frame: view.bounds)
        sceneView.backgroundColor = UIColor.black
        view.addSubview(sceneView)
        
        // 创建 Scene
        let scene = SCNScene()
        
        // 创建并添加相机到 Scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 5)
        scene.rootNode.addChildNode(cameraNode)
        
        // 创建并添加灯光到 Scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = SCNLight.LightType.ambient
        lightNode.position = SCNVector3(x: 0, y: 5, z: 5)
        scene.rootNode.addChildNode(lightNode)
        
        // 加载 OBJ 模型
        if let modelNode = loadOBJModelNamed("untitled") {
            scene.rootNode.addChildNode(modelNode)
        }
        
        // 将 Scene 设置到 SceneView
        sceneView.scene = scene
        sceneView.allowsCameraControl = true
    }
    
    func loadOBJModelNamed(_ modelName: String) -> SCNNode? {
        // 获取模型文件路径
        guard let modelURL = Bundle.main.url(forResource: modelName, withExtension: "obj") else {
            return nil
        }

        // 创建 SCNSceneSource 对象
        let sceneSource = SCNSceneSource(url: modelURL, options: nil)

        // 从 SCNSceneSource 中加载模型数据
        guard let scene = sceneSource?.scene() else {
            return nil
        }

        // 获取模型的根节点
        let modelNode = scene.rootNode.childNodes.first

        // 设置贴图路径
        let textureURL = Bundle.main.url(forResource: "T_Bazooka_Mp_01_D", withExtension: "png")
        modelNode?.geometry?.firstMaterial?.diffuse.contents = UIImage(contentsOfFile: textureURL?.path ?? "")
        
        let textureURL2 = Bundle.main.url(forResource: "T_Bazooka_Mp_01_E", withExtension: "png")
        modelNode?.geometry?.firstMaterial?.emission.contents = UIImage(contentsOfFile: textureURL2?.path ?? "")
        
        let textureURL3 = Bundle.main.url(forResource: "T_Bazooka_Mp_01_M", withExtension: "png")
        modelNode?.geometry?.firstMaterial?.metalness.contents = UIImage(contentsOfFile: textureURL3?.path ?? "")
        
        let textureURL4 = Bundle.main.url(forResource: "T_Bazooka_Mp_01_N", withExtension: "png")
        modelNode?.geometry?.firstMaterial?.ambient.contents = UIImage(contentsOfFile: textureURL4?.path ?? "")

        return modelNode
    }
}

