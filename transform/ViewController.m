//
//  ViewController.m
//  transform
//
//  Created by wupeng on 2017/2/16.
//  Copyright © 2017年 wupeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *bgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupUI];
}

- (void)setupUI {
    self.bgView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.bgView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.bgView];
    
    UIButton *first = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    UIButton *second = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 50)];
    first.backgroundColor = [UIColor blackColor];
    second.backgroundColor = [UIColor redColor];
    [first addTarget:self action:@selector(firstEvent) forControlEvents:UIControlEventTouchUpInside];
    [second addTarget:self action:@selector(secondEvent) forControlEvents:UIControlEventTouchUpInside];

    
    [self.bgView addSubview:first];
    [self.bgView addSubview:second];
}

- (void)firstEvent {
    NSLog(@"first");
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.bgView.layer.zPosition = -400;
        [self.bgView.layer setTransform:[self firstTransform]];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self.bgView.layer setTransform:[self secondTransform]];
        } completion:^(BOOL finished) {
            
        }];
    }];
}

- (void)secondEvent {
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.bgView.layer.zPosition = -400;
        [self.bgView.layer setTransform:[self firstTransform]];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self.bgView.layer setTransform:CATransform3DIdentity];
        } completion:^(BOOL finished) {
            
        }];
    }];
}

- (CATransform3D )firstTransform {
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 1.0/ -700;
    transform = CATransform3DScale(transform, 0.95, 0.95, 1);
    transform = CATransform3DRotate(transform, 15.0 * M_PI / 180.0 , 1, 0, 0);
    return transform;
}

- (CATransform3D )secondTransform {
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = [self firstTransform].m34;
    transform = CATransform3DTranslate(transform, 0, -20 , 0);
    transform = CATransform3DScale(transform, 0.8, 0.8, 1);
    return transform;
}

@end
