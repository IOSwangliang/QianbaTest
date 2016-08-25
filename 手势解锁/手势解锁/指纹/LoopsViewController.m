//
//  LoopsViewController.m
//  手势解锁
//
//  Created by Qianba on 16/8/25.
//  Copyright © 2016年 Tony. All rights reserved.
//

#import "LoopsViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface LoopsViewController ()
{
    int cout;
}
@property (weak, nonatomic) IBOutlet UILabel *myLabel;

@end

@implementation LoopsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)buttonAction:(UIButton *)sender {
    [self CreateFingerPrint];
    self.myLabel.text = @"";
}

- (void)CreateFingerPrint {
    LAContext *lac = [[LAContext alloc] init];
    BOOL isSupport = [lac canEvaluatePolicy:kLAPolicyDeviceOwnerAuthenticationWithBiometrics
                                      error:NULL];
    lac.localizedFallbackTitle = NSLocalizedString(@"密码输入", nil);
    if (isSupport) {
        [lac  evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"Please print your finger" reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(printInfomation:) userInfo:nil repeats:YES];
                });
                //                NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(printInfomation:) userInfo:nil repeats:YES];
                //                //while (cout >= 0) {
                //                [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
                //                [[NSRunLoop currentRunLoop] run];
                // }
            }
            else {
                NSLog(@"ddddddd--%@--%@",error,[error localizedDescription]);
            }
        }];
    }
}

- (void)printInfomation:(NSTimer *)timer {
    NSString * str = @"恭喜您验证成功！";
    if (cout > str.length - 1) {
        [timer invalidate];
        [self performSelector:@selector(timerInvalidate) onThread:[NSThread mainThread] withObject:nil waitUntilDone:NO];
        return;
    }
    NSString *subStr = [str substringWithRange:NSMakeRange(0, 1+cout)];
    cout++;
    self.myLabel.text = subStr;
}

- (void)timerInvalidate {
    cout = -1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  typedef NS_ENUM(NSInteger, LAError)
 {
 //授权失败
 LAErrorAuthenticationFailed = kLAErrorAuthenticationFailed,
 
 //用户取消Touch ID授权
 LAErrorUserCancel           = kLAErrorUserCancel,
 
 //用户选择输入密码
 LAErrorUserFallback         = kLAErrorUserFallback,
 
 //系统取消授权(例如其他APP切入)
 LAErrorSystemCancel         = kLAErrorSystemCancel,
 
 //系统未设置密码
 LAErrorPasscodeNotSet       = kLAErrorPasscodeNotSet,
 
 //设备Touch ID不可用，例如未打开
 LAErrorTouchIDNotAvailable  = kLAErrorTouchIDNotAvailable,
 
 //设备Touch ID不可用，用户未录入
 LAErrorTouchIDNotEnrolled   = kLAErrorTouchIDNotEnrolled,
 } NS_ENUM_AVAILABLE(10_10, 8_0);
 */

@end
