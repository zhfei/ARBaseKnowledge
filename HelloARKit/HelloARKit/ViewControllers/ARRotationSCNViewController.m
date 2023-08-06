//
//  ARRotationSCNViewController.m
//  HelloARKit
//
//  Created by zhoufei on 2023/8/6.
//

#import "ARRotationSCNViewController.h"

@interface ARRotationSCNViewController ()

@end

@implementation ARRotationSCNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
 
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.scnNode removeFromParentNode];
     
    //使用场景加载scn文件，加载3D模型
    SCNScene *scnScene = [SCNScene sceneNamed:@"Models.scnassets/art/ship.scn"];
    //获取飞机节点，所有的场景都有一个根节点，其他所有的节点都是根节点的子节点
    SCNNode *planNode = scnScene.rootNode.childNodes.firstObject;
     
    self.scnNode = planNode;
     
    //位移
    planNode.position = SCNVector3Make(0, 0, -20);
    //缩放
    planNode.scale = SCNVector3Make(0.5, 0.5, 0.5);
    planNode.position = SCNVector3Make(0, -15, -15);
    //一个3d模型是一个组合体，里面的子节点也要对应缩放
    for (SCNNode *node in planNode.childNodes) {
        node.scale = SCNVector3Make(0.5, 0.5, 0.5);
        node.position = SCNVector3Make(0, -15, -15);
    }
     
    //围绕相机旋转
    //实现方案：建一个空节点，空节点的位置和相机的位置一致，相机位置默认是世界坐标系的原点。然后让3d模型放到空节点中，让空节点旋转
    SCNNode *emptyNode = [SCNNode new];
    emptyNode.position = self.arSCNView.scene.rootNode.position;
    //将空节点添加到相机的根节点
    [self.arSCNView.scene.rootNode addChildNode:emptyNode];
    [emptyNode addChildNode:planNode];
    //旋转
    CABasicAnimation *moonRationAnimation = [CABasicAnimation animationWithKeyPath:@"rotation"];
    moonRationAnimation.duration = 30;
    moonRationAnimation.toValue = [NSValue valueWithSCNVector4:SCNVector4Make(0, 1, 0, M_PI*2)];
    moonRationAnimation.repeatCount = FLT_MAX;
    [emptyNode addAnimation:moonRationAnimation forKey:@"emptyNode"];
}

@end
