//
//  ResourceLoader.swift
//  SwiftUIRealityKit
//
//  Created by zhoufei on 2024/3/7.
//

import Foundation
import Combine
import RealityKit

class ResourceLoader {
    enum ResourceLoaderError: Error {
        case resourceNotLoaded
    }
    
    typealias LoadCompletion = (Result<CupEntity, Error>) -> Void
    
    private var loadCancellabel: AnyCancellable?
    private var cupEntity: CupEntity?
    
    func loadResources(complete: @escaping LoadCompletion) -> AnyCancellable? {
        guard let cupEntity = cupEntity else {
            //sink订阅方法返回了一个订阅引用，这个订阅引用在对象销毁时自动执行cancle()取消订阅方法。
            loadCancellabel = CupEntity.loadAsync.sink(receiveCompletion: { result in
                if case let .failure(error) = result {
                    print("Failed to Load")
                    complete(.failure(error))
                }
            }, receiveValue: { [weak self] cupEntity in
                guard let weakSelf = self else { return }
                self?.cupEntity = cupEntity
                complete(.success(cupEntity))
            })
            
            return loadCancellabel
        }
        
        complete(.success(cupEntity))
        return loadCancellabel
    }
    
    func createCup() throws -> Entity {
        guard let cup = cupEntity?.model else {
            throw ResourceLoaderError.resourceNotLoaded
        }
        return cup.clone(recursive: true)
    }
}

