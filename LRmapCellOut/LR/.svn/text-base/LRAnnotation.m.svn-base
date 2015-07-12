//
//  LRAnnotation.m
//  LRmapCellOut
//
//  Created by RomitLee on 15/6/29.
//  Copyright (c) 2015年 RomitLee. All rights reserved.
//

#import "LRAnnotation.h"

@implementation LRAnnotation


- (id)initWithLatitude:(CLLocationDegrees)lat
          andLongitude:(CLLocationDegrees)lon {
    if (self = [super init]) {
        self.latitude = lat;
        self.longitude = lon;
    }
    return self;
}


-(CLLocationCoordinate2D)coordinate{
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = self.latitude;
    coordinate.longitude = self.longitude;
    return coordinate;
    
    
}

@end
