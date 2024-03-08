//
//  ARViewContainer.swift
//  SwiftUIRealityKit
//
//  Created by zhoufei on 2024/3/7.
//

import SwiftUI
import RealityKit

struct CupARViewContainer: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            CupARViewContainerView().edgesIgnoringSafeArea(.all)
            
            VStack {
                ZStack {
                    Color.black.opacity(0.3)
                    VStack {
                        Spacer()
                        Text("Tap to place a cup")
                            .font(.headline)
                            .padding(32)
                    }
                }.frame(height: 150)
                Spacer()
            }
            .ignoresSafeArea()
            
            ZStack {
                Color.white
                Text("Loading resources...")
                    .foregroundStyle(.black)
            }
            .opacity(viewModel.assetsLoaded ? 0: 1)
            .ignoresSafeArea()
            .animation(Animation.default.speed(1), value: viewModel.assetsLoaded)
        }
    }
}

struct CupARViewContainerView: UIViewRepresentable {
    @EnvironmentObject var viewModel: ViewModel
    
    func makeUIView(context: Context) -> some UIView {
        let arView = ARView(frame: .zero)
//        arView.debugOptions = [
//            .showAnchorOrigins,
//            .showAnchorGeometry
//        ]
        context.coordinator.arView = arView
        viewModel.configureSession(forView: arView)
        
        let tapRecognizer = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.viewTapped(_:)))
        arView.addGestureRecognizer(tapRecognizer)
        return arView
    }
    
    class Coordinator: NSObject {
        weak var arView: ARView?
        let parent: CupARViewContainerView
        
        init(arView: ARView? = nil, parent: CupARViewContainerView) {
            self.arView = arView
            self.parent = parent
        }
        
        @objc
        func viewTapped(_ tapGestureRecognizer: UITapGestureRecognizer) {
            let point = tapGestureRecognizer.location(in: tapGestureRecognizer.view)
            
            guard let arView = arView,
                  let result = arView.raycast(from: point, allowing: .existingPlaneGeometry, alignment: .horizontal).first,
                  let anchor = result.anchor
            else {
                return
            }
            parent.viewModel.addCup(anchor: anchor, at: result.worldTransform, in: arView)
        }
    }
    
    func makeCoordinator() -> CupARViewContainerView.Coordinator {
        return Coordinator(parent: self)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

#Preview {
    ARViewContainer()
}
