//
//  ViewModel.swift
//  SwiftUIRealityKit
//
//  Created by zhoufei on 2024/3/7.
//

import Foundation
import Combine
import ARKit
import RealityKit

final class ViewModel: NSObject, ObservableObject {
    private static let loadBuffer: TimeInterval = 2
    
    private let resourceLoader = ResourceLoader()
    private var loadCanclellable: AnyCancellable?
    private var anchors = [UUID: AnchorEntity]()
    
    @Published var assetsLoaded = false
    
    func configureSession(forView arView: ARView) {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        arView.session.run(config)
        arView.session.delegate = self
    }
    
    func resume() {
        if !assetsLoaded && loadCanclellable == nil {
            loadAssets()
        }
    }
    
    func pause() {
        loadCanclellable?.cancel()
        loadCanclellable = nil
    }
    
    private func loadAssets() {
        let beforTime = Date().timeIntervalSince1970
        loadCanclellable = resourceLoader.loadResources(complete: { [weak self] result in
            guard let weakSelf = self else { return  }
            
            switch result {
            case let .failure(error):
                print("加载模型失败:\(error.localizedDescription)")
            case .success:
                let delta = Date().timeIntervalSince1970 - beforTime
                var buffer = Self.loadBuffer - delta
                if buffer < 0 {
                    buffer = 0
                }
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + buffer, execute: {
                    self?.assetsLoaded = true
                })
            }
            
        })
    }
    
    func addCup(anchor: ARAnchor, at worldTransfrom: simd_float4x4, in view: ARView) {
        let cup: Entity
        do {
            cup = try resourceLoader.createCup()
        } catch let error {
            print(error.localizedDescription)
            return
        }
        
        defer {
            let column = worldTransfrom.columns.3
            let translation = SIMD3<Float>(column.x, column.y, column.z)
            cup.setPosition(translation, relativeTo: nil)
        }
        
        guard let anchorEntity = anchors[anchor.identifier] else {
            let anchorEntity = AnchorEntity(world: anchor.transform)
            anchorEntity.addChild(cup)
            view.scene.addAnchor(anchorEntity)
            anchors[anchor.identifier] = anchorEntity
            return
        }
        
        anchorEntity.addChild(cup)
    }
}

extension ViewModel: ARSessionDelegate {
    func session(_ session: ARSession, didRemove anchors: [ARAnchor]) {
        anchors.forEach { anchor in
            guard let anchorEntity = self.anchors[anchor.identifier] else {
                return
            }
            
            anchorEntity.scene?.removeAnchor(anchorEntity)
            self.anchors.removeValue(forKey: anchor.identifier)
        }
    }
}

