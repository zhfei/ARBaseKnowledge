//
//  ViewController.swift
//  HelloMacRealityKit
//
//  Created by zhoufei on 2023/10/22.
//

import Cocoa
import RealityKit
import RealityFoundation

class ViewController: NSViewController {
    var session: PhotogrammetrySession?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let inputUrl = URL(fileURLWithPath: "/Users/zhoufei/Desktop/FruitCakeSlice/", isDirectory: true)
        session = try! PhotogrammetrySession(input: inputUrl, configuration: PhotogrammetrySession.Configuration())
        
        // Create an async message stream dispatcher task

        Task {
            do {
                for try await output in session!.outputs {
                    switch output {
                    case .requestProgress(let request, let fraction):
                        print("Request progress: \(fraction)")
                    case .requestComplete(let request, let result):
                        if case .modelFile(let url) = result {
                            print("Request result output at \(url).")
                        }
                    case .requestError(let request, let error):
                        print("Error: \(request) error=\(error)")
                    case .processingComplete:
                        print("Completed!")
                        modalFileOutPut()
                    default:  // Or handle other messages...
                        break
                    }
                }
            } catch {
               print("Fatal session error! \(error)")
            }
        }
        
    }
    
    func modalFileOutPut() {
        try! session!.process(requests: [
            .modelFile(url: URL(filePath: "/Users/zhoufei/Desktop/Cake/model-reduced.usdz"), detail: .reduced),
            .modelFile(url: URL(filePath: "/Users/zhoufei/Desktop/Cake/model-reduced.usdz"), detail: .medium)
        ])
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

