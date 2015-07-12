//
//  WMNearHelpViewController.m
//  YouZhu
//
//  Created by RomitLee on 15/6/25.
//  Copyright (c) 2015年 wumeng. All rights reserved.
//

#import "WMNearHelpViewController.h"
#import "LRPointAnnoatation.h"
#import "LRAnnotationView.h"
#import "LRAnnotation.h"
#import "LRView.h"
#import "LRHelpHeadImageView.h"
#import "LRHelpHead.h"



//#import ""

@interface WMNearHelpViewController ()
@property (nonatomic,strong) BMKMapView *mapView;
@property (nonatomic,strong) BMKLocationService *locationService;
@property (nonatomic,strong) BMKPointAnnotation *usertPoint;  //用户的坐标点


@property (nonatomic,strong) LRAnnotationView *calloutMapAnnotation; //任务点击后的 视图



@property (nonatomic,strong) LRAnnotation *annotation;//任务点击的后的信息点

@property (nonatomic,strong) BMKPinAnnotationView *userView;  //定位的坐标点，有且只有一个，所以点击后 可以做排除不用弹出任务简介

@end

@implementation WMNearHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    //self.titleLB.text=@"地图";
    
    [self initMap];
    //self.canDrag = NO;
 
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    self.mapView.delegate=self;
    self.locationService.delegate=self;
   
    [self startLocation];
    
   
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    //self.canDrag = YES;
}
-(void) initMap
{
    BMKMapView *mapview=[[BMKMapView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height-64)];
    [self.view addSubview:mapview];
    
    self.mapView=mapview;
     self.mapView.zoomLevel=19;
    BMKLocationService *location=[[BMKLocationService alloc]init];
    
    self.locationService=location;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)startLocation
{
    if ([WMNearHelpViewController locationServiceEnabled]) {
        [self.locationService startUserLocationService];
        //[_LocationService startUserLocationService];
        _mapView.showsUserLocation = NO;//先关闭显示的定位图层
        _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
        _mapView.showMapScaleBar = YES;
        _mapView.mapType =BMKMapTypeStandard;
        [BMKLocationService setLocationDistanceFilter:10];
        [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"打开“定位服务”来允许“我”确定您的位置" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alert show];
    }
    
}

+(BOOL)locationServiceEnabled{
    BOOL  locationServicesEnabled = NO;
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    [locationManager startUpdatingLocation];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
        locationServicesEnabled =  [CLLocationManager locationServicesEnabled];
    }else{
        if ([CLLocationManager authorizationStatus]!=kCLAuthorizationStatusDenied) {
            //   NSLog(@"应用没有被关闭定位功能");
            locationServicesEnabled = YES;
        }else{
            //  NSLog(@"应用没被授权打开定位功能");
            locationServicesEnabled = YES;
        }
    }
    return locationServicesEnabled;
}




/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    [_mapView setRegion:BMKCoordinateRegionMake(userLocation.location.coordinate , BMKCoordinateSpanMake(0.1, 0.1)) animated:YES];
}
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation;
{
    NSLog(@"%s",__FUNCTION__);
    [_mapView updateLocationData:userLocation];
    //[_mapView setRegion:BMKCoordinateRegionMake(userLocation.location.coordinate , BMKCoordinateSpanMake(0.1, 0.1)) animated:YES];
    //原始经纬度和百度经纬度
    _mapView.centerCoordinate=userLocation.location.coordinate;
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = userLocation.location.coordinate;
    BMKGeoCodeSearch *geocodesearch = [[BMKGeoCodeSearch alloc] init];
    geocodesearch.delegate = self;
    BOOL flag = [geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag)
    {
        NSLog(@"用户定位检索地址成功");
        [self.locationService stopUserLocationService];
    }
    else
    {
      
    }
    
}
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error) {
//
    }else{
        
        
        //添加任务的视图信息函数
       
            //NSArray *helpData=[response objectForKey:@"list"];
//            for (NSDictionary *dic in helpData) {
//                
//                LRPointAnnoatation *helppoint = [[LRPointAnnoatation alloc]init];
//                
//                helppoint.dataInfo=dic;
//                
//                
//                helppoint.title = @"123";
//                helppoint.subtitle = @"312";
//                
//                CLLocationCoordinate2D coor;
//                coor.latitude=[[dic objectForKey:@"task_lat"]doubleValue];
//                coor.longitude=[[dic objectForKey:@"task_lon"]doubleValue];
//                helppoint.coordinate=coor;
//                [_mapView addAnnotation:helppoint];
//            }

            
            
        
        
        
        
        
        
        
        //添加个人的坐标点
        BMKPointAnnotation *point=[[BMKPointAnnotation alloc]init];
        point.coordinate=result.location;
        point.title=result.address;
        point.subtitle=@"";
        
        [self.mapView addAnnotation:point];
        
    }
}





- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    
    //任务的视图
    if([annotation isKindOfClass:[LRPointAnnoatation class]])
    {
        LRPointAnnoatation *point=(LRPointAnnoatation *)annotation;
        NSString *AnnotationViewID = @"helpPoint";
        LRHelpHeadImageView *annotationView = (LRHelpHeadImageView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
        if (annotationView == nil) {
            annotationView = [[LRHelpHeadImageView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
            
            annotationView.image=[UIImage imageNamed:@"nearHelp_ghsd"];
            
            annotationView.datainfo=point.dataInfo;
            annotationView.draggable = YES;
            annotationView.canShowCallout=NO;
            //self.userView=annotationView;

            
        }
        return annotationView;
    }
    //任务被点击后的视图
    if([annotation isKindOfClass:[LRAnnotation class]])
    {
        LRAnnotation *ann=(LRAnnotation *)annotation;
        NSString *AnnotationViewID = @"helpAlert";
        LRAnnotationView *annotationView = (LRAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
        
            annotationView =[[LRAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"helpAlert"];
            
            LRView *cell = [[[NSBundle mainBundle] loadNibNamed:@"LRView" owner:self options:nil] lastObject];
            
           // [cell.headImage sd_setImageWithURL:[NSURL URLWithString:[ann.locationInfo objectForKey:@"release_user_avater"]]];
            cell.address.text=[ann.locationInfo objectForKey:@"task_address"];
            annotationView.dateInfo=ann.locationInfo;
            [annotationView resize:cell];
            [annotationView.contentView addSubview:cell];
            self.calloutMapAnnotation=annotationView;
            
            NSLog(@"ann:%@",ann);
        
        return self.calloutMapAnnotation;
    }
    //个人的视图
    if([annotation isKindOfClass:[BMKPointAnnotation class]])
    {
        NSString *AnnotationViewID = @"userPoint";
        BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
        if (annotationView == nil) {
            annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
            annotationView.image=[UIImage imageNamed:@"nearHelp_ghfgh"];
            // 设置颜色
            
            // 从天上掉下效果
            annotationView.animatesDrop = NO;
            annotationView.draggable = YES;
            annotationView.canShowCallout=YES;
            self.userView=annotationView;
        }
        return self.userView;
    }
    
    return nil;
}


- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    if([view isKindOfClass:[LRHelpHeadImageView class]])
    {
        if (self.annotation) {
            [mapView removeAnnotation:self.annotation];
            self.annotation=nil;
            
        }
        LRHelpHeadImageView *gouride=(LRHelpHeadImageView *)view;
        //创建搭载自定义calloutview的annotation
        LRAnnotation *lrr = [[LRAnnotation alloc] initWithLatitude:view.annotation.coordinate.latitude andLongitude:view.annotation.coordinate.longitude];
        
        lrr.locationInfo=gouride.datainfo;
        self.annotation=lrr;
        
        [mapView addAnnotation:self.annotation];

    }
    if([view isKindOfClass:[LRAnnotationView class]])
    {
        LRAnnotationView *ann=(LRAnnotationView *)view;
        
       // WMTaskDetailVC *vc = [WMTaskDetailVC new];
        CLLocationCoordinate2D sb;
        sb.latitude=[[ann.dateInfo objectForKey:@"task_lat"]doubleValue];
        sb.longitude=[[ann.dateInfo objectForKey:@"task_lon"]doubleValue];
        
//        vc.coor = sb;
//        WMTaskModel *model=[WMTaskModel new];
//        model.task_id=[[ann.dateInfo objectForKey:@"task_id"]integerValue];
//        vc.taskmodel = model;
//        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

// 当点击annotation view弹出的泡泡时，调用此接口
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view;
{
    NSLog(@"paopaoclick");
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
