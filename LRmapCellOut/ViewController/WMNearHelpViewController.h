//
//  WMNearHelpViewController.h
//  YouZhu
//
//  Created by RomitLee on 15/6/25.
//  Copyright (c) 2015年 wumeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI/BMapKit.h>
#import <BaiduMapAPI/BMKLocationService.h>

@interface WMNearHelpViewController : UIViewController<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>


@end
