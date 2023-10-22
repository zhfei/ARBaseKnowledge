//
//  MyPreviewController.swift
//  HelloRealityKit
//
//  Created by zhoufei on 2023/10/22.
//

import UIKit
import ARKit

class MyPreviewController: UIViewController, QLPreviewControllerDataSource, QLPreviewItem {
    var previewItemURL: URL?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        presentARQuickLook()
    }
    
    func presentARQuickLook() {
        previewItemURL = getPreviewItem(withName: "AirForce.usdz")
        let previewController = QLPreviewController()
        previewController.dataSource = self
        present(previewController, animated: true)
    }
    
    func getPreviewItem(withName name:String) -> URL {
        let file = name.components(separatedBy: ".")
        let path = Bundle.main.path(forResource: file.first, ofType: file.last)
        let url = URL(fileURLWithPath: path!)
        
        return url
    }
}

extension MyPreviewController {
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        self as QLPreviewItem
    }
}


