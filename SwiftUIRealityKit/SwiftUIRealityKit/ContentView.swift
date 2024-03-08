//
//  ContentView.swift
//  SwiftUIRealityKit
//
//  Created by zhoufei on 2024/3/7.
//

import SwiftUI
import RealityKit
import AVFoundation

struct ContentView : View {
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)

        // Create a cube model
        let mesh = MeshResource.generateBox(size: 0.1, cornerRadius: 0.005)
        let material = SimpleMaterial(color: .gray, roughness: 0.15, isMetallic: true)
        
        let model = ModelEntity(mesh: mesh, materials: [material])
        model.transform.translation.y = 0.05

        // Create horizontal plane anchor for the content
        let anchor = AnchorEntity(.plane(.vertical, classification: .any, minimumBounds: SIMD2<Float>(0.2, 0.2)))
        anchor.children.append(model)

        // Add the horizontal plane anchor to the scene
        arView.scene.anchors.append(anchor)
        
        
//        
//        let mesh1 = MeshResource.generateSphere(radius: 0.05)
//        let material1 = SimpleMaterial(color: .blue, roughness: 0.2, isMetallic: true)
//        let model1 = ModelEntity(mesh: mesh1, materials: [material1])
//        let anchor1 = AnchorEntity(AnchoringComponent.Target.plane(.horizontal, classification: .any, minimumBounds: SIMD2<Float>(0.2,0.2)))
//        anchor1.children.append(model1)
//        arView.scene.anchors.append(anchor1)
//        
//        
//        let mesh2 = MeshResource.generatePlane(width: 0.1, height: 0.1)
//        let material2 = SimpleMaterial(color: .red, isMetallic: true)
//        let model2 = ModelEntity(mesh: mesh2, materials: [material2])
//        let anchor2 = AnchorEntity(AnchoringComponent.Target.plane(.horizontal, classification: .any, minimumBounds: SIMD2<Float>(0.2,0.2)))
//        anchor2.children.append(model2)
//        arView.scene.anchors.append(anchor2)
        
        
//        let mesh3 = MeshResource.generateText("Hello World", containerFrame: CGRect(x: 0, y: 0, width: 200, height: 100))
//        let material3 = SimpleMaterial(color: .red, isMetallic: true)
//        let model3 = ModelEntity(mesh: mesh3, materials: [material3])
//        let anchor3 = AnchorEntity(AnchoringComponent.Target.plane(.vertical, classification: .any, minimumBounds: SIMD2<Float>(0.2,0.2)))
//        anchor3.children.append(model3)
//        arView.scene.anchors.append(anchor3)
        
//        let mesh3 = MeshResource.generatePlane(width: 0.2, height: 0.2)
//        let material3 = VideoMaterial(avPlayer: AVPlayer(url: NSURL(string: "http://121.199.5.39/res/video/videoplayback.mp4")! as URL))
//        let model3 = ModelEntity(mesh: mesh3, materials: [material3])
//        let anchor3 = AnchorEntity(AnchoringComponent.Target.plane(.vertical, classification: .any, minimumBounds: SIMD2<Float>(0.2,0.2)))
//        anchor3.children.append(model3)
//        arView.scene.anchors.append(anchor3)
        

        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#Preview {
    ContentView()
}
