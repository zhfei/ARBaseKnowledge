//
//  ARSCNViewController.m
//  HelloARKit
//
//  Created by zhoufei on 2023/8/6.
//

#import "ARSCNViewController.h"


@interface ARSCNViewController () <ARSCNViewDelegate,ARSessionDelegate>

@end

@implementation ARSCNViewController

#pragma mark - Life Cycle
 
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
 
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
     
    [self.view addSubview:self.arSCNView];
    //启动AR会话，ARCarmer开始启动
    [self.arSession runWithConfiguration:self.arConfiguration];
}
 
#pragma mark - Private Method
 
// MARK: overwrite
 
#pragma mark - Public Method
 
#pragma mark - Event
 
#pragma mark - Delegate
 
 
 
#pragma mark - Getter, Setter
- (ARSCNView *)arSCNView {
    if (!_arSCNView) {
        _arSCNView = [[ARSCNView alloc] initWithFrame:self.view.bounds];
        _arSCNView.session = self.arSession;
        _arSCNView.delegate = self;
        _arSCNView.automaticallyUpdatesLighting = YES;
    }
    return _arSCNView;
}
 
- (ARSession *)arSession {
    if (!_arSession){
        _arSession = [ARSession new];
        _arSession.delegate = self;
    }
    return _arSession;
}
 
- (ARConfiguration *)arConfiguration {
    if (!_arConfiguration) {
        ARWorldTrackingConfiguration *wtConfiguration = [ARWorldTrackingConfiguration new];
        //平面追踪
        wtConfiguration.planeDetection = ARPlaneDetectionHorizontal;
        //灯光自适应
        wtConfiguration.lightEstimationEnabled = YES;
        _arConfiguration = wtConfiguration;
    }
    return _arConfiguration;
}
 
#pragma mark - NSCopying
 
#pragma mark - NSObject

@end
