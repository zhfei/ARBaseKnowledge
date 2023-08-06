//
//  ViewController.m
//  HelloARKit
//
//  Created by zhoufei on 2023/8/4.
//

#import "ViewController.h"
#import "ARMoveSCNViewController.h"
#import "ARRotationSCNViewController.h"
#import "ARPlanSCNViewController.h"

@interface ViewController ()
- (IBAction)arButtionAction:(UIButton *)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)arButtionAction:(UIButton *)sender {
     
    switch (sender.tag) {
        case 10:
        {
            ARPlanSCNViewController *vc = [ARPlanSCNViewController new];
            [self presentViewController:vc animated:YES completion:nil];
        }
            break;
        case 20:
        {
            ARMoveSCNViewController *vc = [ARMoveSCNViewController new];
            [self presentViewController:vc animated:YES completion:nil];
        }
            break;
        case 30:
        {
            ARRotationSCNViewController *vc = [ARRotationSCNViewController new];
            [self presentViewController:vc animated:YES completion:nil];
        }
            break;
    }
}
@end
