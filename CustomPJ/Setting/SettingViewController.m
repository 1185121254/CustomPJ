//
//  SettingViewController.m
//  CustomPJ
//
//  Created by chaojie on 2017/6/1.
//  Copyright © 2017年 chaojie. All rights reserved.
//

#import "SettingViewController.h"

static NSString *str = @"cell";
@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray *arrData
;
@end

@implementation SettingViewController

-(NSMutableArray *)arrData{
    
    if (_arrData == nil) {
        _arrData = [[NSMutableArray alloc]initWithObjects:@"退出", nil];
    }
    
    return _arrData;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"设置";

    
    _tableView.rowHeight = 60;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
    }
    
    cell.textLabel.text = _arrData[indexPath.row];
    
    cell.detailTextLabel.text = @">";
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self addUIAlertView:@"are you sure log off ?"];
    
}
-(void)addUIAlertView:(NSString *)msg{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"are you sure" message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okSure = [UIAlertAction actionWithTitle:@"sure" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self offlog];
        
        
    }];
    
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertVC addAction:cancel];
    [alertVC addAction:okSure];
    [self presentViewController:alertVC animated:YES completion:nil];
    
}
-(void)offlog{
    
    NSString *credfile = [NSHomeDirectory() stringByAppendingPathComponent:@"Document/plist"];
    NSFileManager *filemaagewr = [NSFileManager defaultManager];
    [filemaagewr removeItemAtPath:credfile error:nil];
    [self.view removeFromSuperview];
    UITabBarController *tabbarVC = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
//    UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    LoginViewController *login = [[LoginViewController alloc]init];
    [tabbarVC.navigationController pushViewController:login animated:YES];
    
    [login logoff];
    
    
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
