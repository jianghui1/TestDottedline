//
//  ViewController.m
//  Test画虚线
//
//  Created by ys on 16/3/10.
//  Copyright © 2016年 jzh. All rights reserved.
//  只是测试

#import "ViewController.h"

#import <Masonry/Masonry.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    // 1、直接给出坐标
    // 测试画虚线
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(100, 100, 100, 100);
//    imageView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:imageView];
    
    [self drawLineToImageView:imageView];
    
    // 2、用约束给出坐标
    // 测试画虚线
    UIImageView *imageView1 = [[UIImageView alloc] init];
//    imageView1.backgroundColor = [UIColor greenColor];
    imageView1.image = [UIImage imageNamed:@"brand_img_yhq"];
    imageView1.backgroundColor = [UIColor clearColor];
    [self.view addSubview:imageView1];
    [imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(50);
        make.left.equalTo(imageView.mas_left);
        make.right.equalTo(imageView.mas_right);
        make.height.equalTo(imageView.mas_height);
    }];
//    [self drawLineToImageView:imageView1];
    UILabel *countLabel = [[UILabel alloc] init];
    countLabel.textAlignment = NSTextAlignmentCenter;
    NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%d", 5]];
    [aStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.f] range:NSMakeRange(0, 1)];
    [aStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.f] range:NSMakeRange(1, aStr.length - 1)];
    [aStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, aStr.length)];
    [countLabel setAttributedText:aStr];
    [imageView1 addSubview:countLabel];
    [countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView1.mas_left);
        make.top.equalTo(imageView1.mas_top);
        make.right.equalTo(imageView1.mas_centerX).offset(8);
        make.bottom.equalTo(imageView1.mas_bottom);
    }];
    
    // 虚线
    UIImageView *lineView = [[UIImageView alloc] init];
//        lineView.backgroundColor = [UIColor yellowColor];
    [imageView1 addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView1.mas_top).offset(5);
//        make.bottom.equalTo(imageView1.mas_bottom);
        make.height.equalTo(imageView1.mas_height);
        make.width.equalTo(@50);
        make.left.equalTo(countLabel.mas_right).offset(2);
    }];
    UIGraphicsBeginImageContext(lineView.frame.size);   //开始画线
    [lineView.image drawInRect:CGRectMake(5, 0, lineView.frame.size.width, lineView.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
    CGFloat lengths[] = {4,5};
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, [UIColor whiteColor].CGColor);
    CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
    CGContextMoveToPoint(line, 10, 5);    //开始画线
    CGContextAddLineToPoint(line,lineView.frame.size.width,lineView.frame.size.height - 5);
    CGContextStrokePath(line);
    lineView.image = UIGraphicsGetImageFromCurrentImageContext();
}

- (void)drawLineToImageView:(UIImageView *)imageView
{
    
    UIGraphicsBeginImageContext(imageView.frame.size);   //开始画线
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
    CGFloat lengths[] = {10,10};
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, [UIColor whiteColor].CGColor);
    CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
    CGContextMoveToPoint(line, 0, 0);    //开始画线
    CGContextAddLineToPoint(line,0,imageView.frame.size.height);
    CGContextStrokePath(line);
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
}

@end
