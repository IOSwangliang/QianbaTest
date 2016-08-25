//
//  ViewController.m
//  手势解锁
//
//  Created by Tony on 16/1/9.
//  Copyright © 2016年 Tony. All rights reserved.
//

#import "ViewController.h"
#import "ZSBntview.h"
#import "HomeViewController.h"

@interface ViewController ()<ZSBntviewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet ZSBntview *bntview;
@property (weak, nonatomic) IBOutlet UILabel *Prompt;

@property (nonatomic) int judge;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _judge=0;
    self.title=@"手势解锁";
     _Prompt.text=[NSString stringWithFormat:@"您有4次机会"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Home_refresh_bg"]];
    self.bntview.delegate = self;
    
}

//实现代理方法
-(void)zsbntview:(ZSBntview *)bntview :(NSString *)strM{
    //开启一个图形上下文
    UIGraphicsBeginImageContextWithOptions(bntview.frame.size, NO, 0.0);
    //获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //截图
    [self.bntview.layer renderInContext:ctx];
    //获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图形上下文
    UIGraphicsEndImageContext();
    //把获取的图片保存到 imageview 中
    self.imageview.image = image;
    
    if (strM.length>=4) {
        //记录一次
        _judge++;
        
       
        
        
        
        //如果大于一个数 超过了
        if (_judge>3) {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"机会用完"
                                                           delegate:nil
                                                  cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
            _Prompt.text=[NSString stringWithFormat:@"您没有机会了"];
            
        }else{
            /**
             *  判断对错 页面跳转  文本提示  ====逻辑写
             */
            
            
            if ([strM isEqualToString:@"1456"]) {
                //密码正确
                HomeViewController *home=[[HomeViewController alloc]init];
                
                [self.navigationController pushViewController:home animated:YES];
            }else{
            
            int i =4-_judge;
            
            if (i>0) {
                
                
               
                
                
                _Prompt.text=[NSString stringWithFormat:@"您还有%d次机会",i];
                
            }
           
            }
            
          
            
        
        }
        
        
    }else{
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"输入4位以上"
                                                       delegate:nil
                                              cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    
    }
    
    NSLog(@"%@======",strM);
    
}
//隐藏状态栏
-(BOOL)prefersStatusBarHidden{
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
