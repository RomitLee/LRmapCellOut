//
//  LRAnnotationView.h
//  LRmapCellOut
//
//  Created by RomitLee on 15/6/29.
//  Copyright (c) 2015年 RomitLee. All rights reserved.
//


#import <BaiduMapAPI/BMKAnnotationView.h>

@interface LRAnnotationView : BMKAnnotationView


@property(nonatomic,retain) UIView *contentView;
@property (nonatomic,strong) NSDictionary *dateInfo;
//添加一个UIView

//重新计算size
-(void)resize:(UIView *)view;

@end
