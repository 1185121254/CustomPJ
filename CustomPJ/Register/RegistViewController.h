//
//  RegistViewController.h
//  CustomPJ
//
//  Created by chaojie on 2017/6/6.
//  Copyright © 2017年 chaojie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistViewController : UIViewController

@property(nonatomic,weak)id delegate;

@end

@protocol RegisterControllerDelegate <NSObject>

-(void)ChangeContent:(NSString *)aName;

@end
