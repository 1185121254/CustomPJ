//
//  LoginViewController.m
//  CustomPJ
//
//  Created by chaojie on 2017/6/6.
//  Copyright © 2017年 chaojie. All rights reserved.
//

#import "LoginViewController.h"
#import "MBProgressHUD.h"


@interface LoginViewController ()<RegisterControllerDelegate,UITextFieldDelegate>
{
    NSMutableArray *_dataArray;
}

@property (weak, nonatomic) IBOutlet UITextField *nameTF;

@property (weak, nonatomic) IBOutlet UITextField *pswTF;

@end

@implementation LoginViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if ([[NSFileManager defaultManager]fileExistsAtPath:[self getFilePath]]) {
        
        _dataArray = [NSKeyedUnarchiver unarchiveObjectWithFile:[self getFilePath]];
    }
    
    _nameTF.returnKeyType = UIReturnKeyNext;
    
    _pswTF.returnKeyType = UIReturnKeyNext;

    [_nameTF becomeFirstResponder];
    _nameTF.delegate = self;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"login";
    
    //[_nameTF resignFirstResponder];
    
    }
-(void)ChangeContent:(NSString *)aName{
    
    _nameTF.text = aName;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    if ([_nameTF isFirstResponder]) {

        [_pswTF becomeFirstResponder];
        
    }else if([_pswTF isFirstResponder]){
        
        [_nameTF resignFirstResponder];
    }
    return YES;
}
- (IBAction)LoginBtnClick:(id)sender {
    
    if ([_nameTF.text isEqualToString:@""]) {
        [self addUIAlertCcontroller:@"name no can nil"];
        
    }
    if ([_pswTF.text isEqualToString:@""]) {
        [self addUIAlertCcontroller:@"psw no can nil"];
    }
    
    
    BOOL isOK = NO;
    for (People *p in _dataArray) {
        
        if ([p.name isEqualToString:_nameTF.text]) {
            
            isOK = YES;
            
            if ([p.psw isEqualToString:_pswTF.text]) {
                
                
                //                [self createAlertView:@"登录成功"];
                
                MainViewController *main = [[MainViewController alloc] init];
                UINavigationController *mainNAV = [[UINavigationController alloc]initWithRootViewController:main];
                
                SettingViewController *set = [[SettingViewController alloc] init];
                UINavigationController *setNAV = [[UINavigationController alloc]initWithRootViewController:set];
                
                MyViewController *my = [[MyViewController alloc] init];
                UINavigationController *myNAV = [[UINavigationController alloc]initWithRootViewController:my];
                
                MessageViewController *message = [[MessageViewController alloc] init];
                UINavigationController *messageNAV = [[UINavigationController alloc]initWithRootViewController:message];
                
                
                //设置底部tabbar
                UITabBarController *tab = [[UITabBarController alloc] init];
                tab.viewControllers = @[mainNAV,setNAV,myNAV,messageNAV];
                
                UITabBar *tabBar = tab.tabBar;
                
                UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
                UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
                UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
                UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:3];
                tabBarItem1.title=@"用户";
                tabBarItem1.image=[UIImage imageNamed:@"github60"];
                
                tabBarItem2.title=@"设置";
                tabBarItem2.image=[UIImage imageNamed:@"github160"];
                
                tabBarItem3.title=@"我的";
                tabBarItem3.image=[UIImage imageNamed:@"github60"];
                
                tabBarItem4.title=@"信息";
                tabBarItem4.image=[UIImage imageNamed:@"more"];
                
                
                //设置选中的tabitem，也可以使用selectedViewController
                //    tab.selectedIndex = 2;
                
                UIWindow *keyWindow = [[UIApplication sharedApplication]keyWindow];
                keyWindow.rootViewController = tab;
                
            }else{
                
                [self createAlertView:@"Password mistake"];
            }
            return;
        }
    }
    if (isOK == NO) {
        
        [self createAlertView:@"The user does not exist"];
    }
}


- (IBAction)registBtnClick:(id)sender {
    
    RegistViewController *registVC = [[RegistViewController alloc]init];
    registVC.delegate = self;
    [self.navigationController pushViewController:registVC animated:YES];
    
}

- (IBAction)WeiXinChat:(id)sender {
}

-(void)createAlertView:(NSString *)msg{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Quit"
                                                                             message:msg
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    //添加确定到UIAlertController中
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"sure" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Quit");
    }];
    [alertController addAction:OKAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}
-(NSString *)getFilePath{
    
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/arr.plist"];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}
-(void)logoff{
    
    _nameTF.text = [[NSString alloc]initWithString:@""];
    _pswTF.text = [[NSString alloc]initWithString:@""];
}
-(void)addUIAlertCcontroller:(NSString *)msg{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"prompt" message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okSure = [UIAlertAction actionWithTitle:@"sure" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertVC addAction:okSure];
    
    [self presentViewController:alertVC animated:YES completion:nil];
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
