//
//  ARPlanSCNViewController.m
//  HelloARKit
//
//  Created by zhoufei on 2023/8/6.
//

#import "ARPlanSCNViewController.h"

@interface ARPlanSCNViewController ()

@end

@implementation ARPlanSCNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
 
#pragma mark - Delegate
//ARSCNViewDelegate
//添加节点时候调用（当开启平面捕捉模式时，如果捕捉到了平面，ARKit会自动添加一个平面节点）
- (void)renderer:(id<SCNSceneRenderer>)renderer didAddNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
     
    NSLog(@"%@",anchor);
     
    if ([anchor isKindOfClass:[ARPlaneAnchor class]]) {
        //ARKit捕捉的平面anchor只是一个空间位置，要想清楚看到这个位置需要添加一个3D模型
         
        //1.获取捕捉的平面锚点
        ARPlaneAnchor *planAnchor = (ARPlaneAnchor *)anchor;
        //2.创建一个3D模型,高度为0的Box模型
        SCNBox *plane = [SCNBox boxWithWidth:planAnchor.extent.x * 0.3 height:0 length:planAnchor.extent.x * 0.3 chamferRadius:0];
        //3.使用Material渲染3D模型（模型设置成了红色）
        plane.firstMaterial.diffuse.contents = [UIColor redColor];
         
        //4.创建一个基于3D模型的节点
        SCNNode *planeNode = [SCNNode nodeWithGeometry:plane];
        planeNode.position = SCNVector3Make(planAnchor.center.x, 0, planAnchor.center.z);
         
        [node addChildNode:planeNode];
         
         
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            //1.根据scn模型文件创建一个场景
//            SCNScene *treeScene = [SCNScene sceneNamed:@"Models.scnassets/tree/baby_groot.scn"];
//            //2.获取gameObject对象节点，所有的场景就一个根节点，其他节点都在这个根节点中
//            SCNNode *treeNode = treeScene.rootNode.childNodes[0];
             
//            NSURL *scnUrl = [NSBundle.mainBundle URLForResource:@"baby_groot" withExtension:@"scn"];
             
             
             
            //通过加载资源的方式加载3d模型
            NSURL *scnUrl = [NSBundle.mainBundle URLForResource:@"Models.scnassets/dea/baby_groot" withExtension:@"dae"];
 
            SCNReferenceNode *treeNode = [SCNReferenceNode referenceNodeWithURL:scnUrl];
            [treeNode load];
             
            //给节点添加动画
            SCNAction *treeAction = [SCNAction repeatActionForever:[SCNAction rotateByX:0 y:1 z:0 duration:1]];
            [treeNode runAction:treeAction];
             
            //3.将模型的位置设置到捕获平面的位置上
            treeNode.position = SCNVector3Make(planAnchor.center.x, 0, planAnchor.center.z);
            //4.将模型节点添加到捕获的的平面节点上
            [planeNode addChildNode:treeNode];
        });
         
    }
}
 
 
//刷新时调用
- (void)renderer:(id <SCNSceneRenderer>)renderer willUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor
{
    NSLog(@"刷新中");
}
 
//更新节点时调用
- (void)renderer:(id <SCNSceneRenderer>)renderer didUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor
{
    NSLog(@"节点更新");
     
}
 
//移除节点时调用
- (void)renderer:(id <SCNSceneRenderer>)renderer didRemoveNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor
{
    NSLog(@"节点移除");
}
 

@end
