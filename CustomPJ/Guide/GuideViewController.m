//
//  GuideViewController.m
//  HuaxiaDotor
//
//  Created by ydz on 16/7/4.
//  Copyright © 2016年 kock. All rights reserved.
//

#import "GuideViewController.h"
#import "MainViewController.h"

@interface GuideViewController ()<UIScrollViewDelegate>

{
    UIScrollView *_scroll;
}

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    float width = [UIScreen mainScreen].bounds.size.width;
    float height  = [UIScreen mainScreen].bounds.size.height;
    
    _scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    _scroll.delegate = self;
    [self.view addSubview:_scroll];
    _scroll.pagingEnabled = YES;
    _scroll.contentSize = CGSizeMake(width*3, height);
    
    NSArray *arr = [[NSArray alloc]initWithObjects:@"1.jpg",@"3.jpg",@"2.jpg", nil];
    
    for (NSInteger i = 0; i<3; i++) {
        
        UIImageView *image = [[UIImageView alloc]init];
        image.contentMode = UIViewContentModeScaleAspectFit;
        image.frame = CGRectMake(width*i, 0, width, height);
        image.image = [UIImage imageNamed:arr[i]];
        image.userInteractionEnabled = YES;
        [_scroll addSubview:image];
        
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(20, height-60, width-40, 40);
                [btn setTitle:@"进入" forState:UIControlStateNormal];
                btn.backgroundColor = [UIColor redColor];
                [btn addTarget:self action:@selector(onBtnGoHome) forControlEvents:UIControlEventTouchUpInside];
                if (i == 2) {
                    btn.hidden = NO;
                }else
                {
                    btn.hidden = YES;
                }
                [image addSubview:btn];
    }
}

-(void)onBtnGoHome{
    
    self.view.window.backgroundColor = [UIColor whiteColor];
    float width = [UIScreen mainScreen].bounds.size.width;
    float heigh = [UIScreen mainScreen].bounds.size.height;
   
    
//    MainViewController *main = [[MainViewController alloc] init];
//    UINavigationController *mainNAV = [[UINavigationController alloc]initWithRootViewController:main];
//    
//    SettingViewController *set = [[SettingViewController alloc] init];
//    UINavigationController *setNAV = [[UINavigationController alloc]initWithRootViewController:set];
//    
//    MyViewController *my = [[MyViewController alloc] init];
//    UINavigationController *myNAV = [[UINavigationController alloc]initWithRootViewController:my];
//    
//    MessageViewController *message = [[MessageViewController alloc] init];
//    UINavigationController *messageNAV = [[UINavigationController alloc]initWithRootViewController:message];
//    
//    
//    //设置底部tabbar
//    UITabBarController *tab = [[UITabBarController alloc] init];
//    tab.viewControllers = @[mainNAV,setNAV,myNAV,messageNAV];
//    
//    UITabBar *tabBar = tab.tabBar;
//    
//    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
//    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
//    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
//    UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:3];
//    tabBarItem1.title=@"用户";
//    tabBarItem1.image=[UIImage imageNamed:@"github60"];
//    
//    tabBarItem2.title=@"设置";
//    tabBarItem2.image=[UIImage imageNamed:@"github160"];
//    
//    tabBarItem3.title=@"信息";
//    tabBarItem3.image=[UIImage imageNamed:@"github60"];
//    
//    tabBarItem4.title=@"我的";
//    tabBarItem4.image=[UIImage imageNamed:@"more"];
    

    
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginVC];
    
    
    CABasicAnimation *anima=[CABasicAnimation animation];
    anima.keyPath=@"position";
    anima.fromValue=[NSValue valueWithCGPoint:CGPointMake(width+width/2, heigh/2)];
    anima.toValue=[NSValue valueWithCGPoint:CGPointMake(width/2, heigh/2)];
    anima.removedOnCompletion=NO;
    anima.fillMode=kCAFillModeForwards;
    anima.duration = 0.2;
    [nav.view.layer addAnimation:anima forKey:nil];
    self.view.window.rootViewController = nav;
    

    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
//    self.view.window.backgroundColor = [UIColor whiteColor];
//    float width = [UIScreen mainScreen].bounds.size.width;
//    float heigh = [UIScreen mainScreen].bounds.size.height;
//    if (scrollView.contentOffset.x > width*2) {
//        
//        MainViewController *MainVC=[[MainViewController alloc]init];;
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:MainVC];
//        [nav.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
//        nav.navigationBar.tintColor = [UIColor whiteColor];
//        [[UIBarButtonItem appearance]
//         setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
//        
//        
//        CABasicAnimation *anima=[CABasicAnimation animation];
//        anima.keyPath=@"position";
//        anima.fromValue=[NSValue valueWithCGPoint:CGPointMake(width+width/2, heigh/2)];
//        anima.toValue=[NSValue valueWithCGPoint:CGPointMake(width/2, heigh/2)];
//        anima.removedOnCompletion=NO;
//        anima.fillMode=kCAFillModeForwards;
//        anima.duration = 0.2;
//        [nav.view.layer addAnimation:anima forKey:nil];
//        self.view.window.rootViewController = nav;
    
        //        [UIView animateWithDuration:1 animations:^{
        //
        //        } completion:^(BOOL finished) {
        //
        //            [UIView transitionWithView:self.view.window duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:nil completion:nil];
        //            self.view.window.rootViewController = nav;
        //
        //        }];
        
        //        CATransition *transition = [CATransition animation];
        //        transition.duration = 1;
        //        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
        //        transition.type = kCATransitionFade;
        //        [nav.view.layer addAnimation:transition forKey:nil];
//    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
