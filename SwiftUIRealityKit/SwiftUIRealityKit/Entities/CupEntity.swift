//
//  CupEntity.swift
//  SwiftUIRealityKit
//
//  Created by zhoufei on 2024/3/7.
//

import Foundation
import Combine
import RealityKit

final class CupEntity: Entity {
    var model: Entity?
    
    static var loadAsync: AnyPublisher<CupEntity, Error> {
        return Entity.loadAsync(named: "robot_walk_idle")
            .map { loadedCup -> CupEntity in
                let cup = CupEntity()
                loadedCup.name = "Cup"
                cup.model = loadedCup
                cup.transform.scale = SIMD3<Float>(0.1,0.1,0.1)
                return cup
            }
            .eraseToAnyPublisher()
    }
}








