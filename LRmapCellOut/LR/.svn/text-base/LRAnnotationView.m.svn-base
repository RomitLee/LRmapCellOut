//
//  LRAnnotationView.m
//  LRmapCellOut
//
//  Created by RomitLee on 15/6/29.
//  Copyright (c) 2015年 RomitLee. All rights reserved.
//

#import "LRAnnotationView.h"
#define  Arror_height 10
@implementation LRAnnotationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/




- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}



-(id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        //self.backgroundColor = [UIColor greenColor];
        self.canShowCallout = NO;
        self.centerOffset = CGPointMake(0, -55);
        self.frame = CGRectMake(0, 0, 200, 100);
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width-15, self.frame.size.height-15)];
        
        
        [self addSubview:view];
        
        self.contentView = view;
        
    }
    return self;
    
}

//重新计算view的size
-(void)resize:(UIView *)view
{
    
    self.frame = CGRectMake(0, 0, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame));
    self.centerOffset =CGPointMake(0, -65);
    self.contentView.backgroundColor=[UIColor clearColor];
    self.contentView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
}

-(void)drawRect:(CGRect)rect{
    
//    [self drawInContext:UIGraphicsGetCurrentContext()];
    
    //阴影
//    self.layer.shadowColor = [[UIColor redColor] CGColor];
//    self.layer.shadowOpacity = 1.0;
//    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
    
}

-(void)drawInContext:(CGContextRef)context
{
    
//    CGContextSetLineWidth(context, 1.0);
//    //UIView *view=(UIView *)[[self.contentView subviews]objectAtIndex:0];
//    //CGContextSetFillColorWithColor(context, view.backgroundColor.CGColor);
//    CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
//    
//    [self getDrawPath:context];
//    CGContextFillPath(context);
    
}
- (void)getDrawPath:(CGContextRef)context
{
//    CGRect rrect = self.bounds;
//    CGFloat radius = 6.0;
//    
//    CGFloat minx = CGRectGetMinX(rrect),
//    midx = CGRectGetMidX(rrect),
//    maxx = CGRectGetMaxX(rrect);
//    CGFloat miny = CGRectGetMinY(rrect),
//    // midy = CGRectGetMidY(rrect),
//    maxy = CGRectGetMaxY(rrect)-Arror_height;
//    CGContextMoveToPoint(context, midx+Arror_height, maxy);
//    CGContextAddLineToPoint(context,midx, maxy+Arror_height);
//    CGContextAddLineToPoint(context,midx-Arror_height, maxy);
//    
//    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
//    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
//    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
//    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
//    CGContextClosePath(context);
    
    //CGContextSetRGBStrokeColor(context, 0, 0, 1, 1);//改变画笔颜色
//    CGContextAddArc(context, 50, 50, 30, 0, M_PI, 1);
//    CGContextStrokePath(context);//绘画路径
}


@end
