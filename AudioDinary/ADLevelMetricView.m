//
//  ADLevelMetricView.m
//  AudioDinary
//
//  Created by Chen Duanjin on 9/19/13.
//  Copyright (c) 2013 iLife. All rights reserved.
//

#import "ADLevelMetricView.h"

#define SPOT_NUMBER_ROW 22
#define SPOT_NUMBER_COL 22
#define SPOT_RECT_SIZE 10
#define SPOT_RECT_DIS 4;

@interface ADLevelMetricView()
{
    NSMutableArray* rectMetric;
    
    int rows;
    int cols;
}
@end

@implementation ADLevelMetricView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self initArrayWithRect:rect];
   
    for (int i = 0; i < cols; ++i) {
        for (int j = 0; j < rows; ++j) {
            CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);
            if ( i < cols / 2) {
                if (j < [[self.volumArray objectAtIndex:i] intValue]) 
                    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
            }
            else{
                if (j < [[self.volumArray objectAtIndex:cols-i-1] intValue]) {
                    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
                }
            }
      
            
            CGContextFillEllipseInRect(context, [[rectMetric objectAtIndex:i * rows + j] CGRectValue]);
            CGContextStrokeEllipseInRect(context, [[rectMetric objectAtIndex:i * rows + j] CGRectValue]);
            
        }
    } 

}

-(void)initArrayWithRect:(CGRect)rect
{
    float width = rect.size.width;
    float height = rect.size.height;
    float rect_size = SPOT_RECT_SIZE + SPOT_RECT_DIS;
    cols = width / rect_size;
    if (cols % 2 !=0) {
        cols = cols - 1;
    }
    self.arrayLength = cols;
    rows = height / rect_size;
    
    float padding = width - cols * rect_size;
    if (rectMetric == nil) {
        rectMetric = [[NSMutableArray alloc] initWithCapacity:rows * cols];
        for (int i = 0; i < cols; ++i) {
            for (int j = 0; j < rows; ++j) {
                float x = padding / 2.0 + i * SPOT_RECT_SIZE  + i * SPOT_RECT_DIS;
                float y = height - j * SPOT_RECT_SIZE - j * SPOT_RECT_DIS;
                CGRect lrect = CGRectMake( x ,y,
                                          SPOT_RECT_SIZE,
                                          SPOT_RECT_SIZE);
                [rectMetric addObject:[NSValue valueWithCGRect:lrect]];
            }
        }
    }
    else return;
}


@end
