//
//  ARSCNViewController.h
//  HelloARKit
//
//  Created by zhoufei on 2023/8/6.
//

#import <UIKit/UIKit.h>
#import <ARKit/ARKit.h>
#import <SceneKit/SceneKit.h>

@interface ARSCNViewController : UIViewController
//AR容器视图：展示3D界面，内部会自动创建screen场景和ARCarmer摄像头
@property (nonatomic, strong) ARSCNView *arSCNView;
//AR会话：AR的开启和关闭
@property (nonatomic, strong) ARSession *arSession;
//AR世界追踪配置
@property (nonatomic, strong) ARConfiguration *arConfiguration;
//场景节点：3D模型
@property (nonatomic, strong) SCNNode *scnNode;
@end


