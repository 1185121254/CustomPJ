//
//  LocationViewController.h
//  CustomPJ
//
//  Created by chaojie on 2017/6/6.
//  Copyright © 2017年 chaojie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReturnCityName)(NSString *cityname);

@interface LocationViewController : UIViewController

@property (nonatomic, copy) ReturnCityName returnBlock;

- (void)returnText:(ReturnCityName)block;
