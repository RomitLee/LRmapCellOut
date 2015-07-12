//
//  ViewController.m
//  LRmapCellOut
//
//  Created by RomitLee on 15/6/29.
//  Copyright (c) 2015年 RomitLee. All rights reserved.
//

#import "ViewController.h"
#import "LRPointAnnoatation.h"
#import "LRAnnotationView.h"
#import "LRAnnotation.h"
#import "LRView.h"

@interface ViewController ()
{
    
    
}
@property (nonatomic,strong) BMKMapView *mapView;

@property (nonatomic,strong) LRAnnotationView *calloutMapAnnotation;

@property (nonatomic,strong) LRPointAnnoatation *pointAnntation;  //应该是个dian

@property (nonatomic,strong) LRAnnotation *annotation;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BMKMapView *map=[[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.mapView=map;
    [self.view addSubview:self.mapView];
    //self.mapView.delegate=self;
    
        // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated {
    [self.mapView viewWillAppear];
    

    self.mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    
    [self addPointAnnotation];
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//任务的视图
- (void)addPointAnnotation
{
    if (self.pointAnntation == nil) {
        self.pointAnntation = [[LRPointAnnoatation alloc]init];
        CLLocationCoordinate2D coor;
        coor.latitude = 39.915;
        coor.longitude = 116.404;
        
        self.pointAnntation.coordinate = coor;
        self.pointAnntation.title = @"test";
        self.pointAnntation.subtitle = @"此Annotation可拖拽!";
    }
    [_mapView addAnnotation:self.pointAnntation];
}



// 根据anntation生成对应的View

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    //任务的视图
    if([annotation isKindOfClass:[LRPointAnnoatation class]])
    {
        NSString *AnnotationViewID = @"renameMark";
        BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
        if (annotationView == nil) {
            annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
            annotationView.image=[UIImage imageNamed:@"poi_1.png"];
            // 设置颜色
            //annotationView.pinColor = BMKPinAnnotationColorGreen;
            // 从天上掉下效果
            annotationView.animatesDrop = YES;
            // 设置可拖拽
            annotationView.draggable = YES;
            annotationView.canShowCallout=NO;
        }
        return annotationView;
    }
    //任务被点击后的视图
    if ([annotation isKindOfClass:[LRAnnotation class]]){
        
        //此时annotation就是我们calloutview的annotation
        //LRAnnotation *ann = (LRAnnotation*)annotation;
        
        //如果可以重用
        LRAnnotationView * calloutannotationview = (LRAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"calloutview"];
        
        //否则创建新的calloutView
        if (!calloutannotationview) {
            calloutannotationview =[[LRAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"calloutview"];
            
            LRView *cell = [[[NSBundle mainBundle] loadNibNamed:@"LRView" owner:self options:nil] lastObject];
//            cell.hidden = NO;
//            calloutannotationview.autoresizesSubviews = NO;
//            UIView *cell = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
            [calloutannotationview resize:cell];
            [calloutannotationview.contentView addSubview:cell];
        }
        
        
        return calloutannotationview;
        
    }

    return nil;
    
    
}



-(void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{
    
    NSLog(@"didSelectAnnotationView");
    //CustomPointAnnotation 是自定义的marker标注点，通过这个来得到添加marker时设置的pointCalloutInfo属性
    LRPointAnnoatation *annn = (LRPointAnnoatation*)view.annotation;
    
    
    if ([view.annotation isKindOfClass:[LRPointAnnoatation class]]) {
        
     
        if (self.annotation) {
            [mapView removeAnnotation:self.annotation];
            self.annotation=nil;
            
        }
        //创建搭载自定义calloutview的annotation
        LRAnnotation *lrr = [[LRAnnotation alloc] initWithLatitude:view.annotation.coordinate.latitude andLongitude:view.annotation.coordinate.longitude];
        
        //
        CLLocationCoordinate2D coor;
        coor.latitude = 39.915;
        coor.longitude = 116.404;
        
        //lrr.coordinate = coor;
        //self.annotation.locationInfo = annn.dataInfo;
        self.annotation=lrr;
        [mapView addAnnotation:self.annotation];
        
        
        
        //[mapView setCenterCoordinate:view.annotation.coordinate animated:YES];
        
    }
    
    
}



@end
