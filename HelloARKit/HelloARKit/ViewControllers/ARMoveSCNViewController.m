//
//  ARMoveSCNViewController.m
//  HelloARKit
//
//  Created by zhoufei on 2023/8/6.
//

#import "ARMoveSCNViewController.h"

@implementation ARMoveSCNViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
 
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //使用场景加载scn文件，加载3D模型
    SCNScene *scnScene = [SCNScene sceneNamed:@"Models.scnassets/art/ship.scn"];
    //获取飞机节点，所有的场景都有一个根节点，其他所有的节点都是根节点的子节点
    SCNNode *planNode = scnScene.rootNode.childNodes.firstObject;
     
    self.scnNode = planNode;
     
    //加灯光
    SCNNode *lightNode = [SCNNode node];
    lightNode.light = [SCNLight light];
    lightNode.light.type = SCNLightTypeOmni;
    lightNode.position = SCNVector3Make(0, 1, 1);
     
    //planNode节点默认加载的位置是世界坐标的原点(0,0,0)，在加载到场景时可以设置它在时间坐标系中的位置。
//    planNode.position = SCNVector3Make(0, -1, -1);
     
    //将飞机节点添加到当前屏幕中(主场景中)
    [self.arSCNView.scene.rootNode addChildNode:planNode];
    [self.arSCNView.scene.rootNode addChildNode:lightNode];
}
 
#pragma mark -ARSessionDelegate
 
//会话位置更新（监听相机的移动），此代理方法会调用非常频繁，只要相机移动就会调用，如果相机移动过快，会有一定的误差，具体的需要强大的算法去优化，笔者这里就不深入了
- (void)session:(ARSession *)session didUpdateFrame:(ARFrame *)frame
{
    NSLog(@"相机移动");
    if (self.scnNode) {
        //捕捉相机的位置，让节点随相机的移动而移动
        self.scnNode.position = SCNVector3Make(frame.camera.transform.columns[3].x, frame.camera.transform.columns[3].y, frame.camera.transform.columns[3].z);
    }
     
}
- (void)session:(ARSession *)session didAddAnchors:(NSArray<ARAnchor*>*)anchors
{
    NSLog(@"添加锚点");
     
}
 
 
- (void)session:(ARSession *)session didUpdateAnchors:(NSArray<ARAnchor*>*)anchors
{
    NSLog(@"刷新锚点");
     
}
@end
