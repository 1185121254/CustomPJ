//
//  RegistViewController.m
//  CustomPJ
//
//  Created by chaojie on 2017/6/6.
//  Copyright © 2017年 chaojie. All rights reserved.
//

#import "RegistViewController.h"

@interface RegistViewController ()
{
    NSMutableArray *_arr;
}

@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *pswTF;

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"register";
    
    if ([[NSFileManager defaultManager]fileExistsAtPath:[self getFilePath]]) {
        
        _arr = [NSKeyedUnarchiver unarchiveObjectWithFile:[self getFilePath]];
        
    }else{
        
        _arr = [[NSMutableArray alloc]initWithCapacity:0];
    }
    
    NSLog(@"--%@",NSHomeDirectory());
    
}
- (IBAction)registBtnClick:(id)sender {
    
    if (_nameTF.text.length <=0 || _pswTF.text.length <=0) {
        
        [self createAlertView:@"The user name and password cannot be empty"];
        return;
    }
    for (People *p in _arr) {
        
        if ([p.name isEqualToString:_nameTF.text]) {
            
            [self createAlertView:@"Already on the account"];
            return;
        }
    }
    
    People *newUser = [[People alloc]init];
    newUser.name = _nameTF.text;
    newUser.psw = _pswTF.text;
    [_arr addObject:newUser];
    [self createAlertView:@"Registered successfully"];
    [NSKeyedArchiver archiveRootObject:_arr toFile:[self getFilePath]];
    
    if ([_delegate respondsToSelector:@selector(ChangeContent:)]) {
        
        [_delegate ChangeContent:_nameTF.text];

    }
    [self.navigationController popViewControllerAnimated:YES];

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
