//
//  CupApp.swift
//  SwiftUIRealityKit
//
//  Created by zhoufei on 2024/3/7.
//

import SwiftUI

@main
struct CupApp: App {
    @Environment(\.scenePhase) var scenePhase
    
    @StateObject var viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            CupARViewContainer()
                .environmentObject(viewModel)
                .onChange(of: scenePhase) { newPhase in
                    switch newPhase {
                    case .active:
                        print("active")
                        viewModel.resume()
                    case .inactive:
                        print("inactive")
                    default:
                        break
                    }
            }
        }
    }
}

