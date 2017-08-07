//
//  MainViewController.m
//  CustomPJ
//
//  Created by chaojie on 2017/6/1.
//  Copyright © 2017年 chaojie. All rights reserved.
//

#import "MainViewController.h"


#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface MainViewController ()<UIScrollViewDelegate>
{
    
    NSTimer *_timer;
}
@property(nonatomic,strong)UIPageControl *pageCTL;
@property(nonatomic,strong)UIImageView *imageView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"用户";
    
    
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc]initWithTitle:@"location" style:UIBarButtonItemStylePlain target:self action:@selector(locationBtnClick:)];
    self.navigationItem.leftBarButtonItem = leftBar;
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithTitle:@"search" style:UIBarButtonItemStylePlain target:self action:@selector(searchBtnClick:)];
    self.navigationItem.rightBarButtonItem = rightBar;

    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    scrollView.contentSize = CGSizeMake(_imageView.frame.size.width*3, _imageView.frame.size.height);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    scrollView.tag = 1000;


    
    NSArray *arr = [[NSArray alloc]initWithObjects:@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg", nil];
    for (int i = 0; i< 4; i++) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth*i, 0, scrollView.frame.size.width, scrollView.frame.size.height)];
        _imageView.tag = 1000+i;
        _imageView.image = [UIImage imageNamed:arr[i]];
        
      
        [scrollView addSubview:_imageView];
    }
    
    
    [self.view addSubview:scrollView];

    
    _pageCTL = [[UIPageControl alloc] initWithFrame:CGRectMake(0, scrollView.frame.size.height-50, scrollView.frame.size.width, 50)];
    _pageCTL.numberOfPages = 4;
    _pageCTL.currentPage = 0;
    [self.view addSubview:_pageCTL];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(changeView) userInfo:nil repeats:YES];
}

//定时器的回调方法   切换界面
- (void)changeView{
    //得到scrollView
    UIScrollView *scrollView = [self.view viewWithTag:1000];
    //通过改变contentOffset来切换滚动视图的子界面
    float offset_X = scrollView.contentOffset.x;
    //每次切换一个屏幕
    offset_X += CGRectGetWidth(self.view.frame);
    
    //说明要从最右边的多余视图开始滚动了，最右边的多余视图实际上就是第一个视图。所以偏移量需要更改为第一个视图的偏移量。
    if (offset_X > CGRectGetWidth(self.view.frame)*4) {
        scrollView.contentOffset = CGPointMake(0, 0);
        
    }
    //说明正在显示的就是最右边的多余视图，最右边的多余视图实际上就是第一个视图。所以pageControl的小白点需要在第一个视图的位置。
    if (offset_X == CGRectGetWidth(self.view.frame)*4) {
        _pageCTL.currentPage = 0;
    }else{
        _pageCTL.currentPage = offset_X/CGRectGetWidth(self.view.frame);
    }
    
    //得到最终的偏移量
    CGPoint resultPoint = CGPointMake(offset_X, 0);
    //切换视图时带动画效果
    //最右边的多余视图实际上就是第一个视图，现在是要从第一个视图向第二个视图偏移，所以偏移量为一个屏幕宽度
    if (offset_X > CGRectGetWidth(self.view.frame)*4) {
        _pageCTL.currentPage = 0;
        [scrollView setContentOffset:CGPointMake(_imageView.frame.size.width, 0) animated:YES];
    }else{
        [scrollView setContentOffset:resultPoint animated:YES];
    }
    
}
#pragma mark -- 滚动视图的代理方法
//开始拖拽的代理方法，在此方法中暂停定时器。
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"正在拖拽视图，所以需要将自动播放暂停掉");
    //setFireDate：设置定时器在什么时间启动
    //[NSDate distantFuture]:将来的某一时刻
    [_timer setFireDate:[NSDate distantFuture]];
}

//视图静止时（没有人在拖拽），开启定时器，让自动轮播
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //视图静止之后，过1.5秒在开启定时器
    //[NSDate dateWithTimeInterval:1.5 sinceDate:[NSDate date]]  返回值为从现在时刻开始 再过1.5秒的时刻。
    NSLog(@"开启定时器");
    [_timer setFireDate:[NSDate dateWithTimeInterval:1.5 sinceDate:[NSDate date]]];
}
-(void)locationBtnClick:(UIBarButtonItem *)barButtonItem{
    
    NSLog(@"locationBtnClick");
    LocationViewController *locationVC = [[LocationViewController alloc]init];
    [locationVC setHidesBottomBarWhenPushed:YES];
    [locationVC returnText:^(NSString *cityname) {
        barButtonItem.title = cityname;
    }];
    
    [self.navigationController pushViewController:locationVC animated:YES];
}
-(void)searchBtnClick:(UIBarButtonItem *)barButtonItem{
    NSLog(@"search");
    
    SearchViewController *searchVC = [[SearchViewController alloc]init];
    
    [self.navigationController pushViewController:searchVC animated:YES];
  
    
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
